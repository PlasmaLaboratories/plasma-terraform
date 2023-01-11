provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "custom" {
  name                    = var.compute_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "custom" {
  provider = google-beta

  name          = var.subnetwork_name
  ip_cidr_range = var.subnetwork_cidr_range
  region        = var.region
  network       = google_compute_network.custom.id

  stack_type       = var.stack_type
  ipv6_access_type = var.ipv6_access_type

  private_ip_google_access   = true
  private_ipv6_google_access = "ENABLE_OUTBOUND_VM_ACCESS_TO_GOOGLE"

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = var.services_ip_cidr_range
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = var.pods_ip_cidr_range
  }

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_router" "router" {
  name    = format("%s-router", var.container_cluster_name)
  region  = var.region
  network = google_compute_network.custom.self_link
}

resource "google_compute_router_nat" "nat" {
  name = format("%s-nat", var.container_cluster_name)

  router = google_compute_router.router.name
  region = google_compute_router.router.region

  # For this example project just use IPs allocated automatically by GCP.
  nat_ip_allocate_option = "AUTO_ONLY"
  # Apply NAT to all IP ranges in the subnetwork.
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  # TODO: Fine tune control of allocated IPs to only allow traffic to services we want exposed.
  # "Manually" define the subnetworks for which the NAT is used, so that we can exclude the public subnetwork
  # source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  # subnetwork {
  #   name                    = google_compute_subnetwork.custom.self_link
  #   source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  # }

  log_config {
    enable = true
    filter = "ALL" #TODO: Swap to ERRORS_ONLY after testing.
  }
}

resource "google_container_cluster" "primary" {
  # checkov:skip=CKV_GCP_24: Pod security policy is deprecated in GKE. Recommended way is to use PodSecurity controller. TODO: Implement a modern controller like Gatekeeper.
  # checkov:skip=CKV_GCP_18: We are using master authorized networks, so this is unnecessary.
  # checkov:skip=CKV_GCP_12: Dataplane V2 does not need network policy to be enabled: https://cloud.google.com/kubernetes-engine/docs/how-to/dataplane-v2
  # checkov:skip=CKV_GCP_21: No need for labels just yet.
  # checkov:skip=CKV_GCP_69: Check is outdated, new check uses mode = .
  # checkov:skip=CKV_GCP_66: This option is deprecated. Use binary_authorization instead: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#nested_binary_authorization.
  provider = google-beta

  name     = var.container_cluster_name
  location = var.primary_cluster_location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  initial_node_count       = 1
  remove_default_node_pool = true

  network    = google_compute_network.custom.id
  subnetwork = google_compute_subnetwork.custom.id

  # networking_mode = var.enable_vpc_native "VPC_NATIVE"
  datapath_provider = var.enable_dataplane_v2 ? "ADVANCED_DATAPATH" : "DATAPATH_PROVIDER_UNSPECIFIED"

  # To enable VPC flow logs.
  enable_intranode_visibility = true

  min_master_version = 1.22

  private_cluster_config {
    enable_private_nodes    = var.enable_private_nodes
    enable_private_endpoint = var.enable_private_endpoint
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "Public access"
    }
  }

  authenticator_groups_config {
    security_group = var.gke_security_groups
  }

  release_channel {
    channel = "REGULAR"
  }

  binary_authorization {
    evaluation_mode = var.enable_binary_authorization ? "PROJECT_SINGLETON_POLICY_ENFORCE" : "DISABLED"
  }

  vertical_pod_autoscaling {
    enabled = var.enable_vertical_pod_autoscaling
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "services-range"
    services_secondary_range_name = "pod-ranges"
  }

  addons_config {
    gcp_filestore_csi_driver_config {
      enabled = true
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  node_config {
    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }
}

resource "google_container_node_pool" "primary_node_pool" {
  name     = var.container_node_pool_name
  location = var.node_pool_location
  cluster  = google_container_cluster.primary.name

  autoscaling {
    min_node_count = var.container_node_pool_autoscale_min_node_count
    max_node_count = var.container_node_pool_autoscale_max_node_count
  }

  node_config {
    # https://cloud.google.com/kubernetes-engine/docs/how-to/preemptible-vms
    preemptible  = var.container_node_pool_preemptible
    machine_type = var.container_node_pool_machine_type
    image_type   = "COS_CONTAINERD"

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  depends_on = [
    google_container_cluster.primary
  ]
}

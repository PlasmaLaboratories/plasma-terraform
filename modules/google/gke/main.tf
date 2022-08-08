provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "custom" {
  name                    = var.compute_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "custom" {
  name          = var.subnetwork_name
  ip_cidr_range = var.subnetwork_cidr_range
  region        = var.region
  network       = google_compute_network.custom.id

  stack_type = var.stack_type
  ipv6_access_type = var.ipv6_access_type

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = var.services_ip_cidr_range
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = var.pods_ip_cidr_range
  }
}

resource "google_container_cluster" "primary" {
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

  ip_allocation_policy {
    cluster_secondary_range_name  = "services-range"
    services_secondary_range_name = "pod-ranges"
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

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  depends_on = [
    google_container_cluster.primary
  ]
}

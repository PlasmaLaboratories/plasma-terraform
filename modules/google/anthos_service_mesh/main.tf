provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host = "https://${data.google_container_cluster.primary.endpoint}"

  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

module "asm" {
  source                    = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  project_id                = var.project_id
  cluster_name              = var.cluster_name
  cluster_location          = var.region
  multicluster_mode         = var.multicluster_mode
  enable_cni                = var.enable_cni
  enable_mesh_feature       = var.enable_mesh_feature
  enable_fleet_registration = var.enable_fleet_registration
}
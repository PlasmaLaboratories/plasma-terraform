provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${var.gke_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(var.gke_ca_certificate)
}

module "asm" {
  source                    = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  version                   = "~> 25.0"
  project_id                = var.project_id
  cluster_name              = var.cluster_name
  cluster_location          = var.region
  multicluster_mode         = var.multicluster_mode
  enable_cni                = var.enable_cni
  enable_mesh_feature       = var.enable_mesh_feature
  enable_fleet_registration = var.enable_fleet_registration
}

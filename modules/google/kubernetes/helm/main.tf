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

provider "helm" {
  kubernetes {
    host                   = "https://${var.gke_endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(var.gke_ca_certificate)
  }
}

# Argo CD
resource "helm_release" "release" {
  name             = var.helm_release_name
  repository       = var.helm_repository
  chart            = var.helm_chart
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = true
  cleanup_on_fail  = true

  values = [
    file(var.values_yaml_file)
  ]
}

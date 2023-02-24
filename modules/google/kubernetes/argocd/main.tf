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

# Additional products to install into the cluster
provider "helm" {
  kubernetes {
    host                   = "https://${var.gke_endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(var.gke_ca_certificate)
  }
}

# Argo CD
resource "helm_release" "argo_cd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.16.0" # https://github.com/argoproj/argo-helm/releases
  namespace        = "argocd"
  create_namespace = true
  cleanup_on_fail  = true

  values = [
    file(var.argo_cd_values_yaml_file)
  ]
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

data "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host     = "https://${data.google_container_cluster.primary.endpoint}"

  token = "${data.google_client_config.default.access_token}"
  cluster_ca_certificate = "${base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)}"
}

# Additional products to install into the cluster
provider "helm" {
  kubernetes {
     host     = "https://${data.google_container_cluster.primary.endpoint}"

    token = "${data.google_client_config.default.access_token}"
    cluster_ca_certificate = "${base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)}"
  }
}

# Argo CD
resource "helm_release" "argo_cd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.16.0" # https://github.com/argoproj/argo-helm/releases
  namespace  = "argocd"
  create_namespace = true
  cleanup_on_fail = true

  values = [
    file(var.argo_cd_values_yaml_file)
  ]
}

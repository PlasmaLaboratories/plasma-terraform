variable "project_id" {
  type        = string
  description = "Id for the Google Cloud project."
}

variable "region" {
  type        = string
  default     = ""
  description = "Region where the GCP project lives."
}

variable "gke_endpoint" {
  type        = string
  description = "Endpoint of the GKE cluster."
}

variable "gke_ca_certificate" {
  type        = string
  description = "Encoded CA certificate of the GKE cluster."
}

# Helm variables
variable "helm_release_name" {
  type        = string
  description = "Name of the Helm release. ex: argocd"
}

variable "helm_repository" {
  type        = string
  default     = null
  description = "Repository the Helm chart is published under. ex: https://argoproj.github.io/argo-helm"
}

variable "helm_chart" {
  type        = string
  description = "Name of the Helm chart in the repository. Can also be a path to a Git repo. ex: argo-cd"
}

variable "chart_version" {
  type        = string
  default     = null
  description = "Version of the Helm chart. ex: 5.53.9"
}

variable "namespace" {
  type        = string
  description = "Namespace to deploy the Helm chart in. ex: argocd"
}



variable "values_yaml_file" {
  type        = string
  default     = ""
  description = "Path to the values.yaml file for ArgoCD. https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/values.yaml"
}

variable "cluster_name" {
  type        = string
  default     = ""
  description = "Name of the k8s cluster to authenticate to."
}

variable "project_id" {
  type        = string
  description = "Id for the Google Cloud project."
}

variable "region" {
  type        = string
  default     = ""
  description = "Region where the GCP project lives."
}

# Helm Values
variable "argo_cd_values_yaml_file" {
  type        = string
  default     = ""
  description = "Path to the values.yaml file for ArgoCD. https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/values.yaml"
}
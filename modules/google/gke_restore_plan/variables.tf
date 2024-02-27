variable "project_id" {
  type        = string
  description = "Id for the Google Cloud project."
}

variable "location" {
  type        = string
  default     = "us-central1"
  description = "Location for the resources."
}

variable "plan_name" {
  type        = string
  description = "Name of the backup plan."
}

variable "backup_plan_id" {
  type        = string
  description = "ID of the GKE Backup Plan."
}

variable "kubernetes_cluster_id" {
  type        = string
  description = "ID of the GKE cluster."
}

variable "selected_group_kinds" {
  type = list(map(string))
  default = [
    {
      resource_group = "apiextension.k8s.io"
      resource_kind  = "CustomResourceDefinition"
    },
    {
      resource_group = "storage.k8s.io"
      resource_kind  = "StorageClass"
    },
  ]
  description = "List of "
}

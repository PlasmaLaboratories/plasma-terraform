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

variable "kubernetes_cluster_id" {
  type        = string
  description = "ID of the GKE cluster."
}

variable "namespaces" {
  type        = list(string)
  description = "List of namespaces to include in the backup plan."
}

variable "cron_schedule" {
  type        = string
  default     = "0 6 * * *"
  description = "Cron schedule for the backup plan."
}

variable "delete_lock_days" {
  type        = number
  default     = 7
  description = "How many days to prevent deletion of the backups."
}

variable "retain_days" {
  type        = number
  default     = 30
  description = "How many days to retain the backups."
}

variable "kms_key_id" {
  type        = string
  description = "ID of the KMS key for encryption."
}

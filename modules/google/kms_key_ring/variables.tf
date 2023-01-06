variable "key_ring_name" {
  type        = string
  default     = "shared-keyring"
  description = "Name of the key ring."
}

variable "key_location" {
  type        = string
  default     = "global"
  description = "https://cloud.google.com/kms/docs/locations"
}

variable "project_id" {
  type        = string
  description = "id of the project."
}

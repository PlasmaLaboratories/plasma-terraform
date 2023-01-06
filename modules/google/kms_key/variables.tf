variable "key_ring_name" {
  type        = string
  default     = "shared-keyring"
  description = "Name of the key ring."
}

variable "key_ring_id" {
  type        = string
  description = "ID of the key ring."
}

variable "kms_key_name" {
  type        = string
  default     = "kms-key"
  description = "Name for the kms key."
}

variable "key_location" {
  type        = string
  default     = "global"
  description = "https://cloud.google.com/kms/docs/locations"
}

variable "purpose" {
  type        = string
  default     = "ENCRYPT_DECRYPT"
  description = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key#purpose"
}

variable "algorithm" {
  type        = string
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
  description = "https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm"
}

variable "rotation_period" {
  type        = string
  default     = "7776000s" # Every 90 days
  description = "Period to automatically rotate keys. Not usable for purpose: ASYMMETRIC_SIGN."
}

variable "project_id" {
  type        = string
  description = "id of the project."
}

variable "project_number" {
  type        = string
  description = "Number of the project."
}

variable "create_artifact_registry_iam_binding" {
  type        = bool
  default     = false
  description = "Create the GCP binding to allow the Artifact Registry account to encrypt/decrypt using this key."
}

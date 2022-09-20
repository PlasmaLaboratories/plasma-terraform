variable "key_ring_name" {
  type        = string
  default     = "shared-keyring"
  description = "Name of the key ring."
}

variable "kms_key_name" {
  type        = string
  default     = "kms-key"
  description = "Name for the kms key."
}

variable "purpose" {
  type        = string
  default     = "ASYMMETRIC_SIGN"
  description = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key#purpose"
}

variable "algorithm" {
  type        = string
  default     = "EC_SIGN_P384_SHA384"
  description = "https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm"
}

variable "rotation_period" {
  type        = string
  default     = "100000s"
  description = "Period to automatically rotate keys. Not usable for purpose: ASYMMETRIC_SIGN."
}

variable "project_id" {
  type        = string
  description = "id of the project."
}

variable "key_ring_id" {
  type        = string
  description = "ID of the key ring."
}

variable "kms_key_name" {
  type        = string
  default     = "kms-key"
  description = "Name for the kms key."
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

variable "service_account_bindings" {
  type = set(string)

  description = "List of service accounts to bind to this key."
}

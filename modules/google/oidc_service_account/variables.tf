variable "project_id" {
  type        = string
  description = "The project id where the OIDC provider, pool, and service account will be created under."
}

variable "pool_id" {
  type        = string
  default     = "oidc-pool"
  description = "Name for the OIDC pool."
}

variable "provider_id" {
  type        = string
  default     = "oidc-provider"
  description = "Name for the OIDC provider."
}

variable "sa_mapping" {
  type = map(object({
    sa_name   = string
    attribute = string
  }))
  description = "Service Account resource names and corresponding WIF provider attributes. If attribute is set to `*` all identities in the pool are granted access to SAs."
  default     = {}
}

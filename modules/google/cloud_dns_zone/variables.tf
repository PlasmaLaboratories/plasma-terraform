variable "project_id" {
  type        = string
  description = "ID of the project in GCP."
}

variable "zone_name" {
  type        = string
  description = "Name of the Cloud DNS Zone object in GCP."
}

variable "dns_name" {
  type        = string
  description = "Name of the domain/subdomain managed in Cloud DNS."
}

variable "description" {
  type        = string
  default     = "Terraform managed DNS zone."
  description = "Description for the DNS zone."
}

variable "project_id" {
  type        = string
  description = "Id for the Google Cloud project."
}

variable "repository_id" {
  type        = string
  description = "Name for the generated repo."
}

variable "location" {
  type        = string
  default     = "us-south1"
  description = "Location for the Artifact repo."
}

variable "format" {
  type        = string
  default     = "docker"
  description = "Which type of artifact repo to create. (ex: docker)."
}

variable "kms_key_name" {
  type        = string
  description = "KMS encryption key for artifact registry."
}

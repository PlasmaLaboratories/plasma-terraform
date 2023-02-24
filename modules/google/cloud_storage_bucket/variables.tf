variable "project_id" {
  type        = string
  description = "ID of the project in GCP."
}

variable "storage_bucket_name" {
  type        = string
  description = "The name of the bucket"
}

variable "storage_bucket_location" {
  type        = string
  description = "The Location of the GCS"
}

variable "storage_class" {
  type        = string
  description = "The storage class of the bucket created https://cloud.google.com/storage/docs/storage-classes"
}

variable "lifecycle_rules" {
  type = list(object({
    action    = any
    condition = any
  }))
  description = "Specifies the bucket's Lifecycle Rules configuration."
}

variable "versioning" {
  type        = bool
  description = "Enable versioning for the bucket created."
}

variable "cors" {
  type = object({
    origin          = string
    method          = list(string)
    response_header = list(string)
    max_age_seconds = number

  })
  description = "Specifies CORS configuration of the storage bucket."
}

variable "retention_policy" {
  type = object({
    is_locked        = bool
    retention_period = number
  })
  description = "Configures the bucket retention policy which defines the duration the objects in the bucket will be retained."
}

variable "logging" {
  type = object({
    log_bucket        = string
    log_object_prefix = string
  })
  description = "Bucket's access and storage logs configuration."
  default     = null
}

variable "labels" {
  type        = map(string)
  description = "A map of key/value label pairs to assign to the bucket."
  default = {
    "managed-by" = "terraform"
  }
}

variable "uniform_bucket_level_access" {
  type        = bool
  description = "If set to true, enables uniform bucket-level access to the bucket."
}

variable "public_access_prevention" {
  type        = string
  description = "Prevents public access to a bucket. Acceptable values are `inherited` or `enforced`"
}

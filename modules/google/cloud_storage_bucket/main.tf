/***************************************************************************
Google Storage Bucket module
****************************************************************************/
provider "google" {
  project = var.project_id
}

resource "google_storage_bucket" "bucket" {
  name                        = var.storage_bucket_name
  location                    = var.storage_bucket_location
  storage_class               = var.storage_class
  labels                      = var.labels
  uniform_bucket_level_access = var.uniform_bucket_level_access
  public_access_prevention    = var.public_access_prevention


  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules == null ? [] : var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rules.action.type
        storage_class = lifecycle_rules.action.storage_class
      }
      condition {
        age                        = lifecycle_rules.condition.age
        created_before             = lifecycle_rules.condition.created_before
        with_state                 = lifecycle_rules.condition.with_state
        matches_storage_class      = lifecycle_rules.condition.matches_storage_class
        matches_prefix             = lifecycle_rules.condition.matches_prefix
        matches_suffix             = lifecycle_rules.condition.matches_suffix
        num_newer_versions         = lifecycle_rules.condition.num_newer_versions
        custom_time_before         = lifecycle_rules.condition.custom_time_before
        days_since_custom_time     = lifecycle_rules.condition.days_since_custom_time
        days_since_noncurrent_time = lifecycle_rules.condition.days_since_noncurrent_time
        noncurrent_time_before     = lifecycle_rules.condition.noncurrent_time_before
      }
    }
  }

  versioning {
    enabled = var.versioning
  }

  dynamic "cors" {
    for_each = var.cors == null ? [] : [var.cors]
    content {
      origin          = cors.origin
      method          = cors.method
      response_header = cors.response_header
      max_age_seconds = cors.max_age_seconds
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [var.retention_policy]
    content {
      is_locked        = retention_policy.is_locked
      retention_period = retention_policy.retention_period
    }
  }

  dynamic "logging" {
    for_each = var.logging == null ? [] : [var.logging]
    content {
      log_bucket        = logging.log_bucket
      log_object_prefix = logging.log_object_prefix
    }
  }

}
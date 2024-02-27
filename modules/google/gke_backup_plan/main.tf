provider "google" {
  project = var.project_id
  region  = var.location
}

resource "google_gke_backup_backup_plan" "cmek" {
  name     = var.plan_name
  cluster  = var.kubernetes_cluster_id
  location = var.location

  retention_policy {
    backup_delete_lock_days = var.delete_lock_days
    backup_retain_days      = var.retain_days
  }

  backup_schedule {
    cron_schedule = var.cron_schedule
  }

  backup_config {
    include_volume_data = true
    include_secrets     = true


    selected_namespaces {
      namespaces = var.namespaces
    }

    # This is used for ProtectedApplication resources, but it currently is pretty limited.
    # selected_applications {
    #   dynamic "namespaced_names" {
    #     for_each = var.selected_applications
    #     content {
    #       name = namespaced_names.value["name"]
    #       namespace = namespaced_names.value["namespace"]
    #     }
    #   }
    # }

    encryption_key {
      gcp_kms_encryption_key = var.kms_key_id
    }
  }
}

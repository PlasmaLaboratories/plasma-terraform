provider "google" {
  project = var.project_id
  region  = var.location
}

resource "google_gke_backup_restore_plan" "all_ns" {
  name     = var.plan_name
  location = var.location

  backup_plan = var.backup_plan_id
  cluster     = var.kubernetes_cluster_id

  restore_config {
    all_namespaces                   = true
    namespaced_resource_restore_mode = "FAIL_ON_CONFLICT"
    volume_data_restore_policy       = "RESTORE_VOLUME_DATA_FROM_BACKUP"
    cluster_resource_restore_scope {
      dynamic "selected_group_kinds" {
        for_each = var.selected_group_kinds
        content {
          resource_group = selected_group_kinds.value["resource_group"]
          resource_kind  = selected_group_kinds.value["resource_kind"]
        }
      }
    }
    cluster_resource_conflict_policy = "USE_EXISTING_VERSION"
  }
}

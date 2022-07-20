resource "google_service_account" "sa" {
  project    = var.project_id
  account_id = var.account_id
}

resource "google_project_iam_member" "project" {
  for_each = var.project_roles

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_folder_iam_member" "folder" {
  for_each = var.folder_roles

  folder = var.folder_name
  role   = each.key
  member = "serviceAccount:${google_service_account.sa.email}"
}

module "oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = var.pool_id
  provider_id = var.provider_id
  sa_mapping = {
    (google_service_account.sa.account_id) = {
      sa_name   = google_service_account.sa.name
      attribute = "attribute.repository/Topl/GitOps"
    }
  }
}

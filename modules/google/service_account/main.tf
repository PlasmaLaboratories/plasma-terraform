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

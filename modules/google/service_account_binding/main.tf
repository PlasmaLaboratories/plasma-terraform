provider "google" {
  project = var.project_id
}

resource "google_service_account_iam_binding" "admin-account-iam" {
  for_each = var.roles

  service_account_id = var.service_account_name
  role               = each.key

  members = var.members
}

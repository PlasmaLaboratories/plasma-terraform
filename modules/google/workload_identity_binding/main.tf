provider "google" {
  project = var.project_id
}

resource "google_service_account_iam_member" "sa_member" {
  for_each = var.members

  service_account_id = var.service_account_name
  role               = var.role
  member             = each.key
}

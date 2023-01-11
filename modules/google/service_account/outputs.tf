output "sa_email" {
  description = "Example SA email"
  value       = google_service_account.sa.email
}

output "account_id" {
  description = "ID for the service account."
  value       = google_service_account.sa.account_id
}

output "sa_name" {
  value = google_service_account.sa.name
}

output "repo_attribute" {
  value = var.repo_attribute
}

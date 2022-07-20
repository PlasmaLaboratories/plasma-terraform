output "id" {
  value       = google_project.project.id
  sensitive   = false
  description = "Full ID for the project (ex: projects/my-project-id)"
  depends_on  = []
}

output "project_id" {
  value       = google_project.project.project_id
  sensitive   = false
  description = "Just the project part of the id (ex: my-project-id)."
  depends_on  = []
}

output "number" {
  value       = google_project.project.number
  sensitive   = false
  description = "Numberic ID for the project (ex: 1234567890123)."
  depends_on  = []
}

output "folder_name" {
  value       = google_folder.folder.name
  sensitive   = false
  description = "Full name of the folder (ex: folders/123456789012)."
  depends_on  = []
}

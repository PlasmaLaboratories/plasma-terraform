output "url" {
  description = "The base URL of the storage bucket"
  value       = google_storage_bucket.bucket.url
}

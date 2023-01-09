provider "google" {
  project = var.project_id
}

resource "google_dns_managed_zone" "zone" {
  name        = var.zone_name
  dns_name    = var.dns_name
  description = var.description

  dnssec_config {
    state = "on"
  }
}

data "google_dns_keys" "keys" {
  managed_zone = google_dns_managed_zone.zone.id
}

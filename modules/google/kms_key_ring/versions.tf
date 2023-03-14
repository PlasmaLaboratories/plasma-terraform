terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.52.0"
    }
    google-beta = {
      source  = "hashicorp/google"
      version = "4.52.0"
    }
  }
}

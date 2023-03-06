terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.55.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
}

resource "google_artifact_registry_repository" "aasf-web" {
  location      = var.region
  repository_id = var.repo_id
  description   = var.repo_desc
  format        = "DOCKER"
}



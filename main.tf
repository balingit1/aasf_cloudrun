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

module "gcloud" {
  source  = "terraform-google-modules/gcloud/google"
  version = "3.1.2"

  platform = "linux"

  create_cmd_entrypoint  = "gcloud"
  create_cmd_body        = "builds submit ${var.docker_source} --region=${var.region} --tag ${var.region}-docker.pkg.dev/${var.project}/${var.repo_id}/${var.docker_image}:${var.tag1}"
  destroy_cmd_entrypoint = "gcloud"
  destroy_cmd_body       = "artifacts docker images delete ${var.region}-docker.pkg.dev/${var.project}/${var.repo_id}/${var.docker_image}:${var.tag1}"
}

resource "google_cloud_run_service" "default" {
  name     = var.cloudrun_service
  location = var.region

  template {
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project}/${var.repo_id}/${var.docker_image}:${var.tag1}"
      }
    }
  }
}

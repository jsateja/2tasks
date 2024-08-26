provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "tf-state-bucket" {
  name          = "${var.prefix}-tf-state"
  project       = var.project_id
  force_destroy = false
  location      = "EU"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
  backend "gcs" {
    bucket = "jsd-tf-state"

    prefix = "terraform/state"
  }
}

resource "google_project_service" "main_apis" {
  project  = var.project_id
  for_each = toset(var.services)
  service  = each.value
}
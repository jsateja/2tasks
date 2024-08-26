resource "google_service_account" "vms" {
  account_id   = "${var.prefix}-sa"
  display_name = "Service Account used by Web App VMs"
}

resource "google_storage_bucket_iam_binding" "gcs-users" {
  bucket = google_storage_bucket.storage.name
  role   = "roles/storage.objectUserr"
  members = [
    "serviceAccount:${google_service_account.vms.email}",
  ]
}

resource "google_service_account_iam_binding" "mysql-user" {
  service_account_id = google_storage_bucket.storage.name
  role               = "roles/cloudsql.instanceUser"

  members = [
    "serviceAccount:${google_service_account.vms.email}",
  ]
}
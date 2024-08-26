resource "google_compute_router" "default" {
  name    = "lb-http-router"
  network = module.vpc.network_self_link
  region  = var.region
}

module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 5.0"
  router     = google_compute_router.default.name
  project_id = var.project_id
  region     = var.region
  name       = "${var.prefix}-cloud-nat-lb-https-router"
}
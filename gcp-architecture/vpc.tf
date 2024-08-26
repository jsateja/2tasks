module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 8.0"

  project_id   = var.project_id
  network_name = "${var.prefix}-vpc"

  subnets = [
    {
      subnet_name           = "${var.prefix}-sub-workload-01", # Subnet for Computer Engine instances
      subnet_ip             = "10.0.2.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
  ]
}

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "${var.prefix}-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.vpc.network_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = module.vpc.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}


resource "google_compute_global_address" "https-app-lb" {
  name = "${var.prefix}-pub-ip"
}

module "lb-https" {
  source  = "terraform-google-modules/lb-http/google"
  version = "~> 10.0"

  name                   = "${var.prefix}-http-lb"
  address                = google_compute_global_address.https-app-lb.address
  project                = var.project_id
  load_balancing_scheme  = "EXTERNAL_MANAGED"
  target_tags            = var.vms_tags
  labels                 = var.default_labels
  firewall_networks      = [module.vpc.network_id]
#  ssl                    = true # For safety reasons would set it up with SSL, but I didn't have time to test the code properly with generated certs
#  create_ssl_certificate = true

  backends = {
    default = {

      protocol    = "HTTP"
      port        = 80
      port_name   = "http"
      timeout_sec = 10
      enable_cdn  = false

      health_check = {
        request_path = "/healthcheck"
        port         = 80
      }

      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      groups = [
        {
          group = module.mig.instance_group
        },
      ]

      iap_config = {
        enable = false
      }
    }
  }
}
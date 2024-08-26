locals {
  service_account = {
    "email" = google_service_account.vms.email
    "scopes" = [
      "cloud-platform", # It is considered good practice to set scope to cloud-platform and then use IAM to control access to resources
    ]
  }
}
module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~> 11.0"


  project_id           = var.project_id
  subnetwork           = module.vpc.subnets_self_links[0]
  service_account      = local.service_account
  name_prefix          = "web-compute"
  disk_type            = "pd-standard"
  disk_size_gb         = var.disk_size_gb
  disk_labels          = merge(var.default_labels, var.vms_labels)
  tags                 = concat(var.vms_tags, var.default_tags)
  labels               = merge(var.default_labels, var.vms_labels)
  source_image_project = "ubuntu-os-cloud"
  source_image_family  = "ubuntu-2404-lts-amd64"
  startup_script       = var.startup_script
  automatic_restart    = true
  #additional_disks
  # Comments
}

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 11.0"

  project_id        = var.project_id
  hostname          = "${var.prefix}-${var.hostname}"
  region            = var.region
  instance_template = module.instance_template.self_link
  target_size       = var.target_size
  target_pools      = var.target_pools
  update_policy     = var.update_policy
  named_ports       = var.named_ports

  /* health check */
  health_check = var.health_check

  /* autoscaler */
  autoscaling_enabled = var.autoscaling_enabled
  max_replicas        = var.max_replicas
  min_replicas        = var.min_replicas
  cooldown_period     = var.cooldown_period
}
locals {
  read_replica_ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = true
    private_network = module.vpc.network_id
    #authorized_networks = [] Here I'd put all the other networks that need access to this MySQL, but for the sake of the task I assume only app can access it
  }
}


module "mysql" {
  source  = "terraform-google-modules/sql-db/google//modules/mysql"
  version = "~> 21.0"

  name             = "${var.prefix}-web-app-db"
  project_id       = var.project_id
  database_version = "MYSQL_8.0"
  region           = var.region

  deletion_protection = true #Set to prevent TF from destroying DB

  // Master configurations
  tier                            = var.master_tier
  zone                            = var.zones[0]
  availability_type               = var.master_availability_type
  maintenance_window_day          = var.maintenance_window_day
  maintenance_window_hour         = var.maintenance_window_hour
  maintenance_window_update_track = var.maintenance_window_update_track

  database_flags = var.master_db_flags

  user_labels = merge(var.default_labels, var.db_labels)

  ip_configuration = {
    ipv4_enabled                                  = true
    require_ssl                                   = true
    private_network                               = module.vpc.network_id
    enable_private_path_for_google_cloud_services = true
    # authorized_networks = [] Here I'd put all the other networks that need access to this MySQL, but for the sake of the task I assume only app can access it
    # psc_enabled - same goes for it, should be enabled if we have multiple VPCs, teams or orgs
  }

  password_validation_policy_config = var.password_validation_policy_config

  backup_configuration = var.backup_configuration

  // Read replica configurations
  read_replica_name_suffix = "-test-ha"
  replica_database_version = "MYSQL_8.0"
  read_replicas = [
    {
      name              = "0"
      zone              = var.zones[0]
      availability_type = var.replica_availability_type
      tier              = var.replica_tier
      ip_configuration  = local.read_replica_ip_configuration
      database_flags    = var.replicas_db_flags
      disk_autoresize   = true
      disk_size         = var.replica_disk_size
      disk_type         = var.replica_disk_type
      user_labels       = merge(var.default_labels, { "read_replica" : "1" })
    },
    {
      name              = "1"
      zone              = var.zones[1]
      availability_type = var.replica_availability_type
      tier              = var.replica_tier
      ip_configuration  = local.read_replica_ip_configuration
      database_flags    = var.replicas_db_flags
      disk_autoresize   = true
      disk_size         = var.replica_disk_size
      disk_type         = var.replica_disk_type
      user_labels       = merge(var.default_labels, { "read_replica" : "2" })
    },
    {
      name              = "2"
      zone              = var.zones[2]
      availability_type = var.replica_availability_type
      tier              = var.replica_tier
      ip_configuration  = local.read_replica_ip_configuration
      database_flags    = var.replicas_db_flags
      disk_autoresize   = true
      disk_size         = var.replica_disk_size
      disk_type         = var.replica_disk_type
      user_labels       = merge(var.default_labels, { "read_replica" : "2" })
    },
  ]

  db_name      = "${var.prefix}-web-app-db"
  db_charset   = "utf8mb4"
  db_collation = "utf8mb4_general_ci"

  user_name     = var.db_user
  user_password = var.db_password
  root_password = var.db_root_password

  iam_users = [ #IAM users that will be created in Cloud SQL
    {
      id    = google_service_account.vms.id
      email = google_service_account.vms.email
    }
  ]
  depends_on = [google_service_networking_connection.private_vpc_connection]
}
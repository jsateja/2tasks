#### GLOBAL VARS ####
project_id     = "inbound-pattern-433710-q4"
project_number = "528089163614"
region         = "europe-central2"
zones          = ["europe-central2-a", "europe-central2-b", "europe-central2-c"]
prefix         = "jsd"
env            = "dev"
services = ["servicenetworking.googleapis.com",
  "logging.googleapis.com",
  "compute.googleapis.com",
  "storage.googleapis.com",
  "monitoring.googleapis.com",
  "serviceusage.googleapis.com",
  "replicapool.googleapis.com",
  "sql-component.googleapis.com",
  "servicecontrol.googleapis.com",
]
default_labels = {
  "environment" : "dev",
  "team" : "development",
}
default_tags = ["sub-workload", "web-app", "workload", ]

#### COMPUTE ####
startup_script = "./startup_script.sh"
vms_tags       = ["sub-workload", "web-app", "workload", "dev", "backend"]
vms_labels = {
  "service" : "compute_engine",
}
disk_size_gb = 10
hostname     = "web-app"
target_size  = 3
update_policy = [{
  type                           = "PROACTIVE"
  instance_redistribution_type   = "PROACTIVE"
  minimal_action                 = "REFRESH"
  most_disruptive_allowed_action = "REPLACE"
  max_unavailable_fixed          = 3
  min_ready_sec                  = 50
  replacement_method             = "SUBSTITUTE"
}]
health_check = {
  "check_interval_sec" : 60,
  "enable_logging" : false, # ofc should be true, but it's minimal setup to reduce cost
  "healthy_threshold" : 1,
  "initial_delay_sec" : 60,
  "host" : "",
  "proxy_header" : "NONE",
  "request" : "",
  "port" : 80,
  "request_path" : "/healthcheck",
  "response" : "",
  "timeout_sec" : 50,
  "type" : "http",
  "unhealthy_threshold" : 1
}
named_ports = [{
  name = "custom"
  port = 80
}]
# Autoscaler
autoscaling_enabled = true
max_replicas        = 5
min_replicas        = 2
lb_tags             = ["dev", "lb"]

#### DATABASE ####
db_labels = {
  "service" : "database",
  "type" : "mysql"
}
db_root_password                = "U2FsdGVkX18z0wjQiEh61dO5i8iJFjmOaXd+myGwutN/WompmOiYLk846MA4Z+Cy"
db_user                         = "U2FsdGVkX18EKntdU6XaypNgE2cuwPaTNKdxhXW6IpY="
db_password                     = "U2FsdGVkX1+CMiMHx3bam2smKWvAEmQfYzikkyLVcSg="
master_availability_type        = "REGIONAL"
master_tier                     = "db-n1-standard-1"
maintenance_window_day          = 7
maintenance_window_hour         = 12
maintenance_window_update_track = "stable"
# Master
master_db_flags   = [{ name = "long_query_time", value = 1 }]
replicas_db_flags = [{ name = "long_query_time", value = 1 }]
password_validation_policy_config = {
  enable_password_policy      = true
  complexity                  = "COMPLEXITY_DEFAULT"
  disallow_username_substring = true
  min_length                  = 12
}
backup_configuration = {
  enabled            = true
  binary_log_enabled = true
  start_time         = "23:55"
  location           = "europe-central2"
  retained_backups   = 100
  retention_unit     = "COUNT"
}
# Replicas
replica_availability_type = "ZONAL"
replica_tier              = "db-n1-standard-1"
replica_disk_type         = "PD_HDD"
replica_disk_size         = "100"

#### STORAGE ####

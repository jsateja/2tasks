// Network
output "network_name" {
  value = module.vpc.network_name
}

output "network_id" {
  value = module.vpc.network_id
}

output "subnets" {
  value = module.vpc.subnets
}

output "lb_address" {
  description = "Load Balancer public IP address"
  value       = google_compute_global_address.https-app-lb.address
}

// MIG
output "mig_ig" {
  description = "Instance-group url of managed instance group."
  value       = module.mig.instance_group
}

output "instance_group_manager" {
  description = "An instance of google_compute_region_instance_group_manager of the instance group."
  value       = module.mig.instance_group_manager
}

// Master
output "db_instance_name" {
  description = "The instance name for the master instance"
  value       = module.mysql.instance_name
}

output "db_instance_ip_address" {
  description = "The IPv4 address assigned for the master instance"
  value       = module.mysql.instance_ip_address
}

output "db_private_address" {
  description = "The private IP address assigned for the master instance"
  value       = module.mysql.private_address
}

// Replicas
output "replicas_instance_first_ip_addresses" {
  description = "The first IPv4 addresses of the addresses assigned for the replica instances"
  value       = module.mysql.replicas_instance_first_ip_addresses
}

output "replicas_instance_connection_names" {
  description = "The connection names of the replica instances to be used in connection strings"
  value       = module.mysql.replicas_instance_connection_names
}

output "read_replica_instance_names" {
  description = "The instance names for the read replica instances"
  value       = module.mysql.read_replica_instance_names
}

output "db_iam_users" {
  description = "The list of the IAM users with access to the CloudSQL instance"
  value       = module.mysql.iam_users
}
# GLOBAL
variable "prefix" {
  type = string
}

variable "project_id" {
  type = string
}

variable "project_number" {
  type = string
}

variable "region" {
  type = string
}

variable "zones" {
  type = list(string)
}

variable "services" {
  description = "List of the enabled APIs in the project."
  type        = list(string)
}

variable "env" {
  type = string
}

variable "default_labels" {
  description = "Labels used across all resources"
  type        = map(string)
}

variable "default_tags" {
  description = "Tags used across all resources."
  type        = list(string)
}

# COMPUTE
variable "vms_tags" {
  description = "Tags specific for Web Application VMs."
  type        = list(string)
}

variable "vms_labels" {
  description = "Labels specific for Web Application VMs"
  type        = map(string)
}

variable "startup_script" {
  description = "User startup script to run when instances spin up."
  type        = string
  default     = ""
}

variable "disk_size_gb" {
  description = "Boot disk size in GB."
  type        = string
}

variable "hostname" {
  description = "Hostname prefix for instances."
}

variable "target_size" {
  description = "The target number of running instances for this managed or unmanaged instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set."
  default     = 1
}

variable "target_pools" {
  description = "The target load balancing pools to assign this group to."
  type        = list(string)
  default     = []
}

variable "named_ports" {
  description = "Named name and named port."
  type = list(object({
    name = string
    port = number
  }))
  default = []
}

variable "update_policy" {
  description = "The rolling update policy."
  type = list(object({
    max_surge_fixed                = optional(number)
    instance_redistribution_type   = optional(string)
    max_surge_percent              = optional(number)
    max_unavailable_fixed          = optional(number)
    max_unavailable_percent        = optional(number)
    min_ready_sec                  = optional(number)
    replacement_method             = optional(string)
    minimal_action                 = string
    type                           = string
    most_disruptive_allowed_action = optional(string)
  }))
  default = []
}

/* health checks */

variable "health_check" {
  description = "Health check to determine whether instances are responsive and able to do work"
  type = object({
    type                = string
    initial_delay_sec   = number
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    response            = string
    proxy_header        = string
    port                = number
    request             = string
    request_path        = string
    host                = string
    enable_logging      = string
  })
  default = {
    type                = "http"
    initial_delay_sec   = 30
    check_interval_sec  = 30
    healthy_threshold   = 1
    timeout_sec         = 10
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 80
    request             = ""
    request_path        = "/"
    host                = ""
    enable_logging      = false
  }
}

/* autoscaler */

variable "max_replicas" {
  description = "The maximum number of instances that the autoscaler can scale up to. This is required when creating or updating an autoscaler. The maximum number of replicas should not be lower than minimal number of replicas."
  default     = 10
}

variable "min_replicas" {
  description = "The minimum number of replicas that the autoscaler can scale down to. This cannot be less than 0."
  default     = 2
}

variable "cooldown_period" {
  description = "The number of seconds that the autoscaler should wait before it starts collecting information from a new instance."
  default     = 60
}

variable "autoscaling_cpu" {
  description = "Autoscaling, cpu utilization policy block as single element array."
  type        = list(map(number))
  default     = []
}

variable "autoscaling_metric" {
  description = "Autoscaling, metric policy block as single element array."
  type = list(object({
    name   = string
    target = number
    type   = string
  }))
  default = []
}

variable "autoscaling_lb" {
  description = "Autoscaling, load balancing utilization policy block as single element array."
  type        = list(map(number))
  default     = []
}

variable "autoscaling_scale_in_control" {
  description = "Autoscaling, scale-in control block."
  type = object({
    fixed_replicas   = number
    percent_replicas = number
    time_window_sec  = number
  })
  default = {
    fixed_replicas   = 0
    percent_replicas = 30
    time_window_sec  = 600
  }
}

variable "autoscaling_enabled" {
  description = "Creates an autoscaler for the managed instance group."
  type        = bool
  default     = false
}

#### Load Balancing ####
variable "lb_tags" {
  description = "Tags specific for Load Balancer."
  type        = list(string)
}

#### DB ####
variable "db_labels" {
  description = "Labels specific for Cloud SQL."
  type        = map(string)
}

variable "master_availability_type" {
  description = "The availability type for the read replica instance. Can be either REGIONAL or ZONAL."
  type        = string
}

variable "master_tier" {
  description = "The tier for the master instance."
  type        = string
}
variable "maintenance_window_day" {
  description = "The day of week (1-7) for the master instance maintenance."
  type        = number
}

variable "maintenance_window_hour" {
  description = "The hour of day (0-23) maintenance window for the master instance maintenance."
  type        = number
}
variable "maintenance_window_update_track" {
  description = "The update track of maintenance window for the master instance maintenance. Can be either canary or stable."
  type        = string
}

variable "master_db_flags" {
  description = "List of Cloud SQL flags that are applied to the database server."
  type = list(object({
    name  = string
    value = string
  }))
}

variable "replicas_db_flags" {
  description = "List of Cloud SQL flags that are applied to the database server."
  type = list(object({
    name  = string
    value = string
  }))
}
variable "password_validation_policy_config" {
  description = "The password validation policy settings for the database instance."
  type = object({
    enable_password_policy      = bool
    min_length                  = number
    complexity                  = string
    disallow_username_substring = bool
  })
}

variable "backup_configuration" {
  description = "The backup_configuration settings subblock for the database settings."
  type = object({
    binary_log_enabled             = optional(bool, false)
    enabled                        = optional(bool, false)
    start_time                     = optional(string)
    location                       = optional(string)
    point_in_time_recovery_enabled = optional(bool, false)
    transaction_log_retention_days = optional(string)
    retained_backups               = optional(number)
    retention_unit                 = optional(string)
  })
}

variable "replica_availability_type" {
  description = "The availability type for the read replica instance. Can be either REGIONAL or ZONAL."
  type        = string
}

variable "replica_tier" {
  description = "Read replica tier."
  type        = string
}

variable "replica_disk_type" {
  description = "The disk type for the replica instance."
  type        = string
}

variable "replica_disk_size" {
  description = "The disk size for the replica instance."
  type        = number
}

variable "db_user" {
  description = "Name of the default DB user"
  type        = string
  sensitive   = true
}
variable "db_password" {
  description = "Password of the default DB user"
  type        = string
  sensitive   = true
}
variable "db_root_password" {
  description = "DB root password."
  type        = string
  sensitive   = true
}
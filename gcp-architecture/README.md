## Description
This setup serves as an example. It is too complex in some places for a reason. 


## Architecture
![alt text](https://github.com/[jsateja]/[2tasks]/blob/[main]/architecture.png?raw=true)
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.0.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud-nat"></a> [cloud-nat](#module\_cloud-nat) | terraform-google-modules/cloud-nat/google | ~> 5.0 |
| <a name="module_instance_template"></a> [instance\_template](#module\_instance\_template) | terraform-google-modules/vm/google//modules/instance_template | ~> 11.0 |
| <a name="module_lb-https"></a> [lb-https](#module\_lb-https) | terraform-google-modules/lb-http/google | ~> 10.0 |
| <a name="module_mig"></a> [mig](#module\_mig) | terraform-google-modules/vm/google//modules/mig | ~> 11.0 |
| <a name="module_mysql"></a> [mysql](#module\_mysql) | terraform-google-modules/sql-db/google//modules/mysql | ~> 21.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | ~> 8.0 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_global_address.private_ip_address](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_address) | resource |
| [google-beta_google_service_networking_connection.private_vpc_connection](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_service_networking_connection) | resource |
| [google_compute_global_address.https-app-lb](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_router.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_project_service.main_apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.vms](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.mysql-user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [google_storage_bucket.storage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.tf-state-bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.gcs-users](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_cpu"></a> [autoscaling\_cpu](#input\_autoscaling\_cpu) | Autoscaling, cpu utilization policy block as single element array. | `list(map(number))` | `[]` | no |
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | Creates an autoscaler for the managed instance group. | `bool` | `false` | no |
| <a name="input_autoscaling_lb"></a> [autoscaling\_lb](#input\_autoscaling\_lb) | Autoscaling, load balancing utilization policy block as single element array. | `list(map(number))` | `[]` | no |
| <a name="input_autoscaling_metric"></a> [autoscaling\_metric](#input\_autoscaling\_metric) | Autoscaling, metric policy block as single element array. | <pre>list(object({<br>    name   = string<br>    target = number<br>    type   = string<br>  }))</pre> | `[]` | no |
| <a name="input_autoscaling_scale_in_control"></a> [autoscaling\_scale\_in\_control](#input\_autoscaling\_scale\_in\_control) | Autoscaling, scale-in control block. | <pre>object({<br>    fixed_replicas   = number<br>    percent_replicas = number<br>    time_window_sec  = number<br>  })</pre> | <pre>{<br>  "fixed_replicas": 0,<br>  "percent_replicas": 30,<br>  "time_window_sec": 600<br>}</pre> | no |
| <a name="input_backup_configuration"></a> [backup\_configuration](#input\_backup\_configuration) | The backup\_configuration settings subblock for the database settings. | <pre>object({<br>    binary_log_enabled             = optional(bool, false)<br>    enabled                        = optional(bool, false)<br>    start_time                     = optional(string)<br>    location                       = optional(string)<br>    point_in_time_recovery_enabled = optional(bool, false)<br>    transaction_log_retention_days = optional(string)<br>    retained_backups               = optional(number)<br>    retention_unit                 = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_cooldown_period"></a> [cooldown\_period](#input\_cooldown\_period) | The number of seconds that the autoscaler should wait before it starts collecting information from a new instance. | `number` | `60` | no |
| <a name="input_db_labels"></a> [db\_labels](#input\_db\_labels) | Labels specific for Cloud SQL. | `map(string)` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password of the default DB user | `string` | n/a | yes |
| <a name="input_db_root_password"></a> [db\_root\_password](#input\_db\_root\_password) | DB root password. | `string` | n/a | yes |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Name of the default DB user | `string` | n/a | yes |
| <a name="input_default_labels"></a> [default\_labels](#input\_default\_labels) | Labels used across all resources | `map(string)` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags used across all resources. | `list(string)` | n/a | yes |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | Boot disk size in GB. | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | Health check to determine whether instances are responsive and able to do work | <pre>object({<br>    type                = string<br>    initial_delay_sec   = number<br>    check_interval_sec  = number<br>    healthy_threshold   = number<br>    timeout_sec         = number<br>    unhealthy_threshold = number<br>    response            = string<br>    proxy_header        = string<br>    port                = number<br>    request             = string<br>    request_path        = string<br>    host                = string<br>    enable_logging      = string<br>  })</pre> | <pre>{<br>  "check_interval_sec": 30,<br>  "enable_logging": false,<br>  "healthy_threshold": 1,<br>  "host": "",<br>  "initial_delay_sec": 30,<br>  "port": 80,<br>  "proxy_header": "NONE",<br>  "request": "",<br>  "request_path": "/",<br>  "response": "",<br>  "timeout_sec": 10,<br>  "type": "http",<br>  "unhealthy_threshold": 5<br>}</pre> | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname prefix for instances. | `any` | n/a | yes |
| <a name="input_lb_tags"></a> [lb\_tags](#input\_lb\_tags) | Tags specific for Load Balancer. | `list(string)` | n/a | yes |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | The day of week (1-7) for the master instance maintenance. | `number` | n/a | yes |
| <a name="input_maintenance_window_hour"></a> [maintenance\_window\_hour](#input\_maintenance\_window\_hour) | The hour of day (0-23) maintenance window for the master instance maintenance. | `number` | n/a | yes |
| <a name="input_maintenance_window_update_track"></a> [maintenance\_window\_update\_track](#input\_maintenance\_window\_update\_track) | The update track of maintenance window for the master instance maintenance. Can be either canary or stable. | `string` | n/a | yes |
| <a name="input_master_availability_type"></a> [master\_availability\_type](#input\_master\_availability\_type) | The availability type for the read replica instance. Can be either REGIONAL or ZONAL. | `string` | n/a | yes |
| <a name="input_master_db_flags"></a> [master\_db\_flags](#input\_master\_db\_flags) | List of Cloud SQL flags that are applied to the database server. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | n/a | yes |
| <a name="input_master_tier"></a> [master\_tier](#input\_master\_tier) | The tier for the master instance. | `string` | n/a | yes |
| <a name="input_max_replicas"></a> [max\_replicas](#input\_max\_replicas) | The maximum number of instances that the autoscaler can scale up to. This is required when creating or updating an autoscaler. The maximum number of replicas should not be lower than minimal number of replicas. | `number` | `10` | no |
| <a name="input_min_replicas"></a> [min\_replicas](#input\_min\_replicas) | The minimum number of replicas that the autoscaler can scale down to. This cannot be less than 0. | `number` | `2` | no |
| <a name="input_named_ports"></a> [named\_ports](#input\_named\_ports) | Named name and named port. | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | `[]` | no |
| <a name="input_password_validation_policy_config"></a> [password\_validation\_policy\_config](#input\_password\_validation\_policy\_config) | The password validation policy settings for the database instance. | <pre>object({<br>    enable_password_policy      = bool<br>    min_length                  = number<br>    complexity                  = string<br>    disallow_username_substring = bool<br>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | GLOBAL | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | n/a | yes |
| <a name="input_project_number"></a> [project\_number](#input\_project\_number) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_replica_availability_type"></a> [replica\_availability\_type](#input\_replica\_availability\_type) | The availability type for the read replica instance. Can be either REGIONAL or ZONAL. | `string` | n/a | yes |
| <a name="input_replica_disk_size"></a> [replica\_disk\_size](#input\_replica\_disk\_size) | The disk size for the replica instance. | `number` | n/a | yes |
| <a name="input_replica_disk_type"></a> [replica\_disk\_type](#input\_replica\_disk\_type) | The disk type for the replica instance. | `string` | n/a | yes |
| <a name="input_replica_tier"></a> [replica\_tier](#input\_replica\_tier) | Read replica tier. | `string` | n/a | yes |
| <a name="input_replicas_db_flags"></a> [replicas\_db\_flags](#input\_replicas\_db\_flags) | List of Cloud SQL flags that are applied to the database server. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | n/a | yes |
| <a name="input_services"></a> [services](#input\_services) | List of the enabled APIs in the project. | `list(string)` | n/a | yes |
| <a name="input_startup_script"></a> [startup\_script](#input\_startup\_script) | User startup script to run when instances spin up. | `string` | `""` | no |
| <a name="input_target_pools"></a> [target\_pools](#input\_target\_pools) | The target load balancing pools to assign this group to. | `list(string)` | `[]` | no |
| <a name="input_target_size"></a> [target\_size](#input\_target\_size) | The target number of running instances for this managed or unmanaged instance group. This value should always be explicitly set unless this resource is attached to an autoscaler, in which case it should never be set. | `number` | `1` | no |
| <a name="input_update_policy"></a> [update\_policy](#input\_update\_policy) | The rolling update policy. | <pre>list(object({<br>    max_surge_fixed                = optional(number)<br>    instance_redistribution_type   = optional(string)<br>    max_surge_percent              = optional(number)<br>    max_unavailable_fixed          = optional(number)<br>    max_unavailable_percent        = optional(number)<br>    min_ready_sec                  = optional(number)<br>    replacement_method             = optional(string)<br>    minimal_action                 = string<br>    type                           = string<br>    most_disruptive_allowed_action = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_vms_labels"></a> [vms\_labels](#input\_vms\_labels) | Labels specific for Web Application VMs | `map(string)` | n/a | yes |
| <a name="input_vms_tags"></a> [vms\_tags](#input\_vms\_tags) | Tags specific for Web Application VMs. | `list(string)` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | n/a | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_iam_users"></a> [db\_iam\_users](#output\_db\_iam\_users) | The list of the IAM users with access to the CloudSQL instance |
| <a name="output_db_instance_ip_address"></a> [db\_instance\_ip\_address](#output\_db\_instance\_ip\_address) | The IPv4 address assigned for the master instance |
| <a name="output_db_instance_name"></a> [db\_instance\_name](#output\_db\_instance\_name) | The instance name for the master instance |
| <a name="output_db_private_address"></a> [db\_private\_address](#output\_db\_private\_address) | The private IP address assigned for the master instance |
| <a name="output_instance_group_manager"></a> [instance\_group\_manager](#output\_instance\_group\_manager) | An instance of google\_compute\_region\_instance\_group\_manager of the instance group. |
| <a name="output_lb_address"></a> [lb\_address](#output\_lb\_address) | Load Balancer public IP address |
| <a name="output_mig_ig"></a> [mig\_ig](#output\_mig\_ig) | Instance-group url of managed instance group. |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | n/a |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | Network |
| <a name="output_read_replica_instance_names"></a> [read\_replica\_instance\_names](#output\_read\_replica\_instance\_names) | The instance names for the read replica instances |
| <a name="output_replicas_instance_connection_names"></a> [replicas\_instance\_connection\_names](#output\_replicas\_instance\_connection\_names) | The connection names of the replica instances to be used in connection strings |
| <a name="output_replicas_instance_first_ip_addresses"></a> [replicas\_instance\_first\_ip\_addresses](#output\_replicas\_instance\_first\_ip\_addresses) | The first IPv4 addresses of the addresses assigned for the replica instances |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | n/a |
<!-- END_TF_DOCS -->
locals {
  container_config_directory = "/etc/redis"
  container_data_directory   = "/var/lib/redis"
  host_config_directory      = "${var.data_directory}/config"
  host_data_directory        = "${var.data_directory}/data"

  forced_context = {
    bind_address = "* -::*"
    databases    = var.databases
    directory    = local.container_data_directory
    log_level    = var.log_level
    password     = var.password
    port         = var.port
  }
}

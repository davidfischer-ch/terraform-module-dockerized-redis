locals {
  container_data_directory = "/data"
  host_data_directory      = "${var.data_directory}/data"

  forced_context = {
    bind_address = "* -::*"
    port         = 6379
  }
}

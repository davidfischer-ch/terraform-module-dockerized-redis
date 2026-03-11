resource "docker_container" "server" {

  lifecycle {
    replace_triggered_by = [
      local_sensitive_file.main_config
    ]
  }

  image = var.image_id
  name  = var.identifier

  must_run = var.enabled
  start    = var.enabled
  restart  = "always"
  wait     = var.wait

  privileged = var.privileged

  dynamic "capabilities" {
    for_each = length(var.cap_add) + length(var.cap_drop) > 0 ? [1] : []
    content {
      add  = var.cap_add
      drop = var.cap_drop
    }
  }

  user = "${var.app_uid}:${var.app_gid}"

  # shm_size = 256 # MB

  command = ["redis-server", "${local.container_config_directory}/redis.conf"]

  env = []

  dynamic "host" {
    for_each = var.hosts
    content {
      host = host.key
      ip   = host.value
    }
  }

  hostname = var.identifier

  networks_advanced {
    name = var.network_id
  }

  network_mode = "bridge"

  volumes {
    container_path = "${local.container_config_directory}/redis.conf"
    host_path      = local_sensitive_file.main_config.filename
    read_only      = true
  }

  volumes {
    container_path = local.container_data_directory
    host_path      = local.host_data_directory
    read_only      = false
  }

  provisioner "local-exec" {
    command = <<EOT
      chown "${var.app_uid}:${var.app_gid}" "${local.host_data_directory}"
    EOT
  }
}

data "jinja_template" "main_config" {
  template = "${path.module}/config/redis.conf.j2"
  context {
    type = "json"
    data = jsonencode(local.forced_context)
  }
}

resource "local_sensitive_file" "main_config" {
  filename             = "${local.container_config_directory}/redis.conf"
  content              = data.jinja_template.main_config.result
  file_permission      = "0644"
  directory_permission = "0755"
}

resource "docker_image" "redis" {
  name         = "redis:7.4.2"
  keep_locally = true
}

resource "docker_network" "app" {
  name   = "my-app"
  driver = "bridge"
}

resource "random_password" "broker" {
  length  = 32
  special = false
}

module "broker" {
  source = "git::https://github.com/davidfischer-ch/terraform-module-dockerized-redis.git?ref=1.1.0"

  identifier     = "my-app-broker"
  image_id       = docker_image.redis.image_id
  data_directory = "/data/my-app/broker"

  network_id = docker_network.app.id

  databases = 2
  password  = random_password.broker.result
}

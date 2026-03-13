# Redis Terraform Module (Dockerized)

Manage Redis server.

* Runs in bridge networking mode
* Persists data directory
* Configuration rendered via Jinja templates
* Password-protected by default

## Usage

See [examples/default](examples/default) for a complete working configuration.

```hcl
module "redis" {
  source = "git::https://github.com/davidfischer-ch/terraform-module-dockerized-redis.git?ref=1.1.1"

  identifier     = "my-app-broker"
  image_id       = docker_image.redis.image_id
  data_directory = "/data/my-app/broker"

  hosts      = { "myserver" = "10.0.0.1" }
  network_id = docker_network.app.id

  databases = 2
  password  = random_password.broker.result
}
```

## Data layout

All persistent data lives under `data_directory`:

```
data_directory/
├── config/  # Generated redis.conf
└── data/    # Redis persistent data (RDB/AOF)
```

## Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `identifier` | `string` | — | Unique name for resources (must match `^[a-z]+(-[a-z0-9]+)*$`). |
| `enabled` | `bool` | `true` | Start or stop the container. |
| `wait` | `bool` | `true` | Wait for the container to reach a healthy state after creation. |
| `image_id` | `string` | — | [Redis](https://hub.docker.com/_/redis/tags) Docker image's ID. |
| `app_uid` | `number` | `999` | UID of the user running the container and owning the data directories. |
| `app_gid` | `number` | `999` | GID of the user running the container and owning the data directories. |
| `privileged` | `bool` | `false` | Run the container in privileged mode. |
| `cap_add` | `set(string)` | `[]` | Linux capabilities to add to the container. |
| `cap_drop` | `set(string)` | `[]` | Linux capabilities to drop from the container. |
| `hosts` | `map(string)` | `{}` | Extra `/etc/hosts` entries for the container. |
| `network_id` | `string` | — | Docker network to attach to. |
| `port` | `number` | `6379` | Redis port (changing not yet implemented). |
| `data_directory` | `string` | — | Host path for persistent volumes. |
| `log_level` | `string` | `"warning"` | Redis log level (`debug`, `verbose`, `notice`, `warning`). |
| `databases` | `number` | `1` | Number of databases. |
| `password` | `string` | — | Authentication password (sensitive). |

## Outputs

| Name | Description |
|------|-------------|
| `host` | Container hostname. |
| `port` | Redis port. |
| `password` | Authentication password (sensitive). |

## Requirements

* Terraform >= 1.6
* [kreuzwerker/docker](https://github.com/kreuzwerker/terraform-provider-docker) >= 3.0.2
* [NikolaLohinski/jinja](https://github.com/NikolaLohinski/terraform-provider-jinja) >= 1.17.0
* [hashicorp/local](https://github.com/hashicorp/terraform-provider-local) >= 2.4.1

## References

* https://hub.docker.com/_/redis
* https://github.com/davidfischer-ch/ansible-role-redis

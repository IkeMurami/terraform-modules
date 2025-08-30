zone = "ru-central1-a"
cloud-id = "123a...fcc1824"
folder-id = "123a...34423abba"
service-account-id = "123dfsd...gf"

network-id = "e9...m11"
subnet-id = "e9bn4...ke"

logging-group-id = "123...12ds1"

certificate = {
  chain = "value"
  privkey = "value"
}

postgres-config = {
  local-host  = "postgres-service"
  local-port  = 5432
  remote-port = 5432
}

postgres-secrets = {
  db       = "test"
  user     = "user"
  password = "***"
}

services = [
  {
    domain      = "service.example.com",
    name        = "web",
    docker_host = "frontend",
    docker_port = 3000
  },
  {
    domain      = "api.service.example.com",
    name        = "api",
    docker_host = "backend",
    docker_port = 3000
  }
]

module "service" {
  source = "./module"

  zone               = var.zone
  service-account-id = var.service-account-id

  device-name      = local.device-name
  logging-group-id = var.logging-group-id

  # Connection
  default-user    = local.default-user
  vm-ssh-key-path = local.ssh-key

  # Network
  network-id = var.network-id
  subnet-id  = var.subnet-id

  # Service configs
  postgres-password-hash = local.postgres-password-hash
  cloud-init-yaml        = local.cloud-init-yaml
  docker-compose         = local.docker-compose

  providers = {
    yandex = yandex.with-project-info
  }
}

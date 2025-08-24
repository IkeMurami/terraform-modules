module "app" {
  source = "git::https://github.com/IkeMurami/terraform-modules.git//ycloud/vm-instance"

  cloud-init     = data.cloudinit_config.cloud-init.rendered
  docker-compose = var.docker-compose

  sa-id = var.service-account-id
  sg-id = yandex_vpc_security_group.instance-security-group.id

  subnet-id   = var.subnet-id
  zone        = var.zone
  device-name = var.device-name

  postgres-password-hash = var.postgres-password-hash
  default-user           = var.default-user
  ssh-key                = var.vm-ssh-key-path
}

locals {
  environment            = "testing"
  app-name               = "service"
  device-name            = "${local.app-name}-pgdata"
  default-user           = "yc-user"
  ssh-key                = "${path.module}/ycvm"
  postgres-password-hash = sha256("${var.postgres-secrets.password}-${local.environment}")
  # Перекладываю сертификаты в локальную переменную, так при запуске из консоли нет возможности передать
  # в переменную модуля содержимое файла (да и в целом, это надо только тут)
  certificate = {
    chain   = var.certificate.chain != "" ? var.certificate.chain : file("${path.module}/fullchain.pem")
    privkey = var.certificate.privkey != "" ? var.certificate.privkey : file("${path.module}/privkey.pem")
  }
}

variable "cloud-id" {
  type = string
}

variable "folder-id" {
  type = string
}

variable "zone" {
  description = "В каком DC разместить сервис"
  type        = string
  # default     = "ru-central1-a"
}

variable "service-account-id" {
  # Roles:
  # - container-registry.images.puller
  # - logging.writer

  description = "Service Account"
  type        = string
}

variable "network-id" {
  description = "VPC Network ID"
  type        = string
}

variable "subnet-id" {
  description = "VPC subnet id"
  type        = string
}

variable "logging-group-id" {
  description = "Logging group ID"
  type        = string
}

variable "postgres-config" {
  description = "Postgres Config"
  type = object({
    # Это имя контейнера, а не реальный хост!
    local-host = string
    # Вообще, это константа, на нее мы не влияем, но нам ее надо перекидывать
    local-port  = number
    remote-port = number
  })
}

variable "postgres-secrets" {
  description = "Postgres credentials"
  type = object({
    db       = string
    user     = string
    password = string
  })
  sensitive = true
}

variable "certificate" {
  description = "TLS Certificate"
  type = object({
    chain   = string
    privkey = string
  })
  sensitive = true
  default = {
    chain   = ""
    privkey = ""
  }
}

variable "services" {
  description = "Какие сервисы поднять в nginx"
  type = list(object({
    domain      = string
    name        = string
    docker_host = string
    docker_port = number
  }))
}

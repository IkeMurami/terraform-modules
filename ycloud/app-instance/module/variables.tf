locals {
  # logging-group-name = "${var.app-name}-logs"
  # device-name = "${var.app-name}-pgdata"
}

# variable "app-name" {
#   description = "Короткое название сервиса"
#   type = string
# }

variable "zone" {
  description = "В каком DC разместить сервис"
  type        = string
  # default     = "ru-central1-a"
}

variable "cloud-init-yaml" {
  description = "Cloud Init yaml-конфиг"
  type        = string
}

variable "docker-compose" {
  description = "Docker Compose файл"
  type        = string
}

variable "device-name" {
  # Нужно для правильного названия облачного диска postgres
  description = "Postgres disk name: этот параметр для провязки диска в конфигурации и внутри контейнера / docker compose"
  type        = string
}

variable "postgres-password-hash" {
  # Сменили пароль — диск с данными пересоздаем?
  # Пока не знаю как лучше
  description = "Хеш пароля к Postgres"
  type        = string
  sensitive   = true
}

variable "service-account-id" {
  # Roles: container-registry.images.puller
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

variable "default-user" {
  description = "SSH user"
  type        = string
}

variable "vm-ssh-key-path" {
  description = "ssh key path"
  type        = string
}

variable "logging-group-id" {
  description = "Logging group ID"
  type        = string
}
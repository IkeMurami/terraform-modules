variable "zone" {
  description = "В каком DC разместить сервис"
  type        = string
  default     = "ru-central1-a"
}

variable "cloud-id" {
  description = "YCloud cloud ID"
  type        = string
}

variable "folder-name" {
  description = "YCloud folder name"
  type        = string
}

variable "registry-name" {
  description = "Docker registry name"
  type        = string
  default     = "default"
}

variable "parent-domain" {
  # Настраиваем зону для родительского домена, сами сервисы будут на дочерних доменах
  description = "Parent domain zone"
  type = object({
    domain    = string
    zone-name = string
  })
  default = null
}

variable "service-account-name" {
  type    = string
  default = "sa"
}

variable "network" {
  # Настраиваем сеть
  description = "Service network"
  type = object({
    name            = string
    subnetwork-name = string
  })
  default = {
    name            = "network"
    subnetwork-name = "subnet-a"
  }
}

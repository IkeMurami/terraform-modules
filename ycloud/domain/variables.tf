variable "cloud-name" {
  type = string
}

variable "folder-name" {
  type = string
}

variable "domain" {
  description = "Информация о домене"
  type = object({
    parent-domain       = string
    parent-domain-zone-name = string
    service-domain = string
    service-domain-zone-name = string
  })
}
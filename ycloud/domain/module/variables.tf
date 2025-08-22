variable "domain" {
  description = "Информация о домене"
  type = object({
    zone-name = string
    value     = string
  })
}

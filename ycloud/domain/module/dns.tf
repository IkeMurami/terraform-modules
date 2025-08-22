# Создание зоны DNS
# https://yandex.cloud/ru/docs/compute/tutorials/bind-domain-vm/terraform
resource "yandex_dns_zone" "domain-zone" {
  name        = var.domain.zone-name
  description = "Service domain zone"

  zone   = "${var.domain.value}."
  public = true
}

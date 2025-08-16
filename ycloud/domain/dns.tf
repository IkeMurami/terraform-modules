# Создание зоны DNS
# https://yandex.cloud/ru/docs/compute/tutorials/bind-domain-vm/terraform
resource "yandex_dns_zone" "domain-zone" {
  name        = var.domain.parent-domain-zone-name
  description = "Parent domain zone"

  zone   = "${var.domain.parent-domain}."
  public = true

  provider = yandex.with-project-info
}

resource "yandex_dns_zone" "domain-zone" {
  name        = var.domain.service-domain-zone-name
  description = "Service domain zone"

  zone   = "${var.domain.service-domain}."
  public = true

  provider = yandex.with-project-info
}

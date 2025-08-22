# Setup parent domain zone
# https://yandex.cloud/ru/docs/compute/tutorials/bind-domain-vm/terraform
resource "yandex_dns_zone" "domain-zone" {
  count = var.parent-domain != null ? 1 : 0

  name        = var.parent-domain.zone-name
  description = "Parent domain zone"

  zone   = "${var.parent-domain.domain}."
  public = true

  provider = yandex.with-project-info
}

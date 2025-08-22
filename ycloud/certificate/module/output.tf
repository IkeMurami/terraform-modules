output "cert_id" {
  description = "Certificate ID"
  value       = data.yandex_cm_certificate.cert-domain.id
}

output "chain" {
  value = join("\n", data.yandex_cm_certificate_content.cert-domain-content.certificates)
}

output "privkey" {
  value     = data.yandex_cm_certificate_content.cert-domain-content.private_key
  sensitive = true
}

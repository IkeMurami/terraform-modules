output "cert_id" {
  description = "Certificate ID"
  value       = module.certificate.cert_id
}

output "chain" {
  value = module.certificate.chain
}

output "privkey" {
  value     = module.certificate.privkey
  sensitive = true
}

resource "local_file" "chain" {
  filename = "${path.module}/fullchain.pem"
  content  = module.certificate.chain
}

resource "local_sensitive_file" "privkey" {
  filename = "${path.module}/privkey.pem"
  content  = module.certificate.privkey
}

data "cloudinit_config" "cloud-init" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = var.cloud-init-yaml
  }
}

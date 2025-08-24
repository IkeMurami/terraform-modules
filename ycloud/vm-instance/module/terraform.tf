terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
    }
  }
  required_version = ">= 0.13"
}
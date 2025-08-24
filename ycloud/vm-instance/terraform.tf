terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  alias     = "with-project-info"
  cloud_id  = var.cloud-id
  folder_id = var.folder-id
}

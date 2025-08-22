terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

data "yandex_resourcemanager_folder" "folder" {
  id = var.folder-id
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

data "yandex_resourcemanager_cloud" "cloud" {
  id = var.cloud-id
}

resource "yandex_resourcemanager_folder" "folder" {
  cloud_id = data.yandex_resourcemanager_cloud.cloud.id
  name     = var.folder-name
}

provider "yandex" {
  alias     = "with-project-info"
  cloud_id  = data.yandex_resourcemanager_cloud.cloud.id
  folder_id = yandex_resourcemanager_folder.folder.id
  # zone      = var.zone
}

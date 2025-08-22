# Setup Container registry
resource "yandex_container_registry" "default" {
  name      = var.registry-name
  folder_id = data.yandex_resourcemanager_folder.folder.id
}

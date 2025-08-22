# Setup Container registry
resource "yandex_container_registry" "default" {
  name      = var.registry-name
  folder_id = yandex_resourcemanager_folder.folder.id

  provider = yandex.with-project-info
}
# IAM: create service account and bind permissions
resource "yandex_iam_service_account" "sa" {
  name        = var.service-account-name
  description = "Сервисный аккаунт для загрузки контейнеров из docker registry"

  provider = yandex.with-project-info
}

resource "yandex_resourcemanager_folder_iam_binding" "image-puller" {
  folder_id = yandex_resourcemanager_folder.folder.id
  role      = "container-registry.images.puller"
  members   = ["serviceAccount:${yandex_iam_service_account.sa.id}"]

  provider = yandex.with-project-info
}

resource "yandex_resourcemanager_folder_iam_binding" "logging-writer" {
  folder_id = yandex_resourcemanager_folder.folder.id
  role      = "logging.writer"
  members   = ["serviceAccount:${yandex_iam_service_account.sa.id}"]

  provider = yandex.with-project-info
}

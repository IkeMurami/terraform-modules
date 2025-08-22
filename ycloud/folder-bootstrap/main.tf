module "bootstrap" {
  source = "./module"

  zone                 = var.zone
  folder-id            = yandex_resourcemanager_folder.folder.id
  network              = var.network
  logging-group-name   = var.logging-group-name
  service-account-name = var.service-account-name
  parent-domain        = var.parent-domain

  providers = {
    yandex = yandex.with-project-info
  }
}
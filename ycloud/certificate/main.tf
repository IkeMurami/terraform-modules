module "certificate" {
  source = "./module"

  domain = var.domain

  providers = {
    yandex = yandex.with-project-info
  }
}
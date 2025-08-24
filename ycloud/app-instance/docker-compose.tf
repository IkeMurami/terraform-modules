locals {
  docker-compose = templatefile("${path.module}/configs/tpl.docker-compose.yaml", {
    PWD = local.base-dir

    DEFAULT_USER = local.default-user
    DEVICE_NAME  = local.device-name
    YC_GROUP_ID  = var.logging-group-id

    POSTGRES_LOCAL_HOST  = var.postgres-config.local-host
    POSTGRES_LOCAL_PORT  = var.postgres-config.local-port
    POSTGRES_REMOTE_PORT = var.postgres-config.remote-port
    POSTGRES_DB          = var.postgres-secrets.db
    POSTGRES_USER        = var.postgres-secrets.user
    POSTGRES_PASSWORD    = var.postgres-secrets.password

    FLUENT_BIT_HOST = "fluentbit"
    FLUENT_BIT_PORT = 24224
  })
}
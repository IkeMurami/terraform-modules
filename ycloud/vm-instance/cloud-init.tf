locals {
  base-dir = "/etc/${local.app-name}"
}

locals {
  #   cert-fullchain-path = "/etc/certs/fullchain.pem"
  #   cert-privkey-path   = "/etc/certs/privkey.pem"
  cert-fullchain-path = "${local.base-dir}/certs/${local.app-name}.crt"
  cert-privkey-path   = "${local.base-dir}/certs/${local.app-name}.key"
}

locals {
  nginx_services = [
    for service in var.services : {
      path = "${local.base-dir}/nginx/templates/${service.name}.conf.template"
      content = templatefile("${path.module}/configs/nginx/templates/service.conf.template", {
        DOMAIN             = service.domain
        SERVICE_NAME       = service.name
        NGINX_SERVICE_HOST = format("$%s_host", service.name)
        DOCKER_HOST        = service.docker_host
        DOCKER_PORT        = service.docker_port
      })
    }
  ]
  nginx_certificates = [
    {
      path    = local.cert-privkey-path
      content = local.certificate.privkey
    },
    {
      path    = local.cert-fullchain-path
      content = local.certificate.chain
    }
  ]
  postgres_init = [
    {
      # Задаем пароль при инициализации базы
      path = "/etc/init.sql"
      content = templatefile("${path.module}/configs/postgres/init.sql", {
        POSTGRES_USER     = var.postgres-secrets.user
        POSTGRES_PASSWORD = var.postgres-secrets.password
      })
    }
  ]
  nginx_configs = [
    {
      path    = "${local.base-dir}/nginx/http.conf"
      content = file("${path.module}/configs/nginx/http.conf")
    },
    {
      path = "${local.base-dir}/nginx/ssl/certificates.conf"
      content = templatefile("${path.module}/configs/nginx/ssl/certificates.conf", {
        # Где внутри контейнера nginx будут лежать сертификаты
        CERTIFICATE_CHAIN = "/etc/ssl/${local.app-name}.crt",
        CERTIFICATE_KEY   = "/etc/ssl/${local.app-name}.key"
      })
    },
    {
      path    = "${local.base-dir}/nginx/ssl/params.conf"
      content = file("${path.module}/configs/nginx/ssl/params.conf")
    },
    {
      "path" : "${local.base-dir}/nginx/templates/reject-rule.conf.template",
      "content" : file("${path.module}/configs/nginx/templates/reject-rule.conf.template")
    }
  ]
  nginx_fluentbit = [
    {
      "path" : "${local.base-dir}/fluentbit/fluentbit.conf",
      "content" : templatefile("${path.module}/configs/fluentbit/fluentbit.conf", {
        FLUENT_BIT_HOST = "fluentbit"
        FLUENT_BIT_PORT = 24224
        YC_GROUP_ID     = var.logging-group-id
      }),
    },
    {
      "path" : "${local.base-dir}/fluentbit/parsers.conf",
      "content" : file("${path.module}/configs/fluentbit/parsers.conf")
    }
  ]
}

locals {
  write_files = concat(
    local.nginx_certificates,
    local.postgres_init,
    local.nginx_configs,
    local.nginx_fluentbit,
    local.nginx_services
  )
  base-cloud-init = {
    # User setup configuration
    ssh_pwauth = false
    users = [
      {
        name  = local.default-user
        sudo  = "ALL=(ALL) NOPASSWD:ALL"
        shell = "/bin/bash"
        ssh_authorized_keys = [
          file("${local.ssh-key}.pub")
        ]
      }
    ]
    runcmd = [
      "echo 'Hello, World!' > /etc/hello-world.txt",
      "chmod 666 /var/run/docker.sock"
    ]
    // Move configs to VM
    write_files = local.write_files
  }
  cloud-init-yaml = yamlencode(
    local.base-cloud-init
  )
  #   cloud-init-yaml = yamlencode(
  #     {
  #         # User setup configuration
  #       "ssh_pwauth" : "no",
  #       "users" : [{
  #         "name" : local.default-user,
  #         "sudo" : "ALL=(ALL) NOPASSWD:ALL",
  #         "shell" : "/bin/bash",
  #         "ssh_authorized_keys" : [
  #           file("${local.ssh-key}.pub")
  #         ]
  #       }],
  #       # Commands to run at the end of the cloud-init process
  #       "runcmd" : [
  #         "echo 'Hello, World!' > /etc/hello-world.txt",
  #         "chmod 666 /var/run/docker.sock",
  #       ],
  #       // Move configs to VM
  #       "write_files" : [
  #         # Certificates
  #         {
  #           "path" : local.cert-privkey-path,
  #           "content" : local.certificate.privkey
  #         },
  #         {
  #           "path" : local.cert-fullchain-path,
  #           "content" : local.certificate.chain
  #         },
  #         # Postgres configs
  #         {
  #           # Задаем пароль при инициализации базы
  #           "path" : "/etc/init.sql",
  #           "content" : templatefile("${path.module}/configs/postgres/init.sql", {
  #             POSTGRES_USER     = var.postgres-secrets.user
  #             POSTGRES_PASSWORD = var.postgres-secrets.password
  #           })
  #         },
  #         # Nginx configs
  #         {
  #             "path": "${local.base-dir}/nginx/http.conf",
  #             "content": file("${path.module}/configs/nginx/http.conf")
  #         },
  #         {
  #             "path": "${local.base-dir}/nginx/ssl/certificates.conf",
  #             "content": templatefile("${path.module}/configs/nginx/ssl/certificates.conf", {
  #                 CERTIFICATE_CHAIN = local.cert-fullchain-path,
  #                 CERTIFICATE_KEY = local.cert-privkey-path
  #             })
  #         },
  #         {
  #             "path": "${local.base-dir}/nginx/ssl/params.conf",
  #             "content": file("${path.module}/configs/nginx/ssl/params.conf")
  #         },
  #         for service in var.services
  #         {
  #             "path": "${local.base-dir}/nginx/templates/backend.conf.template",
  #             "content": templatefile("${path.module}/configs/nginx/templates/backend.conf.template", {
  #                 DOMAIN = var.domain
  #             })
  #         },
  #         {
  #             "path": "${local.base-dir}/nginx/templates/frontend.conf.template",
  #             "content": templatefile("${path.module}/configs/nginx/templates/frontend.conf.template", {
  #                 DOMAIN = local.domain-web
  #             })
  #         },
  #         {
  #             "path": "${local.base-dir}/nginx/templates/reject-rule.conf.template",
  #             "content": file("${path.module}/configs/nginx/templates/reject-rule.conf.template")
  #         },
  #         # Wanderly configs
  #         {
  #             "path": "${local.base-dir}/wanderly/environment.env",
  #             "content": file("${path.module}/configs/wanderly/environment.env")
  #         },
  #         {
  #             "path": "${local.base-dir}/wanderly/backend-api.env",
  #             "content": file("${path.module}/configs/wanderly/backend-api.env")
  #         },
  #         # Fluentbit для сбора логов с контейнеров
  #         {
  #           "path" : "${local.base-dir}/fluentbit/fluentbit.conf",
  #           "content" : templatefile("${path.module}/configs/fluentbit/fluentbit.conf", {
  #             FLUENT_BIT_HOST = "fluentbit"
  #             FLUENT_BIT_PORT = 24224
  #             YC_GROUP_ID     = yandex_logging_group.group.id
  #           }),
  #         },
  #         {
  #           "path" : "${local.base-dir}/fluentbit/parsers.conf",
  #           "content" : file("${path.module}/configs/fluentbit/parsers.conf")
  #         }
  #       ],
  #     }
  #   )
}
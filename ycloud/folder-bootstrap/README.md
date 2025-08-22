# YCloud new project folder bootstrap

Поднимаем каталог с необходимыми компонентами для развертывания приложения

## Настройка

1. Экспортируем токен: `export YC_TOKEN="$(yc iam create-token)"`
2. Настраиваем переменные в `variables.tfvars` (см пример в `variables.tfvars.tpl`). Базово указываем ID нашего облака (берем из Yandex Cloud console), название для каталога. Если сервис будет распологаться на поддомене, то передаем родительский домен и название для доменной зоны
3. Запускаем:

```
make init
make plan
make apply
```

4. Что получаем в output:

- Registry ID (`container-registry-id`)
- ID сети и подсети — `network-id` и `subnet-id`
- Service Account ID (`service-account-id`) с выданными правами на запись логов и скачивание образов из registry
- ID хранилища с логами (`logging-group-id`)

## Используем как модуль

См [main.tf](./main.tf)

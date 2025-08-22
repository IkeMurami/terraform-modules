output "service-account-id" {
  value = yandex_iam_service_account.sa.id
}

output "network-id" {
  value = yandex_vpc_network.network.id
}

output "subnet-id" {
  value = yandex_vpc_subnet.subnet.id
}

output "container-registry-id" {
  value = yandex_container_registry.default.id
}

output "logging-group-id" {
  value = yandex_logging_group.group.id
}

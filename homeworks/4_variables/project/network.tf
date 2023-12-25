resource "yandex_vpc_network" "this" {
  name = "${local.prefix}${var.name}"
}

resource "yandex_vpc_subnet" "this-a" {
  name           = "${local.prefix}${var.name}-subnet-a"
  v4_cidr_blocks = var.cidr_blocks.a
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.this.id
  labels         = var.labels
}

resource "yandex_vpc_subnet" "this-b" {
  name           = "${local.prefix}${var.name}-subnet-b"
  v4_cidr_blocks = var.cidr_blocks.b
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.this.id
  labels         = var.labels
}

resource "yandex_vpc_subnet" "this-c" {
  name           = "${local.prefix}${var.name}-subnet-c"
  v4_cidr_blocks = var.cidr_blocks.c
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.this.id
  labels         = var.labels
}

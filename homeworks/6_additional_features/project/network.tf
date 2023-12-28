resource "yandex_vpc_network" "this" {
  name = "${local.prefix}${var.name}"
}

resource "yandex_vpc_subnet" "this" {
  for_each = toset(var.az)

  name           = "${local.prefix}${var.name}-subnet-${each.value}"
  v4_cidr_blocks = var.cidr_blocks[index(var.az, each.value)]
  zone           = each.value
  network_id     = yandex_vpc_network.this.id
  labels         = var.labels
}

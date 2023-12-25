resource "yandex_lb_target_group" "this" {
  name      = "${local.prefix}${var.name}-lb-target-group"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.this-a.id
    address   = yandex_compute_instance.this-a.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.this-b.id
    address   = yandex_compute_instance.this-b.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.this-c.id
    address   = yandex_compute_instance.this-c.network_interface.0.ip_address
  }
}

resource "yandex_lb_network_load_balancer" "this" {
  name = "${local.prefix}${var.name}-nlb"
  listener {
    name = "${local.prefix}${var.name}-nlb-listner"
    port = var.nlb_listner_port
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.this.id

    healthcheck {
      name = var.nlb_healthcheck.name
      http_options {
        port = var.nlb_healthcheck.port
        path = var.nlb_healthcheck.path
      }
    }
  }
}

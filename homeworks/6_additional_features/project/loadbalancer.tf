resource "yandex_lb_target_group" "this" {
  name      = "${local.prefix}${var.name}-lb-target-group"
  region_id = "ru-central1"

  dynamic "target" {
    for_each = yandex_compute_instance.this

    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
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

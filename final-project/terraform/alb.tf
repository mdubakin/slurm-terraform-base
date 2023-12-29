resource "yandex_alb_load_balancer" "this" {
  name       = "${var.name}-alb"
  network_id = yandex_vpc_network.this.id

  allocation_policy {
    location {
      zone_id   = var.alb_zone
      subnet_id = yandex_vpc_subnet.this[var.alb_zone].id
    }
  }

  listener {
    name = "${var.name}-listner"

    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }

    http {
      handler {
        http_router_id = yandex_alb_http_router.this.id
      }
    }
  }
}

resource "yandex_alb_virtual_host" "this" {
  name           = "${var.name}-alb-vhost"
  http_router_id = yandex_alb_http_router.this.id
  route {
    name = "my-route"
    http_route {
      http_match {
        path {
          exact = "/"
        }
      }

      http_route_action {
        backend_group_id = yandex_alb_backend_group.this.id
        timeout          = "3s"
      }
    }
  }
}


resource "yandex_alb_backend_group" "this" {
  name = "${var.name}-alb-backend-group"

  http_backend {
    name             = "http-backend"
    weight           = 1
    port             = 80
    target_group_ids = ["${yandex_alb_target_group.this.id}"]

    load_balancing_config {
      panic_threshold = 50
    }

    healthcheck {
      timeout  = "1s"
      interval = "1s"
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_target_group" "this" {
  name = "${var.name}-alb-target-group"

  dynamic "target" {
    for_each = yandex_compute_instance_group.this.instances

    content {
      subnet_id  = target.value.network_interface.0.subnet_id
      ip_address = target.value.network_interface.0.ip_address
    }
  }
}

resource "yandex_alb_http_router" "this" {
  name = "${var.name}-alb-http-router"
}

data "yandex_compute_image" "this" {
  name = "${var.image_name}-${replace(var.image_tag, ".", "-")}"
}

resource "yandex_compute_instance_group" "this" {
  name                = "${var.name}-ig"
  folder_id           = var.folder_id
  service_account_id  = yandex_iam_service_account.this.id
  deletion_protection = var.deletion_protection

  depends_on = [
    yandex_resourcemanager_folder_iam_binding.this,
    yandex_iam_service_account.this
  ]

  instance_template {
    name        = format("%s-{instance.index}", var.name)
    hostname    = format("%s-{instance.index}", var.name)
    platform_id = var.vm_platform_id

    resources {
      cores  = var.resources.cpu
      memory = var.resources.memory
    }

    boot_disk {
      initialize_params {
        size     = var.resources.disk
        image_id = data.yandex_compute_image.this.id
      }
    }

    network_interface {
      nat        = var.nat
      network_id = yandex_vpc_network.this.id
      subnet_ids = [for z in var.az : yandex_vpc_subnet.this[z].id]
    }

    labels = var.labels

    metadata = {
      user-data = templatefile(
        local.cloud_init_file,
        { pubkey = var.public_ssh_key_path != "" ? file(var.public_ssh_key_path) : trimspace(tls_private_key.this[0].public_key_openssh) }
      )
    }
  }

  scale_policy {
    fixed_scale {
      size = var.vm_count
    }
  }

  allocation_policy {
    zones = var.az
  }

  deploy_policy {
    max_unavailable = floor(var.vm_count / 2)
    max_creating    = floor(var.vm_count / 2)
    max_expansion   = floor(var.vm_count / 2)
    max_deleting    = floor(var.vm_count / 2)
  }
}

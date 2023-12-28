resource "yandex_compute_image" "this" {
  source_family = var.image_family
}

resource "yandex_compute_instance" "this" {
  count = var.vm_count

  name        = "${local.prefix}${var.name}-${count.index}"
  platform_id = "standard-v1"
  zone        = var.az[count.index % length(var.az)]
  labels      = var.labels

  allow_stopping_for_update = true

  resources {
    cores  = var.resources.cpu
    memory = var.resources.memory
  }

  boot_disk {
    initialize_params {
      size     = var.resources.disk
      image_id = yandex_compute_image.this.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.this[var.az[count.index % length(var.az)]].id
    nat       = var.nat
  }

  metadata = {
    user-data = templatefile(
      local.cloud_init_file,
      { pubkey = var.public_ssh_key_path != "" ? file(var.public_ssh_key_path) : trimspace(tls_private_key.this[0].public_key_openssh) }
    )
  }
}

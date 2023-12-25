resource "yandex_compute_image" "this" {
  source_family = var.image_family
}

resource "yandex_compute_instance" "this-a" {
  name        = "${local.prefix}${var.name}-a"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"
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
    subnet_id = yandex_vpc_subnet.this-a.id
    nat       = var.nat
  }

  metadata = {
    user-data = file(local.cloud_init_file)
  }
}

resource "yandex_compute_instance" "this-b" {
  name        = "${local.prefix}${var.name}-b"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"
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
    subnet_id = yandex_vpc_subnet.this-b.id
    nat       = var.nat
  }

  metadata = {
    user-data = file(local.cloud_init_file)
  }
}

resource "yandex_compute_instance" "this-c" {
  name        = "${local.prefix}${var.name}-c"
  platform_id = "standard-v1"
  zone        = "ru-central1-c"
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
    subnet_id = yandex_vpc_subnet.this-c.id
    nat       = var.nat
  }

  metadata = {
    user-data = file(local.cloud_init_file)
  }
}

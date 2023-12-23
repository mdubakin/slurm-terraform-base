resource "yandex_compute_image" "this" {
  source_family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "this-a" {
  name        = "slurm-terraform-base-a"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      size     = 10
      image_id = yandex_compute_image.this.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.this-a.id
  }
}

resource "yandex_compute_instance" "this-b" {
  name        = "slurm-terraform-base-b"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"

  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      size     = 10
      image_id = yandex_compute_image.this.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.this-b.id
  }
}

resource "yandex_compute_instance" "this-c" {
  name        = "slurm-terraform-base-c"
  platform_id = "standard-v1"
  zone        = "ru-central1-c"

  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      size     = 10
      image_id = yandex_compute_image.this.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.this-c.id
  }
}

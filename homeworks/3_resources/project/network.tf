resource "yandex_vpc_network" "this" {
  name = "slurm-terraform-base"
}

resource "yandex_vpc_subnet" "this-a" {
  name           = "${yandex_vpc_network.this.name}-subnet-a"
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.this.id
  labels = {
    project = "slurm"
    env     = "lab"
  }
}

resource "yandex_vpc_subnet" "this-b" {
  name           = "${yandex_vpc_network.this.name}-subnet-b"
  v4_cidr_blocks = ["10.3.0.0/16"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.this.id
  labels = {
    project = "slurm"
    env     = "lab"
  }
}

resource "yandex_vpc_subnet" "this-c" {
  name           = "${yandex_vpc_network.this.name}-subnet-c"
  v4_cidr_blocks = ["10.4.0.0/16"]
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.this.id
  labels = {
    project = "slurm"
    env     = "lab"
  }
}

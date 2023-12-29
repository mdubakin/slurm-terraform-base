
variable "image_tag" {
  type = string
}

variable "subnet_id" {
  type = string
}

source "yandex" "nginx" {
  source_image_family = "ubuntu-2204-lts"
  ssh_username        = "ubuntu"

  instance_cores  = 2
  instance_mem_gb = 2
  disk_size_gb    = 10
  subnet_id       = var.subnet_id
  use_ipv4_nat    = "true"

  image_name = "${replace(var.image_tag, ".", "-")}"
}

build {
  sources = ["source.yandex.nginx"]

  provisioner "ansible" {
    playbook_file = "ansible/playbook.yml"
  }
}

packer {
  required_plugins {
    yandex = {
      version = "~> 1"
      source  = "github.com/hashicorp/yandex"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

data "yandex_compute_image" "this" {
  family = var.image_family
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
      image_id = data.yandex_compute_image.this.id
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

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello, World!'",
      "ping -c 3 ya.ru"
    ]

    connection {
      type        = "ssh"
      host        = self.network_interface.0.nat_ip_address
      user        = "student"
      private_key = file("~/.ssh/id_rsa")
      agent       = true
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u student -i '${self.network_interface.0.nat_ip_address},' ansible/playbook.yml"

    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
}

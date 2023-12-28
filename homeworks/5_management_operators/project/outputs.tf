output "external_ip" {
  value = { for instance in yandex_compute_instance.this : instance.name => instance.network_interface.0.nat_ip_address }
}

output "private_ssh_key" {
  value     = var.public_ssh_key_path != "" ? "" : tls_private_key.this[0].private_key_pem
  sensitive = true
}

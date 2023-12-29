output "external_ip_alb" {
  value = yandex_alb_load_balancer.this.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}

output "private_ssh_key" {
  value     = var.public_ssh_key_path != "" ? "" : tls_private_key.this[0].private_key_pem
  sensitive = true
}

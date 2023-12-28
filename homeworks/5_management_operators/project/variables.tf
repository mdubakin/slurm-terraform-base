variable "vm_count" {
  type        = number
  default     = 4
  description = "Count of VM"
}

variable "name" {
  type        = string
  description = "Resources base name"
  default     = "terraform-base"
}

variable "image_family" {
  type        = string
  description = "Image family"
  default     = "ubuntu-2004-lts"
}

variable "nat" {
  type    = bool
  default = true
}

variable "labels" {
  type        = map(string)
  description = "Labels for all objects"
}

variable "resources" {
  type = object({
    cpu    = number
    memory = number
    disk   = number
  })
  description = "Resources of vitrual machine"
}

variable "az" {
  type        = list(string)
  description = "Availability zones"
  default = [
    "ru-central1-a",
    "ru-central1-b"
  ]
}

variable "cidr_blocks" {
  type        = list(list(string))
  description = "CIDR blocks for subsets"
  default = [
    ["10.2.0.0/16"],
    ["10.3.0.0/16"],
    ["10.4.0.0/16"]
  ]
}

variable "nlb_listner_port" {
  type    = number
  default = 80
}

variable "nlb_healthcheck" {
  type = object({
    name = string
    port = number
    path = string
  })
  default = {
    name = "test"
    port = 80
    path = "/"
  }
}

variable "public_ssh_key_path" {
  type    = string
  default = ""
}

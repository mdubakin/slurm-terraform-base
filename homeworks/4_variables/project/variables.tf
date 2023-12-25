variable "name" {
  type        = string
  description = "Name of the virtual machine"
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

variable "cidr_blocks" {
  type        = map(list(string))
  description = "CIDR blocks for subnets in each availability zones"
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

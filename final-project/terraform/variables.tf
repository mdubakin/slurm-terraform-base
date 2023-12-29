// ------- //
// General //
// ------- //

variable "folder_id" {
  type = string
}

variable "az" {
  type        = list(string)
  description = "Availability zones"
  default = [
    "ru-central1-a",
    "ru-central1-b"
  ]
}

variable "name" {
  type        = string
  description = "Resources base name"
  default     = "base-final-project"
}

variable "labels" {
  type        = map(string)
  description = "Labels for all objects"
}

// ---------------------- //
// Compute instance group //
// ---------------------- //

variable "vm_count" {
  type        = number
  default     = 3
  description = "Count of VM"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Compute VM platform: https://cloud.yandex.com/en/docs/compute/concepts/vm-platforms#standard-platforms"
}

variable "image_family" {
  type        = string
  description = "Image family"
  default     = "ubuntu-2004-lts"
}

variable "image_name" {
  type        = string
  description = "Compute image name"
}

variable "image_tag" {
  type        = string
  description = "Compute image tag (x.y.z or x-y-z)"
}

variable "nat" {
  type    = bool
  default = true
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
  type        = list(list(string))
  description = "CIDR blocks for subsets"
  default = [
    ["10.2.0.0/16"],
    ["10.3.0.0/16"],
    ["10.4.0.0/16"]
  ]
}

variable "public_ssh_key_path" {
  type    = string
  default = ""
}

variable "deletion_protection" {
  type    = bool
  default = true
}

// ------------------------- //
// Application Load Balancer //
// ------------------------- //

variable "alb_zone" {
  type    = string
  default = "ru-central1-a"
}

// --------------------- //
// Network Load Balancer //
// --------------------- //

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

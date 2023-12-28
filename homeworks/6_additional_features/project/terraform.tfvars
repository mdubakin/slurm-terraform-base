labels = {
  project = "slurm"
  env     = "lab"
}

resources = {
  cpu    = 2
  memory = 4
  disk   = 10
}

image_family = "centos-7"

public_ssh_key_path = "/Users/maximdubakin/.ssh/id_rsa.pub"

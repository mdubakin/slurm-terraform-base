labels = {
  project = "slurm"
  env     = "lab"
}

resources = {
  cpu    = 2
  memory = 4
  disk   = 10
}

cidr_blocks = {
  a = ["10.2.0.0/16"]
  b = ["10.3.0.0/16"]
  c = ["10.4.0.0/16"]
}

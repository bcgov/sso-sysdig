terraform {
  required_version = ">= 1.1.8"

  backend "kubernetes" {
    secret_suffix = "sysdig-state"
    namespace     = "e4ca1d-tools"
    config_path   = "~/.kube/config"
  }
}

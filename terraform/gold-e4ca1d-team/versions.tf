terraform {
  required_version = ">= 1.1.8"

  required_providers {
    sysdig = {
      source  = "sysdiglabs/sysdig"
      version = "1.26.0"
    }
  }
}

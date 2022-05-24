terraform {
  required_version = ">= 1.1.8"

  backend "s3" {
    bucket = "xgr00q-prod-sysdig"
    key    = "sysdig"
    region = "ca-central-1"
  }
}

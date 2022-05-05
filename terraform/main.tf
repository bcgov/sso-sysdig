module "c6af30-team" {
  source                   = "./c6af30-team"
  sysdig_monitor_api_token = var.c6af30_team_sysdig_monitor_api_token
}

module "c6af30-team-persistent-storage" {
  source                   = "./c6af30-team-persistent-storage"
  sysdig_monitor_api_token = var.c6af30_pv_sysdig_monitor_api_token
}

module "c6af30-team" {
  source                   = "./c6af30-team"
  sysdig_monitor_api_token = var.c6af30_team_sysdig_monitor_api_token
}

module "eb75ad-team" {
  source                   = "./eb75ad-team"
  sysdig_monitor_api_token = var.eb75ad_team_sysdig_monitor_api_token
}

module "silver-3d5c3f-team" {
  source                   = "./silver-3d5c3f-team"
  sysdig_monitor_api_token = var.silver_3d5c3f_team_sysdig_monitor_api_token
}

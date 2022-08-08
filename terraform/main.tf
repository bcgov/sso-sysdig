module "c6af30-team" {
  source                   = "./c6af30-team"
  sysdig_monitor_api_token = var.gold_c6af30_team_sysdig_monitor_api_token
}

module "eb75ad-team" {
  source                   = "./eb75ad-team"
  sysdig_monitor_api_token = var.gold_eb75ad_team_sysdig_monitor_api_token
}

module "c6af30-team" {
  source                   = "./gold-c6af30-team"
  sysdig_monitor_api_token = var.gold_c6af30_team_sysdig_monitor_api_token
}

module "eb75ad-team" {
  source                   = "./gold-eb75ad-team"
  sysdig_monitor_api_token = var.gold_eb75ad_team_sysdig_monitor_api_token
}

module "e4ca1d-team" {
  source                   = "./gold-e4ca1d-team"
  sysdig_monitor_api_token = var.gold_e4ca1d_team_sysdig_monitor_api_token
}

module "b29129-team" {
  source                   = "./gold-b29129-team"
  sysdig_monitor_api_token = var.gold_b29129_team_sysdig_monitor_api_token
}

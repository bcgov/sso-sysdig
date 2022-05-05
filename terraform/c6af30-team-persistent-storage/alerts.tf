resource "sysdig_monitor_alert_promql" "prod_db_backup_pv_gt_60" {
  name        = "[PROD] DB Backup PV over 60%"
  description = ""
  severity    = 4
  enabled     = false

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"c6af30-prod\", persistentvolumeclaim=\"patroni-backup-storage-backup-pvc\"} * 100 /\nkubelet_volume_stats_capacity_bytes{namespace=\"c6af30-prod\", persistentvolumeclaim=\"patroni-backup-storage-backup-pvc\"}) by (persistentvolumeclaim) > 60"
  trigger_after_minutes = 10

  notification_channels = []
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}


resource "sysdig_monitor_alert_promql" "prod_sso_db_pv_gt_60" {
  name        = "[PROD] SSO DB PV over 60%"
  description = ""
  severity    = 4
  enabled     = false

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"c6af30-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"c6af30-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 60"
  trigger_after_minutes = 10

  notification_channels = []
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "prod_sso_db_pv_gt_80" {
  name        = "[PROD] SSO DB PV over 80%"
  description = ""
  severity    = 2
  enabled     = false

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"c6af30-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"c6af30-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 80"
  trigger_after_minutes = 10

  notification_channels = []
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

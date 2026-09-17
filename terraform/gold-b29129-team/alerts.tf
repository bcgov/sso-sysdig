resource "sysdig_monitor_alert_promql" "prod_db_pv_usage_low" {
  name        = "[GOLD SSO-REQUESTS PROD] DB PV over 85%"
  description = "This alert covers gold prod pvcs"
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"b29129-prod\", persistentvolumeclaim=~\"storage-volume-sso-requests-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"b29129-prod\", persistentvolumeclaim=~\"storage-volume-sso-requests-.*\"}) by (persistentvolumeclaim, kube_cluster_name) > 85"
  trigger_after_minutes = 2

  notification_channels = [474958, 474959, 474960]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

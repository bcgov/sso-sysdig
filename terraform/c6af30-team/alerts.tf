resource "sysdig_monitor_alert_metric" "prod_db_backup_storage_gt_85" {
  name        = "[PROD] DB Backup - storage 85%"
  description = ""
  severity    = 4
  enabled     = false

  metric                = "max(avg(sysdig_container_fs_used_percent)) > 85"
  trigger_after_minutes = 5

  scope              = "kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"patroni-backup-storage\")"
  multiple_alerts_by = []

  notification_channels = [47969]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_db_pod_restarts_gte_1" {
  name        = "[PROD] DB - Pod Restarts"
  description = ""
  severity    = 2
  enabled     = false

  metric                = "sum(avg(kube_pod_sysdig_restart_count)) >= 1"
  trigger_after_minutes = 5

  scope              = "kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.pod.label.statefulset in (\"sso-pgsql-prod\")"
  multiple_alerts_by = []

  notification_channels = [47969]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_db_pods_lt_2" {
  name        = "[PROD] DB - Ready Pods High"
  description = ""
  severity    = 0
  enabled     = false

  metric                = "sum(avg(kube_pod_sysdig_status_ready)) < 2"
  trigger_after_minutes = 5

  scope              = "kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.pod.label.statefulset in (\"sso-pgsql-prod\")"
  multiple_alerts_by = []

  notification_channels = [47969]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_db_pods_lt_2_5" {
  name        = "[PROD] DB - Ready Pods Low"
  description = ""
  severity    = 2
  enabled     = false

  metric                = "sum(avg(kube_pod_sysdig_status_ready)) < 2.5"
  trigger_after_minutes = 5

  scope              = "kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.pod.label.statefulset in (\"sso-pgsql-prod\")"
  multiple_alerts_by = []

  notification_channels = [47969]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_cpu_max_gt_5" {
  name        = "[PROD] SSO - CPU Spike Over 5"
  description = ""
  severity    = 0
  enabled     = false

  metric                = "avg(max(sysdig_container_cpu_cores_used)) > 5"
  trigger_after_minutes = 5

  scope              = "kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [47969]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_cpu_gt_5" {
  name        = "[PROD] SSO - CPU Usage High"
  description = ""
  severity    = 0
  enabled     = false

  metric                = "sum(avg(sysdig_container_cpu_cores_used)) > 5"
  trigger_after_minutes = 5

  scope              = "kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [47969]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_cpu_gte_3" {
  name        = "[PROD] SSO - CPU Usage Med"
  description = ""
  severity    = 4
  enabled     = false

  metric                = "sum(avg(sysdig_container_cpu_cores_used)) >= 3"
  trigger_after_minutes = 5

  scope              = "kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [47969]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_lt_5" {
  name        = "[PROD] SSO - Ready Pods High"
  description = ""
  severity    = 0
  enabled     = false

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 5"
  trigger_after_minutes = 5

  scope              = "kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [47969]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_lt_6" {
  name        = "[PROD] SSO - Ready Pods Med"
  description = ""
  severity    = 2
  enabled     = false

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 6"
  trigger_after_minutes = 5

  scope              = "kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [47969]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_lt_7" {
  name        = "[PROD] SSO - Ready Pods Low"
  description = ""
  severity    = 4
  enabled     = false

  metric                = "sum(max(kube_pod_sysdig_status_ready)) < 7"
  trigger_after_minutes = 5

  scope              = "kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [47969]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

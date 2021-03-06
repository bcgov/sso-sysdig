
resource "sysdig_monitor_alert_metric" "prod_keycloak_cpu_spike_high" {
  name        = "[GOLD CUST PROD] SSO - CPU Spike Over 5"
  description = ""
  severity    = 0
  enabled     = true

  metric                = "avg(max(sysdig_container_cpu_cores_used)) > 5"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_cpu_usage_high" {
  name        = "[GOLD CUST PROD] SSO - CPU Usage High"
  description = ""
  severity    = 0
  enabled     = true

  metric                = "sum(avg(sysdig_container_cpu_cores_used)) > 5"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_cpu_usage_med" {
  name        = "[GOLD CUST PROD] SSO - CPU Usage Med"
  description = ""
  severity    = 4
  enabled     = true

  metric                = "sum(avg(sysdig_container_cpu_cores_used)) >= 3"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_high" {
  name        = "[GOLD CUST PROD] SSO - Ready Pods High"
  description = ""
  severity    = 0
  enabled     = true

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 3"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_med" {
  name        = "[GOLD CUST PROD] SSO - Ready Pods Med"
  description = ""
  severity    = 2
  enabled     = true

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 4"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_low" {
  name        = "[GOLD CUST PROD] SSO - Ready Pods Low"
  description = ""
  severity    = 4
  enabled     = true

  metric                = "sum(max(kube_pod_sysdig_status_ready)) < 5"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_log_pv_med" {
  name        = "[GOLD CUST PROD] SSO - Log PV Usage over 70%"
  description = ""
  severity    = 2
  enabled     = true

  metric                = "max(avg(sysdig_container_fs_used_percent)) > 70"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_db_pod_restarts_gte_1" {
  name        = "[GOLD CUST PROD] DB - Pod Restarts"
  description = ""
  severity    = 2
  enabled     = true

  metric                = "sum(avg(kube_pod_sysdig_restart_count)) >= 1"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.pod.label.statefulset in (\"sso-patroni\")"
  multiple_alerts_by = []

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_db_pods_high" {
  name        = "[GOLD CUST PROD] DB - Ready Pods High"
  description = ""
  severity    = 0
  enabled     = true

  metric                = "sum(avg(kube_pod_sysdig_status_ready)) < 2"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.pod.label.statefulset in (\"sso-patroni\")"
  multiple_alerts_by = []

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_db_pods_low" {
  name        = "[GOLD CUST PROD] DB - Ready Pods Low"
  description = ""
  severity    = 2
  enabled     = true

  metric                = "sum(avg(kube_pod_sysdig_status_ready)) < 2.5"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.pod.label.statefulset in (\"sso-patroni\")"
  multiple_alerts_by = []

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_backup_storage_pv_usage_gt_med" {
  name        = "[GOLD CUST PROD] DB Backup - storage 85%"
  description = ""
  severity    = 2
  enabled     = true

  metric                = "max(avg(sysdig_container_fs_used_percent)) > 85"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-backup-storage\")"
  multiple_alerts_by = []

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "prod_backup_storage_pv_usage_gt_low" {
  name        = "[GOLD CUST PROD] DB Backup PV over 60%"
  description = ""
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{cluster=\"gold\", namespace=\"eb75ad-prod\", persistentvolumeclaim=\"sso-backup-storage-backup-pvc\"} * 100 /\nkubelet_volume_stats_capacity_bytes{cluster=\"gold\", namespace=\"eb75ad-prod\", persistentvolumeclaim=\"sso-backup-storage-backup-pvc\"}) by (persistentvolumeclaim) > 60"
  trigger_after_minutes = 2

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}


resource "sysdig_monitor_alert_promql" "prod_db_pv_usage_low" {
  name        = "[GOLD CUST PROD] SSO DB PV over 60%"
  description = ""
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{cluster=\"gold\", namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{cluster=\"gold\", namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 60"
  trigger_after_minutes = 2

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "prod_db_pv_usage_med" {
  name        = "[GOLD CUST PROD] SSO DB PV over 80%"
  description = ""
  severity    = 2
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{cluster=\"gold\", namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{cluster=\"gold\", namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 80"
  trigger_after_minutes = 2

  notification_channels = [45990, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

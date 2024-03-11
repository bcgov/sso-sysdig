
resource "sysdig_monitor_alert_metric" "prod_keycloak_cpu_spike_high" {
  name        = "[GOLD CUST PROD] SSO - CPU Spike Over 5"
  description = ""
  severity    = 0
  enabled     = true

  metric                = "avg(max(sysdig_container_cpu_cores_used)) > 5"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
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

  notification_channels = [132277, 57336, 57341]
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

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}


resource "sysdig_monitor_alert_metric" "prod_keycloak_cpu_usage_sustained" {
  name        = "[GOLD CUST PROD] Keycloak - Sustained Elevated CPU"
  description = "When the CPU is elevated for a long period of time it may indicate pod health issues."
  severity    = 4
  enabled     = true

  metric                = "max(avg(sysdig_container_cpu_cores_used)) >= 0.20"
  trigger_after_minutes = 30

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [132277, 57336]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_high" {
  name        = "[GOLD CUST PROD] SSO - Ready Pods High"
  description = ""
  severity    = 0
  enabled     = true

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 4"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_med" {
  name        = "[GOLD CUST PROD] SSO - Ready Pods Med"
  description = ""
  severity    = 2
  enabled     = true

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 6"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_low" {
  name        = "[GOLD CUST PROD] SSO - Ready Pods Low"
  description = ""
  severity    = 4
  enabled     = true

  metric                = "sum(max(kube_pod_sysdig_status_ready)) < 7"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_log_pv_high" {
  name        = "[GOLD CUST PROD] SSO - Log PV Usage over 90%"
  description = ""
  severity    = 0
  enabled     = true

  metric                = "max(avg(sysdig_container_fs_used_percent)) > 90"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_log_pv_med" {
  name        = "[GOLD CUST PROD] SSO - Log PV Usage over 70%"
  description = ""
  severity    = 4
  enabled     = true

  metric                = "max(avg(sysdig_container_fs_used_percent)) > 70"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_db_pod_restarts_gte_1" {
  name        = "[GOLD CUST PROD] DB - Pod Restarts"
  description = ""
  severity    = 4
  enabled     = true

  metric                = "sum(avg(kube_pod_sysdig_restart_count)) >= 1"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.statefulset.name in (\"sso-patroni\")"
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
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

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.pod.name contains \"sso-patroni\""
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
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
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.pod.name contains \"sso-patroni\""
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_backup_storage_pv_usage_gt_med" {
  name        = "[GOLD CUST PROD] DB Backup - storage 80%"
  description = ""
  severity    = 4
  enabled     = true

  metric                = "max(avg(sysdig_container_fs_used_percent)) > 80"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.deployment.name in (\"sso-backup-storage\")"
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "dev_backup_storage_pv_usage_gt_med" {
  name        = "[GOLD CUST DEV] DB Backup - storage 85%"
  description = ""
  severity    = 4
  enabled     = true

  metric                = "max(avg(sysdig_container_fs_used_percent)) > 85"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-dev\") and kubernetes.deployment.name in (\"sso-backup-storage\")"
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "test_backup_storage_pv_usage_gt_med" {
  name        = "[GOLD CUST TEST] DB Backup - storage 85%"
  description = ""
  severity    = 4
  enabled     = true

  metric                = "max(avg(sysdig_container_fs_used_percent)) > 85"
  trigger_after_minutes = 2

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"eb75ad-test\") and kubernetes.deployment.name in (\"sso-backup-storage\")"
  multiple_alerts_by = []

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "prod_minio_pvc_storage_low" {
  name        = "[GOLD PROD] Minio PVC over 70%"
  description = "The minio pvc is over 70%, increase via the terraform chart in the sso-dashboard repos"
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{ namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"export-sso-minio-.*\"} * 100 /\nkubelet_volume_stats_capacity_bytes{namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"export-sso-minio-.*\"}) by (persistentvolumeclaim) > 70"
  trigger_after_minutes = 2

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "prod_db_pv_usage_low" {
  name        = "[GOLD CUST PROD] SSO DB PV over 60%"
  description = ""
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 60"
  trigger_after_minutes = 2

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "prod_db_pv_usage_med" {
  name        = "[GOLD CUST PROD] SSO DB PV over 80%"
  description = ""
  severity    = 2
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 80"
  trigger_after_minutes = 2

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "prod_db_pv_usage_high" {
  name        = "[GOLD CUST PROD] SSO DB PV over 90%"
  description = ""
  severity    = 0
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"eb75ad-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 90"
  trigger_after_minutes = 2

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "dev_db_pv_usage_seventyfive" {
  name        = "[GOLD CUST DEV] SSO DB PV over 75%"
  description = "only alert rocket chat and email for 75%"
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"eb75ad-dev\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"eb75ad-dev\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 75"
  trigger_after_minutes = 2

  notification_channels = [132277, 57336]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "dev_db_pv_usage_ninety" {
  name        = "[GOLD CUST DEV] SSO DB PV over 90%"
  description = ""
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"eb75ad-dev\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"eb75ad-dev\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 90"
  trigger_after_minutes = 2

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "test_db_pv_usage_seventyfive" {
  name        = "[GOLD CUST TEST] SSO DB PV over 75%"
  description = "only alert rocket chat and email for 75%"
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"eb75ad-test\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"eb75ad-test\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 75"
  trigger_after_minutes = 2

  notification_channels = [132277, 57336]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "test_db_pv_usage_ninety" {
  name        = "[GOLD CUST TEST] SSO DB PV over 90%"
  description = ""
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"eb75ad-test\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"eb75ad-test\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 90"
  trigger_after_minutes = 2

  notification_channels = [132277, 57336, 57341]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "dev_dr_pod" {
  name        = "[GOLDDR DEV] Switchover Agent Pod Count"
  description = "detects if the pod is up, but not healthy"
  severity    = 4
  enabled     = true

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 1"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"golddr\") and kubernetes.namespace.name in (\"eb75ad-dev\") and kubernetes.pod.name contains \"switchover-agent\""
  multiple_alerts_by = []

  notification_channels = [132277, 57336]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "test_dr_pod" {
  name        = "[GOLDDR TEST] Switchover Agent Pod Count"
  description = "detects if the pod is up, but not healthy"
  severity    = 4
  enabled     = true

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 1"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"golddr\") and kubernetes.namespace.name in (\"eb75ad-test\") and kubernetes.pod.name contains \"switchover-agent\""
  multiple_alerts_by = []

  notification_channels = [132277, 57336]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_dr_pod" {
  name        = "[GOLDDR PROD] Switchover Agent Pod Count"
  description = "detects if the pod is up, but not healthy"
  severity    = 4
  enabled     = true

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 1"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"golddr\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.pod.name contains \"switchover-agent\""
  multiple_alerts_by = []

  notification_channels = [132277, 57336]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_downtime" "dev_dr_pod_downtime" {
  name                = "[GoldDR] Dev Switchover Downtime Alert"
  description         = "Detects a downtime in the Kubernetes cluster"
  severity            = 4
  enabled             = true
  entities_to_monitor = ["kubernetes.namespace.name"]
  scope               = "kubernetes.cluster.name in (\"golddr\") and kubernetes.namespace.name in (\"eb75ad-dev\") and kubernetes.pod.name contains \"switchover-agent\""

  notification_channels = [132277, 57336]

  trigger_after_minutes = 10
  trigger_after_pct     = 100
}

resource "sysdig_monitor_alert_downtime" "test_dr_pod_downtime" {
  name                = "[GoldDR] Test Switchover Downtime Alert"
  description         = "Detects a downtime in the Kubernetes cluster"
  severity            = 4
  enabled             = true
  entities_to_monitor = ["kubernetes.namespace.name"]
  scope               = "kubernetes.cluster.name in (\"golddr\") and kubernetes.namespace.name in (\"eb75ad-test\") and kubernetes.pod.name contains \"switchover-agent\""

  notification_channels = [132277, 57336]

  trigger_after_minutes = 10
  trigger_after_pct     = 100
}

resource "sysdig_monitor_alert_downtime" "prod_dr_pod_downtime" {
  name                = "[GoldDR] Prod Switchover Downtime Alert"
  description         = "Detects a downtime in the Kubernetes cluster"
  severity            = 4
  enabled             = true
  entities_to_monitor = ["kubernetes.namespace.name"]
  scope               = "kubernetes.cluster.name in (\"golddr\") and kubernetes.namespace.name in (\"eb75ad-prod\") and kubernetes.pod.name contains \"switchover-agent\""

  notification_channels = [132277, 57336]

  trigger_after_minutes = 10
  trigger_after_pct     = 100
}

resource "sysdig_monitor_alert_promql" "dev_kc_disk_log_pv_usage_sixty" {
  name        = "[GOLD CUST DEV] SSO Keycloak Logs PV over 60%"
  description = "only alert rocket chat and email for 60%"
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"eb75ad-dev\", persistentvolumeclaim=\"sso-keycloak-logs\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"eb75ad-dev\", persistentvolumeclaim=\"sso-keycloak-logs\"}) by (persistentvolumeclaim) > 60"
  trigger_after_minutes = 2

  notification_channels = [132277, 57336]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "test_kc_disk_log_pv_usage_sixty" {
  name        = "[GOLD CUST TEST] SSO Keycloak Logs PV over 60%"
  description = "only alert rocket chat and email for 60%"
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"eb75ad-test\", persistentvolumeclaim=\"sso-keycloak-logs\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"eb75ad-test\", persistentvolumeclaim=\"sso-keycloak-logs\"}) by (persistentvolumeclaim) > 60"
  trigger_after_minutes = 2

  notification_channels = [132277, 57336]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "prod_kc_disk_log_pv_usage_sixty" {
  name        = "[GOLD CUST PROD] SSO Keycloak Logs PV over 60%"
  description = "only alert rocket chat and email for 60%"
  severity    = 4
  enabled     = true

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"eb75ad-prod\", persistentvolumeclaim=\"sso-keycloak-logs\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"eb75ad-prod\", persistentvolumeclaim=\"sso-keycloak-logs\"}) by (persistentvolumeclaim) > 60"
  trigger_after_minutes = 2

  notification_channels = [132277, 57336]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

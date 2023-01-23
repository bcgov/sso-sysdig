resource "sysdig_monitor_alert_metric" "prod_db_pod_restarts_gte_1" {
  name        = "[GOLD SANDBOX PROD] DB - Pod Restarts"
  description = ""
  severity    = 2
  enabled     = false

  metric                = "sum(avg(kube_pod_sysdig_restart_count)) >= 1"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.pod.label.statefulset in (\"sso-patroni\")"
  multiple_alerts_by = []

  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_db_pods_high" {
  name        = "[GOLD SANDBOX PROD] DB - Ready Pods High"
  description = ""
  severity    = 0
  enabled     = false

  metric                = "sum(avg(kube_pod_sysdig_status_ready)) < 2"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.pod.name contains (\"sso-patroni\")"
  multiple_alerts_by = []

  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_db_pods_low" {
  name        = "[GOLD SANDBOX PROD] DB - Ready Pods Low"
  description = ""
  severity    = 2
  enabled     = false

  metric                = "sum(avg(kube_pod_sysdig_status_ready)) < 2.5"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.pod.name contains (\"sso-patroni\")"
  multiple_alerts_by = []

  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_cpu_spike_high" {
  name        = "[GOLD SANDBOX PROD] SSO - CPU Spike Over 5"
  description = ""
  severity    = 0
  enabled     = false

  metric                = "avg(max(sysdig_container_cpu_cores_used)) > 5"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_cpu_usage_high" {
  name        = "[GOLD SANDBOX PROD] SSO - CPU Usage High"
  description = ""
  severity    = 0
  enabled     = false

  metric                = "sum(avg(sysdig_container_cpu_cores_used)) > 5"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_cpu_usage_med" {
  name        = "[GOLD SANDBOX PROD] SSO - CPU Usage Med"
  description = ""
  severity    = 4
  enabled     = false

  metric                = "sum(avg(sysdig_container_cpu_cores_used)) >= 3"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_high" {
  name        = "[GOLD SANDBOX PROD] SSO - Ready Pods High"
  description = ""
  severity    = 0
  enabled     = false

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 3"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_med" {
  name        = "[GOLD SANDBOX PROD] SSO - Ready Pods Med"
  description = ""
  severity    = 2
  enabled     = false

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 4"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_keycloak_pods_low" {
  name        = "[GOLD SANDBOX PROD] SSO - Ready Pods Low"
  description = ""
  severity    = 4
  enabled     = false

  metric                = "sum(max(kube_pod_sysdig_status_ready)) < 5"
  trigger_after_minutes = 5

  scope              = "kubernetes.cluster.name in (\"gold\") and kubernetes.namespace.name in (\"c6af30-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  multiple_alerts_by = []

  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "prod_sso_db_pv_gt_60" {
  name        = "[GOLD SANDBOX PROD] SSO DB PV over 60%"
  description = ""
  severity    = 4
  enabled     = false

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"c6af30-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"c6af30-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 60"
  trigger_after_minutes = 10

  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "prod_sso_db_pv_gt_80" {
  name        = "[GOLD SANDBOX PROD] SSO DB PV over 80%"
  description = ""
  severity    = 2
  enabled     = false

  promql                = "avg(kubelet_volume_stats_used_bytes{namespace=\"c6af30-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}*100 / kubelet_volume_stats_capacity_bytes{namespace=\"c6af30-prod\", persistentvolumeclaim=~\"storage-volume-sso-patroni-.*\"}) by (persistentvolumeclaim) > 80"
  trigger_after_minutes = 10

  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

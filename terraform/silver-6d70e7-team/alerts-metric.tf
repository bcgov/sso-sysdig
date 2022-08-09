resource "sysdig_monitor_alert_metric" "sso_cpu_spike_med" {
  name                  = "App - Prod - SSO - CPU Spike Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 2
  enabled               = false
  metric                = "avg(max(cpu.cores.used)) > 2"
  trigger_after_minutes = 5
  scope                 = "kubernetes.namespace.name in (\"6d70e7-prod\") and kubernetes.pod.label.deploymentConfig in (\"sso-prod\")"
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "db_filesystem_limit_med" {
  name                  = "App - Prod - SSO - DB Filesystem > 60% Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 2
  enabled               = false
  metric                = "max(avg(fs.used.percent)) > 60"
  trigger_after_minutes = 10
  scope                 = "kubernetes.namespace.name in (\"6d70e7-prod\") and kubernetes.pod.label.statefulset in (\"sso-pgsql-prod\")"
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "sso_pod_restart" {
  name                  = "App - Prod - SSO - Pod Restart Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 4
  enabled               = false
  metric                = "sum(max(kubernetes.pod.restart.count)) >= 1"
  trigger_after_minutes = 10
  scope                 = "kubernetes.namespace.name in (\"6d70e7-prod\")"
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "patroni_backup_storage_low" {
  name                  = "App - Prod - SSO - Patroni Backup storage > 85% Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 4
  enabled               = true
  metric                = "max(avg(fs.used.percent)) > 85"
  trigger_after_minutes = 10
  scope                 = "kubernetes.namespace.name in (\"6d70e7-prod\") and kubernetes.deployment.name in (\"patroni-backup-storage\")"
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "pgsql_pod_restart_med" {
  name                  = "App - Prod - SSO-PGSQL - Pod Restart Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 2
  enabled               = true
  metric                = "sum(avg(kubernetes.pod.restart.count)) >= 1"
  trigger_after_minutes = 10
  scope                 = "kubernetes.namespace.name in (\"6d70e7-prod\") and kubernetes.pod.label.statefulset in (\"sso-pgsql-prod\")"
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "keycloak_cpu_spike_high" {
  name                  = "App - Prod - SSO - CPU Spike Over 5 Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 0
  enabled               = true
  metric                = "avg(max(cpu.cores.used)) > 5"
  trigger_after_minutes = 5
  scope                 = "kubernetes.namespace.name in (\"6d70e7-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "sso_pods_down_low" {
  name                  = "SSO keycloak pods CPU usage Terraform Silver"
  description           = "Managed by terraform: Sum of the average CPU used by SSO keycloak pods"
  severity              = 4
  enabled               = true
  metric                = "sum(avg(cpu.cores.used)) >= 3"
  trigger_after_minutes = 5
  scope                 = "kubernetes.deployment.name in (\"sso-keycloak\") and kubernetes.namespace.name in (\"6d70e7-prod\")"
  notification_channels = [47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "sso_pods_down_med" {
  name                  = "OLD ALERT: SSO - Ready Pods Med Terraform Silver"
  description           = "Managed by terraform: Number of ready sso pods has dropped below acceptable level"
  severity              = 2
  enabled               = true
  metric                = "sum(max(kube_pod_sysdig_status_ready)) < 6.0"
  trigger_after_minutes = 10
  scope                 = "kubernetes.namespace.name in (\"6d70e7-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  notification_channels = [45990]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "keycloak_cpu_elevated_high" {
  name                  = "SSO Keycloak CPU over 5 Terraform Silver"
  description           = "Managed by terraform: The sum of CPU usage for keycloak pods is over 5"
  severity              = 0
  enabled               = true
  metric                = "sum(avg(cpu.cores.used)) > 5"
  trigger_after_minutes = 5
  scope                 = "kubernetes.deployment.name in (\"sso-keycloak\") and kubernetes.namespace.name in (\"6d70e7-prod\")"
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "patroni_pods_down_med" {
  name                  = "OLD ALERT:Patroni - Ready Pods Med Terraform Silver"
  description           = "Managed by terraform: Alert if the number of ready patroni pods has dipped below acceptable level"
  severity              = 2
  enabled               = true
  metric                = "sum(avg(kube_pod_sysdig_status_ready)) < 2.5"
  trigger_after_minutes = 10
  scope                 = "kubernetes.pod.label.statefulset in (\"sso-pgsql-prod\")"
  notification_channels = [45990]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "sso_pods_down_high" {
  name                  = "OLD ALERT:SSO - Ready Pods High Terraform Silver"
  description           = "Managed by terraform: Number of ready sso pods has dropped below acceptable level"
  severity              = 0
  enabled               = true
  metric                = "sum(max(kube_pod_sysdig_status_ready)) < 5.0"
  trigger_after_minutes = 5
  scope                 = "kubernetes.namespace.name in (\"6d70e7-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  notification_channels = [45990]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "patroni_pods_down_low" {
  name                  = "OLD ALERT:SSO - Ready Pods Low Terraform Silver"
  description           = "Managed by terraform: Number of ready sso pods has dropped below acceptable level and as been so for at least 5 minutes"
  severity              = 4
  enabled               = false
  metric                = "sum(max(kube_pod_sysdig_status_ready)) < 7.0"
  trigger_after_minutes = 16
  scope                 = "kubernetes.namespace.name in (\"6d70e7-prod\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "patroni_pods_down_high" {
  name                  = "OLD ALERT:Patroni - Ready Pods High Terraform Silver"
  description           = "Managed by terraform: Alert if the number of ready patroni pods has dipped below acceptable level"
  severity              = 0
  enabled               = true
  metric                = "sum(avg(kube_pod_sysdig_status_ready)) < 2.0"
  trigger_after_minutes = 10
  scope                 = "kubernetes.pod.label.statefulset in (\"sso-pgsql-prod\")"
  notification_channels = [45990]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "sand_keycloak_pods_low" {
  name        = "SSO - SANBOX - Ready Pods Low (with silver cluster stated) Terraform"
  description = "Managed by terraform:Number of ready sso pods has dropped below acceptable level"
  severity    = 4
  enabled     = false

  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 2"
  trigger_after_minutes = 1

  scope              = "kubernetes.namespace.name in (\"3d5c3f-dev\") and kubernetes.deployment.name in (\"sso-keycloak\") and kubernetes.cluster.name in (\"silver\")"
  multiple_alerts_by = []

  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "sand_patroni_pods_low" {
  name        = "[DEV] SANDBOX - Patroni Ready Pods Low Terraform"
  description = "Managed by terraform: Number of ready patroni pods has dropped below 3"
  severity    = 4
  enabled     = false

  metric                = "sum(avg(kubernetes.pod.status.ready)) < 3"
  trigger_after_minutes = 5

  scope              = "kubernetes.namespace.name in (\"3d5c3f-dev\") and kubernetes.pod.label.statefulset in (\"sso-pgsql-dev\")"
  multiple_alerts_by = []

  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}



resource "sysdig_monitor_alert_metric" "sand_prod_keycloak_pods_high" {
  name                  = "SSO - SANBOX - Ready Pods High Terraform Silver"
  description           = "Managed by terraform: Number of ready sso pods has dropped below acceptable level"
  severity              = 0
  enabled               = true
  metric                = "sum(max(kube_pod_sysdig_status_ready)) = 0"
  trigger_after_minutes = 1
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-dev\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }


  renotification_minutes = 30
}

resource "sysdig_monitor_alert_metric" "sand_prod_keycloak_pods_med" {
  name                  = "SSO - SANBOX - Ready Pods Med Terraform Silver"
  description           = "Managed by terraform: Number of ready sso pods has dropped below acceptable level"
  severity              = 2
  enabled               = true
  metric                = "sum(min(kube_pod_sysdig_status_ready)) < 1"
  trigger_after_minutes = 1
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-dev\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "sand_prod_patroni_pods_med" {
  name                  = "Patroni - SANDBOX - Ready Pods Med Terraform Silver"
  description           = "Managed by terraform: Number of ready patroni pods has dropped below 3"
  severity              = 2
  enabled               = true
  metric                = "sum(avg(kube_pod_sysdig_status_ready)) < 2.5"
  trigger_after_minutes = 5
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-dev\") and kubernetes.pod.label.statefulset in (\"sso-pgsql-dev\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "sand_dev_patroni_pods_med" {
  name                  = "Patroni - SANDBOX - Ready Pods High Terraform Silver"
  description           = "Managed by terraform: Number of ready patroni pods has dropped below 3"
  severity              = 0
  enabled               = true
  metric                = "sum(avg(kube_pod_sysdig_status_ready)) < 2"
  trigger_after_minutes = 5
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-dev\") and kubernetes.pod.label.statefulset in (\"sso-pgsql-dev\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}




resource "sysdig_monitor_alert_metric" "sand_prod_cpu_spike" {
  name                  = "PROD SANDBOX: CPU Spike - avg(max(cpu.cores.used)) > 2 Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 4
  enabled               = false
  metric                = "avg(max(cpu.cores.used)) > 2"
  trigger_after_minutes = 5
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-prod\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "sand_prod_patroni_cpu_spike" {
  name                  = "PROD SANDBOX: Patroni Backup storage Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 4
  enabled               = false
  metric                = "avg(avg(fs.used.percent)) > 85"
  trigger_after_minutes = 10
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-prod\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "sand_dev_sso_cpu_spike" {
  name                  = "SSO - SANDBOX - CPU Spike Over 5 Terraform Silver"
  description           = "Managed by terraform: Alert if sandbox over 5 CPU"
  severity              = 0
  enabled               = true
  metric                = "avg(max(sysdig_container_cpu_cores_used)) > 5"
  trigger_after_minutes = 5
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-dev\") and kubernetes.deployment.name contains \"sso-keycloak\""
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "sand_dev_sso_cpu_spike_two" {
  name                  = "SSO - SANDBOX - CPU over 5 Terraform Silver"
  description           = "Managed by terraform: The sum of CPU usage for keycloak pods is over 5"
  severity              = 0
  enabled               = true
  metric                = "sum(avg(sysdig_container_cpu_cores_used)) > 5"
  trigger_after_minutes = 5
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-dev\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}


resource "sysdig_monitor_alert_metric" "sand_dev_sso_cpu_elevated" {
  name                  = "SSO - SANDBOX - CPU usage Terraform Silver"
  description           = "Managed by terraform: Sum of the average CPU used by SSO keycloak pods"
  severity              = 4
  enabled               = true
  metric                = "sum(avg(sysdig_container_cpu_cores_used)) >= 3"
  trigger_after_minutes = 1
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-dev\") and kubernetes.deployment.name in (\"sso-keycloak\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}


resource "sysdig_monitor_alert_metric" "pgsql_pod_restart_prod" {
  name                  = "TEST SANDBOX: PGSQL pod restart Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 0
  enabled               = false
  metric                = "avg(min(kubernetes.pod.restart.count)) < 5"
  trigger_after_minutes = 1
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-prod\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_metric" "prod_filesystem_over_sixty" {
  name                  = "TEST SANDBOX: db filesystem>60 Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 4
  enabled               = false
  metric                = "avg(avg(fs.used.percent)) > 60"
  trigger_after_minutes = 10
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-prod\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}





resource "sysdig_monitor_alert_metric" "request_time_alert_test" {
  name                  = "TEST SANDBOX: New Metric Alert Terraform Silver"
  description           = "Managed by terraform: ztest 2"
  severity              = 4
  enabled               = false
  metric                = "avg(sum(net.http.request.time)) < 2500000"
  trigger_after_minutes = 5

  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}} sev: {__alert_severity__}} --> LOW"
  }
}

resource "sysdig_monitor_alert_metric" "request_time_alert_test_two" {
  name                  = "TEST SANDBOX: New Metric Alert 2 Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 2
  enabled               = false
  metric                = "sum(timeAvg(net.http.request.count)) > 0.5"
  trigger_after_minutes = 5

  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}} SEV {{__alert_severity__}} -->MED"
  }
}

resource "sysdig_monitor_alert_metric" "request_time_alert_test_three" {
  name                  = "TEST SANDBOX:  Alert 3 last tested Jan 19 Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 0
  enabled               = false
  metric                = "avg(avg(memory.used.percent)) >= 0"
  trigger_after_minutes = 10
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-prod\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}} SEV {{__alert_severity__}} --->HIGH"
  }
}

resource "sysdig_monitor_alert_metric" "request_time_alert_test_four" {
  name                  = "TEST SANDBOX: New Metric Alert 4 Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 6
  enabled               = false
  metric                = "sum(avg(kubernetes.pod.status.ready)) > 1"
  trigger_after_minutes = 10
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-dev\") and kubernetes.pod.label.statefulset in (\"sso-pgsql-dev\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}  SEV {{__alert_severity__}} --> INFO"
  }
}

resource "sysdig_monitor_alert_metric" "reques_count_alert_three" {
  name                  = "TEST SANDBOX: New Metric Alert 3 Terraform Silver"
  description           = "Managed by terraform: undefined"
  severity              = 0
  enabled               = false
  metric                = "sum(timeAvg(net.http.request.count)) > 0.5"
  trigger_after_minutes = 5

  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}} SEV {{__alert_severity__}} -->MED"
  }
}

resource "sysdig_monitor_alert_metric" "ops_genie_alert" {
  name                  = "SSO Ops Genie test Terraform Silver"
  description           = "Managed by terraform: must integrate with opsgenie to work"
  severity              = 0
  enabled               = true
  metric                = "avg(min(sysdig_container_memory_used_bytes)) > 5376611859824.64"
  trigger_after_minutes = 10
  scope                 = "kubernetes.namespace.name in (\"3d5c3f-dev\") and kubernetes.pod.name in (\"sso-keycloak-79dd4845b4-zffhf\", \"sso-pgsql-dev-0\")"
  notification_channels = [70637]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

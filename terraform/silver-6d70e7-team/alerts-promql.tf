resource "sysdig_monitor_alert_promql" "keycloak_pod_not_ready_med" {
  name                  = "More than 1 keycloak pod not ready Silver Terraform Silver"
  description           = "Managed by terraform: https://github.com/bcgov/sso-keycloak/discussions/41"
  severity              = 2
  enabled               = true
  promql                = <<-EOT
      (
        (
          sum(kube_workload_status_desired{cluster=~"silver",namespace=~"6d70e7-prod",kube_workload_name=~"sso-keycloak",kube_workload_type=~"deployment"})
        )
        -
        (
          sum(kube_workload_status_ready{cluster=~"silver",namespace=~"6d70e7-prod",kube_workload_name=~"sso-keycloak",kube_workload_type=~"deployment"})
        )
      ) > 1
      EOT
  trigger_after_minutes = 8
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}


resource "sysdig_monitor_alert_promql" "keycloak_pod_not_ready_high" {
  name                  = "More than 2 keycloak pods not ready Silver Terraform Silver"
  description           = "Managed by terraform: https://github.com/bcgov/sso-keycloak/discussions/41"
  severity              = 0
  enabled               = true
  promql                = <<-EOT
      (
        (
          sum(kube_workload_status_desired{cluster=~"silver",namespace=~"6d70e7-prod",kube_workload_name=~"sso-keycloak",kube_workload_type=~"deployment"})
        )
        -
        (
          sum(kube_workload_status_ready{cluster=~"silver",namespace=~"6d70e7-prod",kube_workload_name=~"sso-keycloak",kube_workload_type=~"deployment"})
        )
      ) > 2
      EOT
  trigger_after_minutes = 5
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}


resource "sysdig_monitor_alert_promql" "patroni_pod_not_ready_med" {
  name                  = "1 patroni pod not ready Silver Terraform Silver"
  description           = "Managed by terraform: https://github.com/bcgov/sso-keycloak/discussions/41"
  severity              = 2
  enabled               = true
  promql                = <<-EOT
      (
        (
          sum(kube_workload_status_desired{cluster=~"silver",namespace=~"6d70e7-prod",kube_workload_name=~"sso-pgsql-prod-11-patroni",kube_workload_type=~"statefulset"})
        )
        -
        (
          sum(kube_workload_status_ready{cluster=~"silver",namespace=~"6d70e7-prod",kube_workload_name=~"sso-pgsql-prod-11-patroni",kube_workload_type=~"statefulset"})
        )
      ) >= 1
      EOT
  trigger_after_minutes = 5
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}


resource "sysdig_monitor_alert_promql" "patroni_pod_not_ready_high" {
  name                  = "More than 1 patroni pod not ready Silver Terraform Silver"
  description           = "Managed by terraform: https://github.com/bcgov/sso-keycloak/discussions/41"
  severity              = 0
  enabled               = true
  promql                = <<-EOT
      (
        (
          sum(kube_workload_status_desired{cluster=~"silver",namespace=~"6d70e7-prod",kube_workload_name=~"sso-pgsql-prod-11-patroni",kube_workload_type=~"statefulset"})
        )
        -
        (
          sum(kube_workload_status_ready{cluster=~"silver",namespace=~"6d70e7-prod",kube_workload_name=~"sso-pgsql-prod-11-patroni",kube_workload_type=~"statefulset"})
        )
      ) > 1
      EOT
  trigger_after_minutes = 5
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "keycloak_pod_not_ready_low" {
  name                  = "1 keycloak pod not ready Silver (15+ minutes) Terraform Silver"
  description           = "Managed by terraform: https://github.com/bcgov/sso-keycloak/discussions/41"
  severity              = 4
  enabled               = true
  promql                = <<-EOT
      (
        (
          sum(kube_workload_status_desired{cluster=~"silver",namespace=~"6d70e7-prod",kube_workload_name=~"sso-keycloak",kube_workload_type=~"deployment"})
        )
        -
        (
          sum(kube_workload_status_ready{cluster=~"silver",namespace=~"6d70e7-prod",kube_workload_name=~"sso-keycloak",kube_workload_type=~"deployment"})
        )
      ) >= 1
      EOT
  trigger_after_minutes = 15
  notification_channels = [45990, 47291]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "db_pvc_sixty_percent" {
  name                   = "App - Prod - SSO - DB PVC Filesystem > 60% Terraform Silver"
  description            = "Managed by terraform: Alert if postgresql-sso Filesystem exceeds more than 60%."
  severity               = 2
  enabled                = false
  promql                 = "avg(kubelet_volume_stats_used_bytes/kubelet_volume_stats_capacity_bytes) by (persistentvolumeclaim) >= 0.6"
  trigger_after_minutes  = 10
  renotification_minutes = 30
  notification_channels  = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "patroni_pvc_over_sixty" {
  name                  = "Patroni - PVCs > 60% Terraform Silver"
  description           = "Managed by terraform: To resolve, redeploy the patroni helm chart 'silver-patroni' in the sso-keycloak repo with an updated values file."
  severity              = 4
  enabled               = true
  promql                = <<-EOT
          avg(
            kubelet_volume_stats_used_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-prod-11-patroni-.*"}*100
            /
            kubelet_volume_stats_capacity_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-prod-11-patroni-.*"}
          ) by (persistentvolumeclaim)
          > 60
          EOT
  trigger_after_minutes = 10
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "patroni_dev_pvc_over_ninety" {
  name                  = "Patroni - Dev PVCs > 90% Terraform Silver"
  description           = "Managed by terraform: To resolve, redeploy the patroni helm chart 'silver-patroni' in the sso-keycloak repo with an updated values file."
  severity              = 4
  enabled               = true
  promql                = <<-EOT
          avg(
            kubelet_volume_stats_used_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-dev-11-patroni-.*"}*100
            /
            kubelet_volume_stats_capacity_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-dev-11-patroni-.*"}
          ) by (persistentvolumeclaim)
          > 90
          EOT
  trigger_after_minutes = 10
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "patroni_dev_pvc_over_seventyfive" {
  name                  = "Patroni - Dev PVCs > 75% Terraform Silver"
  description           = "Managed by terraform: Only alert rocket chat and email for 75%."
  severity              = 4
  enabled               = true
  promql                = <<-EOT
          avg(
            kubelet_volume_stats_used_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-dev-11-patroni-.*"}*100
            /
            kubelet_volume_stats_capacity_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-dev-11-patroni-.*"}
          ) by (persistentvolumeclaim)
          > 75
          EOT
  trigger_after_minutes = 10
  notification_channels = [45990, 47291]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "patroni_test_pvc_over_ninety" {
  name                  = "Patroni - Test PVCs > 90% Terraform Silver"
  description           = "Managed by terraform: To resolve, redeploy the patroni helm chart 'silver-patroni' in the sso-keycloak repo with an updated values file."
  severity              = 4
  enabled               = true
  promql                = <<-EOT
          avg(
            kubelet_volume_stats_used_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-test-11-patroni-.*"}*100
            /
            kubelet_volume_stats_capacity_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-test-11-patroni-.*"}
          ) by (persistentvolumeclaim)
          > 90
          EOT
  trigger_after_minutes = 10
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "patroni_test_pvc_over_seventyfive" {
  name                  = "Patroni - Test PVCs > 75% Terraform Silver"
  description           = "Managed by terraform: Only alert rocket chat and email for 75%."
  severity              = 4
  enabled               = true
  promql                = <<-EOT
          avg(
            kubelet_volume_stats_used_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-test-11-patroni-.*"}*100
            /
            kubelet_volume_stats_capacity_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-test-11-patroni-.*"}
          ) by (persistentvolumeclaim)
          > 75
          EOT
  trigger_after_minutes = 10
  notification_channels = [45990, 47291]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "patroni_backup_pvc_over_sixty" {
  name                  = "Patroni - Backup PVC over 60% Terraform Silver"
  description           = "Managed by terraform: To resolve, redeploy the backup strorage helm chart in the sso-keycloak repo with an updated values file."
  severity              = 4
  enabled               = true
  promql                = <<-EOT
  avg(
    kubelet_volume_stats_used_bytes{namespace="6d70e7-prod", persistentvolumeclaim="sso-backup-storage-backup-pvc"} * 100
    /
    kubelet_volume_stats_capacity_bytes{namespace="6d70e7-prod", persistentvolumeclaim="sso-backup-storage-backup-pvc"}
    ) by (persistentvolumeclaim) > 60
  EOT
  trigger_after_minutes = 10
  notification_channels = [45990, 47291]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}


resource "sysdig_monitor_alert_promql" "patroni_backup_pvc_over_eighty" {
  name                  = "Patroni - PVCs > 80% Terraform Silver"
  description           = "Managed by terraform: To resolve, redeploy the silver-patroni helm chart in the sso-keycloak repo with an updated values file."
  severity              = 2
  enabled               = true
  promql                = <<-EOT
    avg(
      kubelet_volume_stats_used_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-prod-11-patroni-.*"}*100
      /
      kubelet_volume_stats_capacity_bytes{persistentvolumeclaim=~"storage-volume-sso-pgsql-prod-11-patroni-.*"})
      by (persistentvolumeclaim) > 80
    EOT
  trigger_after_minutes = 10
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "log_pvc_over_sixty" {
  name                  = "SSO Logs - PVCs > 60% Terraform Silver"
  description           = "Managed by terraform: To resolve, redeploy the silver keycloak helm chart in the sso-keycloak repo with an updated values file."
  severity              = 4
  enabled               = true
  promql                = <<-EOT
  avg(
    kubelet_volume_stats_used_bytes{namespace="6d70e7-prod", persistentvolumeclaim="sso-keycloak-logs"} * 100
    /
    kubelet_volume_stats_capacity_bytes{namespace="6d70e7-prod", persistentvolumeclaim="sso-keycloak-logs"}
    ) by (persistentvolumeclaim) > 60
  EOT
  trigger_after_minutes = 10
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

resource "sysdig_monitor_alert_promql" "log_pvc_over_eighty" {
  name                  = "Patroni - Backup PVC over 80% Terraform Silver"
  description           = "Managed by terraform: To resolve, redeploy the backup helm chart in the sso-keycloak repo with an updated values file."
  severity              = 4
  enabled               = true
  promql                = <<-EOT
  avg(
    kubelet_volume_stats_used_bytes{namespace="6d70e7-prod", persistentvolumeclaim="sso-backup-storage-backup-pvc"} * 100
    /
    kubelet_volume_stats_capacity_bytes{namespace="6d70e7-prod", persistentvolumeclaim="sso-backup-storage-backup-pvc"})
    by (persistentvolumeclaim) > 80
  EOT
  trigger_after_minutes = 10
  notification_channels = [45990, 47291, 47595]
  custom_notification {
    title = "{{__alert_name__}} is {{__alert_status__}}"
  }
}

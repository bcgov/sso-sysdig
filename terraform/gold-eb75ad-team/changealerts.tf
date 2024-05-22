resource "sysdig_monitor_alert_v2_change" "sample" {

  name              = "high cpu used compared to previous periods"
  severity          = "high"
  metric            = "sysdig_container_cpu_used_percent"
  group_aggregation = "avg"
  time_aggregation  = "avg"
  operator          = ">"
  threshold         = 75
  group_by          = ["kube_pod_name"]

  scope {
    label    = "kube_cluster_name"
    operator = "in"
    values   = ["my_cluster_1", "my_cluster_2"]
  }

  scope {
    label    = "kube_deployment_name"
    operator = "equals"
    values   = ["my_deployment"]
  }

  notification_channels {
    id                     = 1234
    renotify_every_minutes = 60
  }

  shorter_time_range_seconds = 300
  longer_time_range_seconds  = 3600

}

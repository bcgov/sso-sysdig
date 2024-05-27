resource "sysdig_monitor_alert_v2_change" "dev_pvcuse_spike" {

  name              = "[DEV] the dev PVC usage surged(EXPERIMENT)"
  severity          = "low"
  metric            = "kubelet_volume_stats_used_bytes"
  group_aggregation = "avg"
  time_aggregation  = "avg"
  operator          = ">"
  threshold         = 3
  group_by          = [""]

  scope {
    label    = "kube_cluster_name"
    operator = "equals"
    values   = ["gold"]
  }

  scope {
    label    = "kube_namespace_name"
    operator = "equals"
    values   = ["eb75ad-dev"]
  }

  scope {
    label    = "persistentvolumeclaim"
    operator = "in"
    values   = ["storage-volume-sso-patroni-0", "storage-volume-sso-patroni-1", "storage-volume-sso-patroni-2"]
  }

  notification_channels {
    id                     = 132277
    renotify_every_minutes = 60
  }

  shorter_time_range_seconds = 599
  longer_time_range_seconds  = 28799

}

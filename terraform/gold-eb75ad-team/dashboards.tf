resource "sysdig_monitor_dashboard" "pv_overall" {
  name        = "Persistent Volume Overall Status"
  description = "Persistent Volume Overall Status"

  share {
    role = "ROLE_RESOURCE_EDIT"
    member {
      type = "TEAM"
      id   = 40193
    }
  }

  panel {
    pos_x       = 0
    pos_y       = 0
    width       = 8
    height      = 4
    type        = "number"
    name        = "Volume Available Bytes"
    description = "Description"

    query {
      promql = "sum(kubelet_volume_stats_available_bytes)"
      unit   = "data"
    }
  }

  panel {
    pos_x       = 8
    pos_y       = 0
    width       = 8
    height      = 4
    type        = "number"
    name        = "Volume Used Bytes"
    description = "Description"

    query {
      promql = "sum(kubelet_volume_stats_used_bytes)"
      unit   = "data"
    }
  }

  panel {
    pos_x       = 16
    pos_y       = 0
    width       = 8
    height      = 4
    type        = "number"
    name        = "Volume Capacity Bytes"
    description = "Description"

    query {
      promql = "sum(kubelet_volume_stats_capacity_bytes)"
      unit   = "data"
    }
  }

  panel {
    pos_x       = 0
    pos_y       = 4
    width       = 8
    height      = 8
    type        = "timechart"
    name        = "Volume Used Bytes By PVC"
    description = "Description"

    query {
      promql = "avg(kubelet_volume_stats_used_bytes) by (persistentvolumeclaim)"
      unit   = "number"
    }
  }

  panel {
    pos_x       = 8
    pos_y       = 4
    width       = 8
    height      = 8
    type        = "timechart"
    name        = "Volume Capacity Bytes By PVC"
    description = "Description"

    query {
      promql = "avg(kubelet_volume_stats_capacity_bytes) by (persistentvolumeclaim)"
      unit   = "number"
    }
  }

  panel {
    pos_x       = 16
    pos_y       = 4
    width       = 8
    height      = 8
    type        = "timechart"
    name        = "Volume Used Percentage By PVC"
    description = "Description"

    query {
      promql = "avg(kubelet_volume_stats_used_bytes/kubelet_volume_stats_capacity_bytes) by (persistentvolumeclaim)"
      unit   = "percent"
    }
  }

  panel {
    pos_x       = 0
    pos_y       = 12
    width       = 8
    height      = 8
    type        = "timechart"
    name        = "Volume Used Bytes By Namespace"
    description = "Description"

    query {
      promql = "avg(kubelet_volume_stats_used_bytes) by (namespace)"
      unit   = "number"
    }
  }

  panel {
    pos_x       = 8
    pos_y       = 12
    width       = 8
    height      = 8
    type        = "timechart"
    name        = "Volume Capacity Bytes By Namespace"
    description = "Description"

    query {
      promql = "avg(kubelet_volume_stats_capacity_bytes) by (namespace)"
      unit   = "number"
    }
  }

  panel {
    pos_x       = 16
    pos_y       = 12
    width       = 8
    height      = 8
    type        = "timechart"
    name        = "Volume Used Percentage By Namespace"
    description = "Description"

    query {
      promql = "avg(kubelet_volume_stats_used_bytes/kubelet_volume_stats_capacity_bytes) by (namespace)"
      unit   = "percent"
    }
  }
}

resource "sysdig_monitor_dashboard" "pv_usage" {
  name        = "Persistent Volume Usage"
  description = "Persistent Volume Usage"

  share {
    role = "ROLE_RESOURCE_EDIT"
    member {
      type = "TEAM"
      id   = 40193
    }
  }

  scope {
    metric     = "kube_namespace_name"
    comparator = "in"
    value      = ["eb75ad-prod"]
    variable   = "cluster_name"
  }

  panel {
    pos_x       = 0
    pos_y       = 0
    width       = 24
    height      = 12
    type        = "timechart"
    name        = "[PROD] Volume Usage By Pod"
    description = "Description"

    query {
      promql = "avg(kubelet_volume_stats_used_bytes{$__scope, persistentvolumeclaim=\"storage-volume-sso-patroni-0\"}/kubelet_volume_stats_capacity_bytes{$__scope, persistentvolumeclaim=\"storage-volume-sso-patroni-0\"} * 100)"
      unit   = "percent"
    }

    query {
      promql = "avg(kubelet_volume_stats_used_bytes{$__scope, persistentvolumeclaim=\"storage-volume-sso-patroni-1\"}/kubelet_volume_stats_capacity_bytes{$__scope, persistentvolumeclaim=\"storage-volume-sso-patroni-1\"} * 100)"
      unit   = "percent"
    }

    query {
      promql = "avg(kubelet_volume_stats_used_bytes{$__scope, persistentvolumeclaim=\"storage-volume-sso-patroni-2\"}/kubelet_volume_stats_capacity_bytes{$__scope, persistentvolumeclaim=\"storage-volume-sso-patroni-2\"} * 100)"
      unit   = "percent"
    }
  }
}

resource "sysdig_monitor_dashboard" "pods_cpu" {
  name        = "Pods & CPU"
  description = "Pods & CPU"

  share {
    role = "ROLE_RESOURCE_EDIT"
    member {
      type = "TEAM"
      id   = 40193
    }
  }

  scope {
    metric     = "kube_cluster_name"
    comparator = "in"
    value      = ["gold"]
    variable   = "cluster_name"
  }

  scope {
    metric     = "kube_namespace_name"
    comparator = "in"
    value      = ["eb75ad-prod"]
    variable   = "namespace_name"
  }

  panel {
    pos_x       = 0
    pos_y       = 0
    width       = 8
    height      = 4
    type        = "number"
    name        = "Ready Pod"
    description = "Patroni pods are replicas of our database. We are setup to have 3 at any given time. An alert will be triggered if this fails below 3"

    query {
      promql = "sum(kube_pod_sysdig_status_ready{$__scope, kube_deployment_name='sso-keycloak'})"
      unit   = "number"
    }
  }

  panel {
    pos_x       = 8
    pos_y       = 0
    width       = 8
    height      = 4
    type        = "number"
    name        = "Ready DB Pods"
    description = "Description"

    query {
      promql = "sum(kube_pod_sysdig_status_ready{$__scope, kube_statefulset_name='sso-patroni'})"
      unit   = "number"
    }
  }

  panel {
    pos_x       = 0
    pos_y       = 4
    width       = 24
    height      = 10
    type        = "timechart"
    name        = "SSO Pods Usage"
    description = "Description"

    query {
      promql = "avg(sum(sysdig_container_cpu_cores_used{$__scope, kube_deployment_name='sso-keycloak'}))"
      unit   = "number"
    }
  }
}


resource "sysdig_monitor_dashboard" "general_pod_performance" {
  name        = "Memory Network and CPU for pods"
  description = "The general perfomance dashboard for production prod"

  share {
    role = "ROLE_RESOURCE_EDIT"
    member {
      type = "TEAM"
      id   = 40193
    }
  }

  scope {
    metric     = "kube_cluster_name"
    comparator = "in"
    value      = ["gold"]
    variable   = "cluster_name"
  }

  scope {
    metric     = "kube_namespace_name"
    comparator = "in"
    value      = ["eb75ad-prod"]
    variable   = "namespace_name"
  }

  panel {
    pos_x       = 0
    pos_y       = 0
    width       = 8
    height      = 4
    type        = "timechart"
    name        = "Memory used by pod vs memory request keycloak"
    description = "Keycloak memory used by pods compared to the requested memory factor of 100 added to fix display"

    query {
      promql = "(sum by (kube_workload_name,kube_pod_name,kube_cluster_name,kube_namespace_name)(rate(sysdig_container_memory_used_bytes{kube_namespace_name=~'eb75ad-prod',kube_cluster_name=~'gold', kube_workload_name=~'sso-keycloak'}[$__interval])))*100/ (sum by (kube_workload_name, kube_pod_name,kube_cluster_name,kube_namespace_name)(kube_pod_container_resource_requests{resource='memory',kube_namespace_name=~'eb75ad-prod',kube_cluster_name=~'gold', kube_workload_name=~'sso-keycloak'}))"
      unit   = "percent"
    }
  }

  panel {
    pos_x       = 8
    pos_y       = 0
    width       = 8
    height      = 4
    type        = "timechart"
    name        = "Memory used by pod vs memory request patroni"
    description = "Patroni memory used by pods compared to the requested memory. Factor of 100 added to fix display"

    query {
      promql = "(sum by (kube_workload_name,kube_pod_name,kube_cluster_name,kube_namespace_name)(rate(sysdig_container_memory_used_bytes{kube_namespace_name=~'eb75ad-prod',kube_cluster_name=~'gold', kube_workload_name=~'sso-patroni'}[$__interval])))*100/ (sum by (kube_workload_name, kube_pod_name,kube_cluster_name,kube_namespace_name)(kube_pod_container_resource_requests{resource='memory',kube_namespace_name=~'eb75ad-prod',kube_cluster_name=~'gold', kube_workload_name=~'sso-patroni'}))"
      unit   = "percent"
    }
  }

  panel {
    pos_x       = 0
    pos_y       = 4
    width       = 8
    height      = 4
    type        = "timechart"
    name        = "HTTP Errors (4xx/5xx) per Pod Keycloak"
    description = ""

    query {
      promql = "topk(20,sum(sum_over_time(sysdig_container_net_http_error_count{kube_cluster_name=~'gold', kube_workload_name=~'sso-keycloak'}[$__interval])) by (kube_cluster_name, kube_namespace_name, kube_workload_type, kube_workload_name, kube_pod_name)) / $__interval_sec"
      unit   = "number rate"
    }
  }

  panel {
    pos_x       = 8
    pos_y       = 4
    width       = 8
    height      = 4
    type        = "timechart"
    name        = "HTTP Errors (4xx/5xx) per Pod Patroni"
    description = ""

    query {
      promql = "topk(20,sum(sum_over_time(sysdig_container_net_http_error_count{kube_cluster_name=~'gold', kube_workload_name=~'sso-patroni'}[$__interval])) by (kube_cluster_name, kube_namespace_name, kube_workload_type, kube_workload_name, kube_pod_name)) / $__interval_sec"
      unit   = "number rate"
    }

  }

  panel {
    pos_x       = 0
    pos_y       = 8
    width       = 16
    height      = 6
    type        = "timechart"
    name        = "CPU usage per keycloak pod"
    description = ""

    query {
      promql = "sysdig_container_cpu_cores_used{$__scope, kube_deployment_name='sso-keycloak'}"
      unit   = "number rate"
    }
  }

  panel {
    pos_x       = 0
    pos_y       = 14
    width       = 16
    height      = 4
    type        = "timechart"
    name        = "Network Traffic Inbound per Pod"
    description = ""

    query {
      promql = "topk(10,sum(sum_over_time(sysdig_container_net_in_bytes{kube_cluster_name=~'gold', kube_workload_name=~'sso-keycloak', kube_namespace_name='eb75ad-prod'}[$__interval])) by (kube_cluster_name, kube_namespace_name, kube_workload_type, kube_workload_name, kube_pod_name) / $__interval_sec)"
      unit   = "data rate"
    }
  }

  panel {
    pos_x       = 0
    pos_y       = 18
    width       = 16
    height      = 4
    type        = "timechart"
    name        = "Network Traffic Outbound per Pod"
    description = ""

    query {
      promql = "topk(10,sum(sum_over_time(sysdig_container_net_out_bytes{kube_cluster_name=~'gold', kube_workload_name=~'sso-keycloak', kube_namespace_name='eb75ad-prod'}[$__interval])) by (kube_cluster_name, kube_namespace_name, kube_workload_type, kube_workload_name, kube_pod_name) / $__interval_sec)"
      unit   = "data rate"
    }
  }

  panel {
    pos_x       = 0
    pos_y       = 22
    width       = 16
    height      = 4
    type        = "timechart"
    name        = "Requests per pod"
    description = ""

    query {
      promql = "topk(20,sum(sum_over_time(sysdig_container_net_request_count{kube_cluster_name=~'gold', kube_workload_name=~'sso-keycloak', kube_namespace_name='eb75ad-prod'}[$__interval])) by (kube_cluster_name, kube_namespace_name, kube_workload_type, kube_workload_name, kube_pod_name) / $__interval_sec)"
      unit   = "number rate"
    }
  }

  panel {
    pos_x       = 0
    pos_y       = 26
    width       = 16
    height      = 4
    type        = "timechart"
    name        = "Connections per Pod"
    description = ""

    query {
      promql = "topk(20,sum(sum_over_time(sysdig_container_net_connection_total_count{kube_cluster_name=~'gold', kube_workload_name=~'sso-keycloak', kube_namespace_name='eb75ad-prod'}[$__interval])) by (kube_cluster_name, kube_namespace_name, kube_workload_type, kube_workload_name, kube_pod_name) / $__interval_sec)"
      unit   = "number rate"
    }
  }


}

resource "sysdig_monitor_dashboard" "sso_cache" {
  name = "SSO Cache"

  share {
    role = "ROLE_RESOURCE_EDIT"
    member {
      type = "TEAM"
      id   = 40193
    }
  }

  scope {
    metric     = "cache"
    comparator = "in"
    value      = ["sessions"]
  }

  scope {
    metric     = "cache_manager"
    comparator = "in"
    value      = ["keycloak"]
  }

  scope {
    metric     = "kubernetes.namespace.name"
    comparator = "in"
    value      = ["eb75ad-prod"]
  }

  scope {
    metric     = "kubernetes.pod.name"
    comparator = "in"
    value      = ["sso-keycloak-0", "sso-keycloak-1", "sso-keycloak-2"]
  }

  panel {
    pos_x  = 0
    pos_y  = 0
    width  = 6
    height = 6
    type   = "timechart"
    name   = "Cache Unique Entries by Pod"

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = "sum by (kube_pod_name)(vendor_statistics_approximate_entries_unique{$__scope})"
      unit   = "number"

      display_info {
        display_name                      = "Stored Unique Entries"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "1"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }

  panel {
    pos_x  = 6
    pos_y  = 0
    width  = 6
    height = 6
    type   = "timechart"
    name   = "Cache All Entries by Pod"

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = "sum by (kube_pod_name)(vendor_statistics_approximate_entries{$__scope})"
      unit   = "number"

      display_info {
        display_name                      = "All Stored Entries"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "1"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }

  panel {
    pos_x  = 12
    pos_y  = 0
    width  = 6
    height = 6
    type   = "timechart"
    name   = "Cache Write Operations Rate by Pod"

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = "sum by (kube_pod_name)(rate(vendor_statistics_store_times_seconds_count{$__scope}[$__interval]))"
      unit   = "number rate"

      display_info {
        display_name                      = "Write Operations Rate"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }

  panel {
    pos_x  = 18
    pos_y  = 0
    width  = 6
    height = 6
    type   = "timechart"
    name   = "Cache Eviction Rate by Pod"

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = "sum by (kube_pod_name)(rate(vendor_statistics_evictions{$__scope}[$__interval]))"
      unit   = "number rate"

      display_info {
        display_name                      = "Eviction Rate"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }

  panel {
    pos_x  = 0
    pos_y  = 6
    width  = 6
    height = 6
    type   = "timechart"
    name   = "Cache Read Miss Rate by Pod"

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = "sum by (kube_pod_name)(rate(vendor_statistics_miss_times_seconds_count{$__scope}[$__interval]))"
      unit   = "number rate"

      display_info {
        display_name                      = "Read Miss Rate"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }

  panel {
    pos_x  = 6
    pos_y  = 6
    width  = 6
    height = 6
    type   = "timechart"
    name   = "Cache Hit Percentage by Pod"

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = chomp(<<-EOT
        100 * (sum by (kube_pod_name) (
          rate(vendor_statistics_hit_times_seconds_count{
            $__scope
          }[$__interval])
        )
        /
        (
          sum by (kube_pod_name) (
            rate(vendor_statistics_hit_times_seconds_count{
              $__scope
            }[$__interval])
          )
          +
          sum by (kube_pod_name) (
            rate(vendor_statistics_miss_times_seconds_count{
              $__scope
            }[$__interval])
          )
        )
        )
      EOT
      )
      unit = "percent"

      display_info {
        display_name                      = "Hit Percentage"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "0-100"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }

  panel {
    pos_x       = 12
    pos_y       = 6
    width       = 6
    height      = 6
    type        = "timechart"
    name        = "Cache Write Operations Average Duration"
    description = "The average duration of a cache store operation across all selected pods/caches."

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = chomp(<<-EOT
        sum(rate(vendor_statistics_store_times_seconds_sum{$__scope}[$__range]))
        /
        sum(rate(vendor_statistics_store_times_seconds_count{$__scope}[$__range]))
      EOT
      )
      unit = "time"

      display_info {
        display_name                      = "Average Time"
        time_series_display_name_template = "sso-keycloak"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }

  panel {
    pos_x  = 18
    pos_y  = 6
    width  = 6
    height = 6
    type   = "timechart"
    name   = "Cache Read Operations Rate by Pod"

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = chomp(<<-EOT
        sum by (kube_pod_name)(
          rate(vendor_statistics_hit_times_seconds_count{$__scope}[$__interval])
        + rate(vendor_statistics_miss_times_seconds_count{$__scope}[$__interval])
        )
      EOT
      )
      unit = "number rate"

      display_info {
        display_name                      = "Read Operations Rate"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }

  panel {
    pos_x  = 0
    pos_y  = 12
    width  = 6
    height = 6
    type   = "timechart"
    name   = "Cache Remove Operations Rate by Pod"

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = chomp(<<-EOT
        sum by (kube_pod_name)(
          rate(vendor_statistics_remove_hit_times_seconds_count{$__scope}[$__interval])
        + rate(vendor_statistics_remove_miss_times_seconds_count{$__scope}[$__interval])
        )
      EOT
      )
      unit = "number rate"

      display_info {
        display_name                      = "Cache Removal Rate"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }

  panel {
    pos_x  = 6
    pos_y  = 12
    width  = 6
    height = 6
    type   = "timechart"
    name   = "Cache Removal Hit to Miss Ratio by Pod"

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = chomp(<<-EOT
        100 *
        sum by (kube_pod_name) (
          rate(
            vendor_statistics_remove_hit_times_seconds_count{      $__scope
            }[$__interval]
          )
        )
        /
        (
          sum by (kube_pod_name) (
            rate(
              vendor_statistics_remove_hit_times_seconds_count{
                $__scope
              }[$__interval]
            )
          )
          +
          sum by (kube_pod_name) (
            rate(
              vendor_statistics_remove_miss_times_seconds_count{
                $__scope
              }[$__interval]
            )
          )
        )
      EOT
      )
      unit = "percent"

      display_info {
        display_name                      = "cache remove hit ratio"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "0-100"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }

  panel {
    pos_x  = 12
    pos_y  = 12
    width  = 6
    height = 6
    type   = "timechart"
    name   = "Cache Removal Rate by Pod"

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = "sum by (kube_pod_name)(rate(vendor_statistics_remove_miss_times_seconds_count{$__scope}[$__interval]))"
      unit   = "number rate"

      display_info {
        display_name                      = "Cache Removal Rate"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }

  panel {
    pos_x  = 18
    pos_y  = 12
    width  = 6
    height = 6
    type   = "timechart"
    name   = "Cache Removal Miss Rate by Pod"

    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }

    query {
      promql = "sum by (kube_pod_name)(rate(vendor_statistics_remove_miss_times_seconds_count{$__scope}[$__interval]))"
      unit   = "number rate"

      display_info {
        display_name                      = "Remove Miss Rate"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }

      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
}

resource "sysdig_monitor_dashboard" "sso_http" {
  name = "SSO HTTP"

  panel {
    height = 8
    name   = "HTTP Active Requests by Pod"
    pos_x  = 0
    pos_y  = 8
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = "sum by (kube_pod_name)(http_server_active_requests{$__scope})"
      unit   = "number"
      display_info {
        display_name                      = "Total Count"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "1"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Average Request Size"
    pos_x  = 8
    pos_y  = 16
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = chomp(<<-EOT
        sum(rate(http_server_bytes_read_sum{$__scope}[$__range]))
        /
        sum(rate(http_server_bytes_read_count{$__scope}[$__range]))
      EOT
      )
      unit = "data rate"
      display_info {
        display_name                      = "Request Size"
        time_series_display_name_template = "sso-keycloak"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "B/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Average Response Size by Pod"
    pos_x  = 16
    pos_y  = 8
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = chomp(<<-EOT
        sum by (kube_pod_name)(rate(http_server_bytes_written_sum{$__scope}[$__interval]))
        /
        sum by (kube_pod_name)(rate(http_server_bytes_written_count{$__scope}[$__interval]))
      EOT
      )
      unit = "data rate"
      display_info {
        display_name                      = "Average Size"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "B/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Average Response Size"
    pos_x  = 0
    pos_y  = 16
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = chomp(<<-EOT
        sum(rate(http_server_bytes_written_sum{$__scope}[$__range]))
        /
        sum(rate(http_server_bytes_written_count{$__scope}[$__range]))
      EOT
      )
      unit = "data rate"
      display_info {
        display_name                      = "Average Response Size"
        time_series_display_name_template = "sso-keycloak"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "B/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Average Response Time by Pod"
    pos_x  = 0
    pos_y  = 24
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = chomp(<<-EOT
        sum by (kube_pod_name) (rate(vendor_jgroups_stats_sync_requests_seconds_sum{$__scope}[$__interval]))
        /
        sum by (kube_pod_name) (rate(vendor_jgroups_stats_sync_requests_seconds_count{$__scope}[$__interval]))
      EOT
      )
      unit = "time"
      display_info {
        display_name                      = "Average Response Time"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Message Retransmissions Rate by Pod"
    pos_x  = 8
    pos_y  = 24
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = "rate(vendor_jgroups_unicast3_get_num_xmits{$__scope}[$__interval])"
      unit   = "number rate"
      display_info {
        display_name                      = "Retransmissions Rate"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Message Send Rate"
    pos_x  = 0
    pos_y  = 32
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = <<-EOT
        rate(vendor_jgroups_tcp_get_num_msgs_sent{$__scope}[$__interval])
      EOT
      unit   = "number rate"
      display_info {
        display_name                      = "Rate of Messages Sent"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Messages Dropped by Pod"
    pos_x  = 16
    pos_y  = 24
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = "rate(vendor_jgroups_red_get_dropped_messages{$__scope}[$__interval])"
      unit   = "number rate"
      display_info {
        display_name                      = "Messages Dropped Rate"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Messages Received Rate"
    pos_x  = 8
    pos_y  = 32
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = "rate(vendor_jgroups_tcp_get_num_msgs_received{$__scope}[$__interval])"
      unit   = "number rate"
      display_info {
        display_name                      = "Rate of Messages Received"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Request Rate by Pod and Outcome"
    pos_x  = 8
    pos_y  = 8
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = "sum by (kube_pod_name, outcome)(rate(http_server_requests_seconds_count{$__scope}[$__interval]))"
      unit   = "number rate"
      display_info {
        display_name                      = "Request Rate"
        time_series_display_name_template = "{{kube_pod_name}} - {{outcome}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Request Rate by URI and outcome"
    pos_x  = 16
    pos_y  = 0
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = "sum by (uri, outcome)(rate(http_server_requests_seconds_count{$__scope}[$__interval]))"
      unit   = "number rate"
      display_info {
        display_name                      = "Requests Rate"
        time_series_display_name_template = "{{uri}} - {{outcome}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Requests Size Rate by Pod"
    pos_x  = 16
    pos_y  = 16
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = chomp(<<-EOT
        sum by (kube_pod_name)(rate(http_server_bytes_read_sum{$__scope}[$__interval]))
        /
        sum by (kube_pod_name)(rate(http_server_bytes_read_count{$__scope}[$__interval]))
      EOT
      )
      unit = "data rate"
      display_info {
        display_name                      = "Request Size Rate"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "B/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Requests by Pod"
    pos_x  = 0
    pos_y  = 0
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = "sum by (kube_pod_name)(rate(http_server_requests_seconds_count{$__scope}[$__interval]))"
      unit   = "number rate"
      display_info {
        display_name                      = "Request Rate"
        time_series_display_name_template = "{{kube_pod_name}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 8
    name   = "HTTP Requests by URI and outcome"
    pos_x  = 8
    pos_y  = 0
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = "sum by (uri, outcome)(http_server_requests_seconds_count{$__scope})"
      unit   = "number"
      display_info {
        display_name                      = "Request Count"
        time_series_display_name_template = "{{uri}} - {{outcome}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "1"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  scope {
    comparator = "in"
    metric     = "kubernetes.namespace.name"
    value = [
      "eb75ad-prod",
    ]
  }
  scope {
    comparator = "in"
    metric     = "kubernetes.pod.name"
    value = [
      "sso-keycloak-0",
      "sso-keycloak-1",
      "sso-keycloak-2",
    ]
  }
  share {
    role = "ROLE_RESOURCE_EDIT"
    member {
      id   = 40193
      type = "TEAM"
    }
  }
}

resource "sysdig_monitor_dashboard" "sso_capacity_planning" {
  name = "SSO Capacity Planning"

  panel {
    height = 7
    name   = "Approximate memory used per unique session"
    pos_x  = 16
    pos_y  = 0
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = chomp(<<-EOT
        sum(sysdig_container_memory_used_bytes{$__scope})
        /
        sum(vendor_statistics_approximate_entries_unique{cache="sessions", $__scope})
      EOT
      )
      unit = "data"
      display_info {
        display_name                      = "Memory Usage"
        time_series_display_name_template = "sso-keycloak"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "B"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 7
    name   = "CPU time per login"
    pos_x  = 8
    pos_y  = 0
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = chomp(<<-EOT
        sum(rate(sysdig_container_cpu_cores_used{$__scope}[$__interval]))
        /
        sum(rate(keycloak_user_events_total{event="login", error="", $__scope}[$__interval]))
      EOT
      )
      unit = "time"
      display_info {
        display_name                      = "CPU Time"
        time_series_display_name_template = "sso-keycloak"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  panel {
    height = 7
    name   = "Credential Password Hashing Validation Rate by Pod"
    pos_x  = 0
    pos_y  = 0
    type   = "timechart"
    width  = 8
    legend {
      enabled      = true
      layout       = "table"
      position     = "bottom"
      show_current = true
    }
    query {
      promql = "sum by (kube_pod_name,algorithm) (rate(keycloak_credentials_password_hashing_validations_total{$__scope}[$__interval]))"
      unit   = "number rate"
      display_info {
        display_name                      = "Password Hash Validation Rate"
        time_series_display_name_template = "{{kube_pod_name}}-{{algorithm}}"
        type                              = "lines"
      }
      format {
        decimals                = 0
        display_format          = "auto"
        input_format            = "/s"
        null_value_display_mode = "connectDotted"
        y_axis                  = "auto"
      }
    }
  }
  share {
    role = "ROLE_RESOURCE_EDIT"
    member {
      id   = 40193
      type = "TEAM"
    }
  }
}

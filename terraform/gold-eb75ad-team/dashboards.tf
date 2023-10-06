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





}

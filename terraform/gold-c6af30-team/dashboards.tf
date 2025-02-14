resource "sysdig_monitor_dashboard" "pv_overall" {
  name        = "Managed by terraform: Persistent Volume Overall Status"
  description = "Managed by terraform: Persistent Volume Overall Status"

  share {
    role = "ROLE_RESOURCE_EDIT"
    member {
      type = "TEAM"
      id   = 40192
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
  name        = "Managed by terraform: Persistent Volume Usage"
  description = "Managed by terraform: Persistent Volume Usage"

  share {
    role = "ROLE_RESOURCE_EDIT"
    member {
      type = "TEAM"
      id   = 40192
    }
  }

  scope {
    metric     = "kube_namespace_name"
    comparator = "in"
    value      = ["c6af30-prod"]
    variable   = "namespace_name"
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
  name        = "Managed by terraform: CPU Load Memory and HTTP requests"
  description = "This will give us the basic metrics for the keycloak pods for load testing results"

  share {
    role = "ROLE_RESOURCE_EDIT"
    member {
      type = "TEAM"
      id   = 40192
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
    value      = ["c6af30-prod"]
    variable   = "namespace_name"
  }


  panel {
    pos_x       = 0
    pos_y       = 4
    width       = 24
    height      = 10
    type        = "timechart"
    name        = "SSO CPU Usage"
    description = "Description"
    legend {
      enabled      = true
      layout       = "table"
      position     = "top"
      show_current = true
    }
    query {
      promql = "sysdig_container_cpu_cores_used{kube_namespace_name=~\"c6af30-prod\",kube_cluster_name=~\"gold\",kube_pod_name=~\".*sso-keycloak.*\", kube_deployment_name='sso-keycloak'}"
      unit   = "number"
    }
    query {
      promql = "sum by (kube_deployment_name) (rate(sysdig_container_cpu_cores_used{kube_namespace_name=~\"c6af30-prod\",kube_cluster_name=~\"gold\",kube_pod_name=~\".*sso-keycloak.*\",kube_deployment_name=\"sso-keycloak\"}[1m]))"
      unit   = "number"
    }
  }
}

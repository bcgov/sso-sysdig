resource "sysdig_monitor_dashboard" "silver_pvc_dashboard_b" {
  name        = "Postgres PVC Percent Full Silver Terraform"
  description = "Example Dashboard description"

  scope {
    metric     = "kubernetes.cluster.name"
    comparator = "in"
    value      = ["prod", "dev"]
    variable   = "cluster_name"
  }

  scope {
    metric   = "host.hostName"
    variable = "hostname"
  }

  panel {
    autosize_text          = false
    height                 = 8
    name                   = "Postgres PVC Percent Full"
    pos_x                  = 0
    pos_y                  = 0
    transparent_background = false
    type                   = "timechart"
    visible_title          = false
    width                  = 8

    query {
      promql = "avg(kubelet_volume_stats_used_bytes{persistentvolumeclaim=\"postgresql-sso-pgsql-prod-0\"}/kubelet_volume_stats_capacity_bytes{persistentvolumeclaim=\"postgresql-sso-pgsql-prod-0\"} * 100)"
      unit   = "percent"
    }
    query {
      promql = "avg(kubelet_volume_stats_used_bytes{persistentvolumeclaim=\"postgresql-sso-pgsql-prod-1\"}/kubelet_volume_stats_capacity_bytes{persistentvolumeclaim=\"postgresql-sso-pgsql-prod-1\"} * 100)"
      unit   = "percent"
    }
    query {
      promql = "avg(kubelet_volume_stats_used_bytes{persistentvolumeclaim=\"postgresql-sso-pgsql-prod-2\"}/kubelet_volume_stats_capacity_bytes{persistentvolumeclaim=\"postgresql-sso-pgsql-prod-2\"} * 100)"
      unit   = "percent"
    }
  }

  share {
    role = "ROLE_RESOURCE_EDIT"

    member {
      id   = 0
      type = "USER_TEAMS"
    }
  }


}


resource "sysdig_monitor_dashboard" "sso_production_pods" {
  description = "managed by terraform"
  name        = "SSO Production Pods & CPU Terraform"
  public      = false

  panel {
    autosize_text          = false
    description            = "Patroni pods are replicas of our database. We are setup to have 3 at any given time. An alert will be triggered if this fails below 3"
    height                 = 4
    name                   = "Ready Patroni Pods"
    pos_x                  = 6
    pos_y                  = 7
    transparent_background = false
    type                   = "number"
    visible_title          = false
    width                  = 6

    query {
      promql = "sum(avg_over_time(kube_pod_sysdig_status_ready{$__scope,kube_pod_label_cluster_name=~\"sso-pgsql-prod\"}[$__interval]))"
      unit   = "number"
    }
  }
  panel {
    autosize_text          = false
    description            = "Patroni pods are replicas of our database. We are setup to have 3 at any given time. An alert will be triggered if this fails below 3"
    height                 = 4
    name                   = "Ready Pod"
    pos_x                  = 0
    pos_y                  = 7
    transparent_background = false
    type                   = "number"
    visible_title          = false
    width                  = 6

    query {
      promql = "sum(avg_over_time(kube_pod_sysdig_status_ready{$__scope,kube_pod_label_project=~\"sso-keycloak\"}[$__interval]))"
      unit   = "number"
    }
  }
  panel {
    autosize_text          = false
    description            = "The CPU usage of our keycloak pods. Our alerts will begin to trigger when this goes over 3, and at over 5 have noticed serious issues. The dotted line is last weeks values for comparison."
    height                 = 7
    name                   = "Total SSO Pod Usage"
    pos_x                  = 0
    pos_y                  = 0
    transparent_background = false
    type                   = "timechart"
    visible_title          = false
    width                  = 12

    query {
      promql = "avg(sum_over_time(sysdig_container_cpu_cores_used{$__scope}[$__interval]))"
      unit   = "number"
    }
  }

  scope {
    comparator = "in"
    metric     = "kubernetes.namespace.name"
    value = [
      "6d70e7-prod",
    ]
  }

  share {
    role = "ROLE_RESOURCE_EDIT"

    member {
      id   = 0
      type = "USER_TEAMS"
    }
  }

  timeouts {}
}

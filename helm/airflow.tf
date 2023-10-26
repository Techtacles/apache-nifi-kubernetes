resource "helm_release" "airflow_chart" {
  name      = var.helm_release_name
  namespace = kubernetes_namespace_v1.namespace.metadata[0].name

  repository = var.helm_repo
  chart      = var.helm_chart
  version    = "8.8.0"


  dynamic "set" {
    for_each = var.chart_params
    content {
      name  = set.value.name
      value = set.value.value
      type  = set.value.type
    }

  }

  set {
    name  = "airflow.externalDatabase.host"
    value = var.db_host
  }
  set {
    name  = "airflow.externalDatabase.port"
    value = var.db_port
  }
  set {
    name  = "airflow.externalDatabase.database"
    value = var.db_name
  }
  set {
    name  = "airflow.externalDatabase.user"
    value = var.db_user
  }
  set {
    name  = "airflow.externalDatabase.password"
    value = var.db_password
  }
}

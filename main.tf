resource "helm_release" "prometheus-operator" {
  name      = "prometheus-operator"
  chart     = "stable/prometheus-operator"
  version   = "${var.prometheus_operator_chart_version}"
  namespace = "${var.prometheus_operator_namespace}"

  values = [<<EOF
global:
  rbac:
    enabled: ${var.prometheus_rbac_enabled}
commonLabels:
  prometheus: default
appVersion: ${var.prometheus_operator_app_version}
defaultRules:
  labels:
    alertmanager: default
  rules:
    alertmanager: true
    etcd: false
    general: true
    k8s: true
    kubeApiserver: false
    kubePrometheusNodeAlerting: true
    kubePrometheusNodeRecording: true
    kubeScheduler: false
    kubernetesAbsent: false
    kubernetesApps: true
    kubernetesResources: true
    kubernetesStorage: true
    kubernetesSystem: true
    node: true
    prometheusOperator: true
    prometheus: true
alertmanager:
  alertmanagerSpec:
    externalUrl: ${var.alertmanager_external_url}
  config:
    route:
      receiver: prom2teams
    receivers:
      - name: 'null'
      - name: prom2teams
        webhook_configs:
          - url: http://prom2teams.monitoring.svc.cluster.local/v2/Connector
prometheus:
  prometheusSpec:
    externalUrl: ${var.prometheus_external_url}
    
    secrets:
      - istio.default
      - istio.prometheus-operator-prometheus
    ruleNamespaceSelector: {}
    serviceMonitorSelector:
      matchLabels:
        prometheus: default
    ruleSelector:
      matchLabels:
        alertmanager: default
grafana:
  enabled: false
kubeScheduler:
  enabled: false
kubeApi:
  enabled: false
kubeControllerManager:
  enabled: false
kubeEtcd:
  enabled: false
EOF
  ]
}

resource "helm_release" "istio" {
  name      = "grafana"
  chart     = "stable/grafana"
  namespace = "monitoring"

  set {
    name  = "sidecar.datasources.enabled"
    value = true
  }

  set {
    name  = "sidecar.datasources.namespaces"
    value = "ALL"
  }

  set {
    name  = "sidecar.dashboards.enabled"
    value = true
  }

  set {
    name  = "sidecar.dashboards.namespaces"
    value = "ALL"
  }

  # set {
  #   name  = "admin.existingSecret"
  #   value = "grafana-admin-secret"
  # }
}
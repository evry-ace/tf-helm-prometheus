variable "prometheus_operator_chart_version" {}

variable "prometheus_operator_app_version" {}

variable "prometheus_operator_namespace" {
  default = "monitoring"
}

variable "prometheus_rbac_enabled" {
  default = true
}

variable "prometheus_external_url" {}

variable "alertmanager_external_url" {}
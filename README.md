# tf\_helm\_prometheus

Create kubernetes service for prometheus and grafana. This module will deploy prometheus-operator to prometheus_operator_namespace
and configure istio to include grafana in the monitoring namespace.

## Usage

```hcl
module "prometheus-operator" {
  source                            = "github.com/evry-ace/tf_helm_prometheus"
  prometheus_operator_chart_version = "${var.prometheus_operator_chart_version}"
  prometheus_operator_app_version   = "${var.prometheus_operator_app_version}"
  prometheus_external_url           = "http://prometheus.${azurerm_dns_zone.ace-dns-env-zone.name}"
  alertmanager_external_url         = "http://alertmanager.${azurerm_dns_zone.ace-dns-env-zone.name}"
}

module "grafana" {
  source = "github.com/evry-ace/tf_helm_prometheus"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| prometheus_operator_chart_version | Chart version | string | `""` | yes |
| prometheus_operator_app_version | Application version | string | `""` | yes |
| prometheus_operator_namespace | Namespace | string | `monitoring` | no |
| prometheus_rbac_enabled | rbac toggle | bool | `true` | no |
| prometheus_external_url | Prometheus URL | string | `""` | yes |
| alertmanager_external_url | Alertmanager URL | string | `""` | yes |

## Authors

Module is maintained by the EVRY ACE Team.

## License

MIT License. See [LICENSE](./LICENSE) for full details.
variable "test1" {}

locals {
  dsp_airflow_version            = "2.5.3"
  dsp_airflow_helm_chart_version = "1.0.11"
  dsp_airflow_helm_values_file   = "override-jio-common.yaml"

  dsp_airflow_helm_values_path = "${path.cwd}/../../../external-configs/gke-reloader/${local.dsp_airflow_helm_chart_version}/${local.dsp_airflow_helm_values_file}"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }

}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  values = [
    "${file("${local.dsp_airflow_helm_values_path}")}"
  ]
}


resource "null_resource" "example" {
  count = "${var.test1}"
  provisioner "local-exec" {
    command = "echo ${file("${local.dsp_airflow_helm_values_path}")}"
  }


}
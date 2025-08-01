resource "harness_platform_environment" "environment" {
  name       = "envnaman6"
  identifier = "envnaman6"
  org_id     = "Ng_Pipelines_K8s_Organisations"
  project_id = "DoNotDelete_NamanTest"
  description = local.virtual_dir_prefix
  type       = "PreProduction"
  yaml = <<-EOT
    environment:
      name: "envnaman6"
      identifier: "envnaman6"
      description: ${local.virtual_dir_prefix}
      orgIdentifier: "Ng_Pipelines_K8s_Organisations"
      projectIdentifier: "DoNotDelete_NamanTest"
      type: "PreProduction"
      tags:
        project: AAF2
        EnvironmentType: "PreProduction"
  EOT

}

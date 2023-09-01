locals {
  tags = {
    AppName       = var.app_name
    "GitHubRepo"  = "https://gitlab.aws.dev/sesterhg/bell-retail-infra"
    "Provisioner" = "Terraform"
  }
}

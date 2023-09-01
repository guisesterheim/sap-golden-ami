resource "aws_imagebuilder_distribution_configuration" "this" {
  name       = "${var.app_name}-local-distribution"

  distribution {
    ami_distribution_configuration {

      ami_tags = merge({
        "Name" = "${var.operating_system}-Infra",
        "Created-By" = "EC2-Image-Builder",
        "EC2-Image-Builder-Pipeline-Name" = "${var.app_name}-AMI-pipeline",
        },
      var.tags)

      name = "Golden-RedHat-{{ imagebuilder:buildDate }}"
    }
    region = var.aws_region
  }
}
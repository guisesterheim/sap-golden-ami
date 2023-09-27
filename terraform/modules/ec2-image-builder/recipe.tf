resource "aws_imagebuilder_image" "this" {
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.this.arn
  image_recipe_arn                 = aws_imagebuilder_image_recipe.this.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn
}

resource "aws_imagebuilder_image_recipe" "this" {
  name         = "itsre-${var.environment}-${var.operating_system}-AMI-recipe"
  parent_image = var.base_ami
  version      = "1.0.0"

  block_device_mapping {
    device_name = "/dev/sda1"

    ebs {
      delete_on_termination = true
      volume_size           = 50
      volume_type           = "gp3"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.custom_ansible.arn
  }

  working_directory = "/home/ec2-user"

  tags = var.tags
}
resource "aws_imagebuilder_image" "this" {
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.this.arn
  image_recipe_arn                 = aws_imagebuilder_image_recipe.this.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn
}

resource "aws_imagebuilder_image_recipe" "this" {
  name         = "${var.app_name}-AMI-recipe"
  parent_image = var.base_ami
  version      = "1.0.0"
  
  block_device_mapping {
    device_name = "/dev/xvdb"

    ebs {
      delete_on_termination = true
      volume_size           = "50"
      volume_type           = "gp3"
      encrypted = true
      kms_key_id = var.kms_key_arn
    }
  }

  component {
    # component_arn = var.aws_cli_component_ec2_image_builder_arn
    component_arn = aws_imagebuilder_component.custom_ansible.arn
  }

  # user_data_base64 = base64encode(data.template_file.golden_ami_userdata.rendered)
  working_directory = "/home/ec2-user"

  tags = var.tags
}
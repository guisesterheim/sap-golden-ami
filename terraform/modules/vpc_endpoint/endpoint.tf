resource "aws_vpc_endpoint" "ec2_image_builder" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.ca-central-1.imagebuilder"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.sg_endpoint.id
  ]
  subnet_ids = var.subnet_ids

  private_dns_enabled = true

  tags = merge({"Name" = "vpce-itsre-${var.environment}-ec2-image-builder"}, var.tags)
}
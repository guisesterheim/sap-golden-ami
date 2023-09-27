resource "aws_security_group" "sg_endpoint" {
  name        = "secgrp-itsre-${var.environment}-cc1-retail-endpoint"
  description = "Group for EC2 Image Builder Endpoint"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

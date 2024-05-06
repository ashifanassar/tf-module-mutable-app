# security groups that allows only ws netwokr and internal network
resource "aws_security_group" "allow_app" {
  count                   = var.INTERNAL ? 0 :  1
  name                    = "roboshop-${COMPONENT}-${var.ENV}"
  description             = "roboshop-${COMPONENT}-${var.ENV}"
  vpc_id                  = data.terraform_remote_state.vpc.outputs.VPC_ID


  ingress {
    description     = "SSH for Default & roboshop vpc"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR, data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }


  ingress {
    description     = "Allows Only Appl Traffic"
    from_port       = var.APP_PORT
    to_port         = var.APP_PORT
    protocol        = "tcp"
    cidr_blocks     = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.COMPONENT}-${var.ENV}"
  }
}


locals {
  INSTANCE_COUNT = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
  INSTANCE_IDS   = concat(aws_spot_instance_request.spot.*.spot_instance_id , aws_instance.od.*.id)
}


resource "aws_lb_target_group" "app" {
  name     = "${var.COMPONENT}-${var.ENV}-tg"
  port     = var.APP_PORT
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.VPC_ID
}

#Register the backend instance with the target group

# Register the Backend Instance to the appropriate target group.check " 
resource "aws_lb_target_group_attachment" "attach_instances" {
  count            = local.INSTANCE_COUNT
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = element(local.INSTANCE_IDS, count.index)
  port             = var.APP_PORT
}
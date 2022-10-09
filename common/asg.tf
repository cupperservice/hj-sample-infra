resource "aws_launch_template" "hj-sample-template" {
  name_prefix = "hj-sample-template"
  image_id    = var.app.image_id
  instance_type = var.app.instance_type
  key_name = var.app.key_name
  vpc_security_group_ids = [
    aws_security_group.app.id
  ]

  iam_instance_profile {
    name = "EMR_EC2_DefaultRole"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "app-asg"
    }
  }
}

resource "aws_autoscaling_group" "hj-sample" {
  name                      = "hj-sample-asg"
  vpc_zone_identifier       = [aws_subnet.your-sub-pub1.id, aws_subnet.your-sub-pub2.id]
  max_size                  = var.app.max_size
  min_size                  = var.app.min_size
  desired_capacity          = var.app.min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  launch_template {
    id      = aws_launch_template.hj-sample-template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name  = aws_autoscaling_group.hj-sample.id
  alb_target_group_arn    = aws_lb_target_group.alb.arn
}

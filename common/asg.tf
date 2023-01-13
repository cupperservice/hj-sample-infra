resource "aws_launch_template" "hj-sample-template" {
  name_prefix = "hj-sample-template"
  image_id    = var.app.image_id
  instance_type = var.app.instance_type
  key_name = var.app.key_name

  iam_instance_profile {
    name = "LabInstanceProfile"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "app-asg"
    }
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.app.id]
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
  target_group_arns = [aws_alb_target_group.alb.arn]
}

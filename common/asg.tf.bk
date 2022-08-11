resource "aws_launch_template" "hj-sample-template" {
  name_prefix = "hj-sample-template"
  image_id    = ""
  instance_type = "t2.small"
}

resource "aws_autoscaling_group" "hj-sample" {
  name                      = "hj-sample-asg"
  vpc_zone_identifier       = [aws_subnet.your-sub-pub1.id, aws_subnet.your-sub-pub2.id]
  max_size                  = 2
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  launch_template {
    id      = aws_launch_template.hj-sample-template.id
    version = "$Latest"
  }
  target_group_arns         = [aws_alb_target_group.alb.arn]
}

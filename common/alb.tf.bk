resource "aws_alb" "alb" {
  name                       = "your-alb"
  security_groups            = ["${aws_security_group.web.id}"]
  subnets                    = ["${aws_subnet.your-sub-pri1.id}", "${aws_subnet.your-sub-pri2.id}"]
  internal                   = false
  enable_deletion_protection = false
}

resource "aws_alb_target_group" "alb" {
  name     = "your-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/health/check"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}

resource "aws_alb_listener" "alb" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "tg2" {
  listener_arn = "${aws_alb_listener.alb.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb.arn}"
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

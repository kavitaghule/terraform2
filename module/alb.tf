resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg2.id]
  subnets            = [aws_subnet.public_sub1.id, aws_subnet.public_sub2.id]

  enable_deletion_protection = true

tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "alb-tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "alb-attach" {
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = aws_instance.web.id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}
  
# create application load balancer

resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg2.id]
  subnets            = [aws_subnet.public_sub1.id, aws_subnet.public_sub2.id]

  enable_deletion_protection = true

tags = {
    Environment = "production"
  }
}

# create target group

resource "aws_lb_target_group" "alb-tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}
resource "aws_lb_target_group_attachment" "alb-attach" {
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = aws_instance.web.id
  port             = 80
}
lifecycle {
create_before_destroy = true
}

# create listener on port 80

resource "aws_lb_listener" "alb_http_lstener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "redirect"
redirect {
port              = "443"
  protocol          = "HTTPS"
}
}
}
# create listener on port 443 with forward action
resource "aws_lb_listener" "alb_http_lstener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
target_group_arn = aws_lb_target_group.alb-tg.arn
      }

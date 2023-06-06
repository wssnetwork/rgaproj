resource "aws_lb_target_group" "weblbg-front" {
    name     = "RGAProj-weblbg-front"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.vpc.id
    health_check {
        enabled             = true
        healthy_threshold   = 3
        interval            = 10
        matcher             = 200
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 3
        unhealthy_threshold = 2
    }
}

resource "aws_lb_target_group_attachment" "weblbg-attach" {
    count            = length(aws_instance.web)
    target_group_arn = aws_lb_target_group.weblbg-front.arn
    target_id        = element(aws_instance.web.*.id, count.index)
    port             = 80
}

resource "aws_lb" "weblb-front" {
    name               = "RGAProj-weblb-front"
    # ignore tfsec findings as this app lb facing internet
    internal           = false #tfsec:ignore:aws-elb-alb-not-public
    load_balancer_type = "application"
    security_groups    = [aws_security_group.weblb-sg.id]
    subnets            = [for subnet in aws_subnet.vpc-private-subnet : subnet.id]

    enable_deletion_protection = false
    drop_invalid_header_fields = true

    tags = {
        Environment = "front"
    }
}

resource "aws_lb_listener" "weblb-front-end" {
    load_balancer_arn = aws_lb.weblb-front.arn
    port              = "443"
    protocol          = "HTTPS"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.weblbg-front.arn
    }
}
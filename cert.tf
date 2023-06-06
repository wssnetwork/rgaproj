resource "aws_acm_certificate" "alb-cert" {
    domain_name       = "rgaproj.local"
    validation_method = "DNS"

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "example.com SSL certificate"
    }
}

resource "aws_lb_listener_certificate" "my-certificate" {
    listener_arn = aws_lb_listener.weblb-front-end.arn
    certificate_arn = aws_acm_certificate.alb-cert.arn
}

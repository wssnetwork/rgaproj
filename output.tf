# For web-1
output "public_ip_web" {
    value = aws_instance.web.*.public_ip
}

output "instance_id_web" {
    value = aws_instance.web.*.id
}

output "instance_web_public_dns" {
    value = aws_instance.web.*.public_dns
}
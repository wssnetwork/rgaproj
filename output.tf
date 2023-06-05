# For web-1
output "public_ip_web_1" {
    value       = aws_instance.web-1.public_ip
    description = "Public IP Address of EC2 instance HA 1"
}

output "instance_id_web_1" {
    value       = aws_instance.web-1.id
    description = "Instance ID HA 1"
}

# For web-2
output "public_ip_web_2" {
    value       = aws_instance.web-2.public_ip
    description = "Public IP Address of EC2 instance HA 2"
}

output "instance_id_web_2" {
    value       = aws_instance.web-2.id
    description = "Instance ID HA 2"
}
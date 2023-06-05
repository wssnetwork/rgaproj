# For web-1
resource "aws_instance" "web-1" {
    ami             = var.ami
    instance_type   = var.instance_type

    tags = {
        Name = var.name_tag-1
    }
}

# For web-2
resource "aws_instance" "web-2" {
    ami             = var.ami
    instance_type   = var.instance_type

    tags = {
        Name = var.name_tag-2
    }
}

# Create VPC
resource "aws_vpc" "vpc" {
    cidr_block              = var.vpc_cidr
    enable_dns_support      = true
    enable_dns_hostnames    = true

    tags = {
        Name = "RGAProj-VPC"
    }
}

# Create Subnet
resource "aws_subnet" "vpc-private-subnet" {
    count               = length(var.subnet_cidr_private)
    vpc_id              = aws_vpc.vpc.id
    cidr_block          = var.subnet_cidr_private[count.index]
    availability_zone   = var.availability_zone[count.index]
    
    tags = {
        Name = "RGAProj-Subnet"
    }
}

# Create Route Table
resource "aws_route_table" "vpc-rt" {
    vpc_id = aws_vpc.vpc.id
        
    tags = {
        Name = "RGAProj-Route-Table"
    }
}

# Associate Subnet with Route Table
resource "aws_route_table_association" "vpc-rt-subnet" {
    subnet_id       = aws_subnet.vpc-private-subnet.id
    route_table_id  = aws_route_table.vpc-rt.id
}

# Create Internet Gateway and Attach it to VPC
resource "aws_internet_gateway" "vpc-ig" {
    vpc_id = aws_vpc.vpc.id
    
    tags = {
        Name = "RGAProj-Internet-Gateway"
    }
}

# Define Route for Route Table
resource "aws_route" "vpc-internet-route" {
    destination_cidr_block = "0.0.0.0/0"
    route_table_id         = aws_route_table.vpc-rt.id
    gateway_id             = aws_internet_gateway.vpc-ig.id
}

# Create Security Group
resource "aws_security_group" "http-sg" {
    name        = "allow_http_access"
    description = "allow inbound http traffic"
    vpc_id      = aws_vpc.vpc.id

    ingress {
        description = "from my ip range"
        from_port   = "80"
        to_port     = "80"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = "0"
        protocol    = "-1"
        to_port     = "0"
    }
    tags = {
        "Name" = "RGAProj-SG"
    }
}

# For Web
resource "aws_instance" "web" {
    count                           = length(var.subnet_cidr_private)
    ami                             = var.ami
    instance_type                   = var.instance_type
    vpc_security_group_ids          = [aws_security_group.http-sg.id]
    subnet_id                       = element(aws_subnet.vpc-private-subnet.*.id, count.index)
    associate_public_ip_address     = true

    tags = {
        Name = "RGAProj-Web-${count.index + 1}"
    }
}

# # For web-2
# resource "aws_instance" "web-2" {
#     ami             = var.ami
#     instance_type   = var.instance_type

#     tags = {
#         Name = "RGAProj-HA-2"
#     }
# }

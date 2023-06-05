variable "ami" {
    type        = string
    description = "Ubuntu AMI ID in Singapore region"
    default     = "ami-002843b0a9e09324a"
}

variable "instance_type" {
    type        = string
    description = "Instance type"
    default     = "t2.micro"
}

variable "region" {
    type        = string
    description = "Provider region"
    default     = "ap-southeast-1"
}

variable "availability_zone" {
    type        = list(any)
    description = "Availability zones"
    default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "vpc_cidr" {
    type        = string
    description = "VPC CIDR block"
    default     = "10.0.0.0/26"
}

variable "subnet_cidr_private" {
    type        = list(any)
    description = "cidr blocks for the private subnets"
    default     = ["10.0.0.0/28", "10.0.0.16/28", "10.0.0.32/28"]
}
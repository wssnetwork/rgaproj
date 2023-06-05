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

variable "name_tag-1" {
    type        = string
    description = "Name of the EC2 instance HA 1"
    default     = "RGAProj-HA-1"
}

variable "name_tag-2" {
    type        = string
    description = "Name of the EC2 instance HA 2"
    default     = "RGAProj-HA-2"
}

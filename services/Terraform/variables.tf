variable "aws_region" {
  description = "AWS region where resources will be created"
  default     = "us-west-2" # Replace with your desired region
  #    default     = "ap-southeast-2" # Replace with your desired region

}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16" # Replace with your desired VPC CIDR block
}

variable "subnet_az1_cidr_block" {
  description = "CIDR block for Subnet in AZ1"
  default     = "10.0.1.0/24" # Replace with your desired subnet CIDR block for AZ1
}

variable "subnet_az2_cidr_block" {
  description = "CIDR block for Subnet in AZ2"
  default     = "10.0.2.0/24" # Replace with your desired subnet CIDR block for AZ2
}


variable "subnet_az1_cidr_block_private" {
  description = "CIDR block for Subnet in AZ2"
  default     = "10.0.3.0/24" # Replace with your desired subnet CIDR block for AZ2
}

variable "subnet_az2_cidr_block_private" {
  description = "CIDR block for Subnet in AZ2"
  default     = "10.0.4.0/24" # Replace with your desired subnet CIDR block for AZ2
}

variable "subnet_az1_cidr_block_secure" {
  description = "CIDR block for Subnet in AZ2"
  default     = "10.0.5.0/24" # Replace with your desired subnet CIDR block for AZ2
}
variable "subnet_az2_cidr_block_secure" {
  description = "CIDR block for Subnet in AZ2"
  default     = "10.0.6.0/24" # Replace with your desired subnet CIDR block for AZ2
}

variable "kubernetes_version" {
  default     = 1.27
  description = "kubernetes version"
}


#variable "rds_db_endpoint"{
#   default = "petclinic.cb6oyio086hd.us-west-2.rds.amazonaws.com"

#   }
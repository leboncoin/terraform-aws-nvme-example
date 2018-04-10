variable "aws_region" {
  description = "Select Aws region"
  default     = "eu-west-1"
}

variable "availability_zone" {
  description = "Select Availability zone"
  default     = "eu-west-1b"
}

variable "subnet_id" {
  description = "Select Subnet id"
}

variable "key_name" {
  description = "Key name to access of instance"
}

variable "instance_type" {
  description = "Type of instance to create"
  default     = "m5.large"
}

variable "hostname" {
  description = "Name of instance to create"
  default     = "aws-demo-nvme"
}

variable "ami" {
  description = "Ami of instance to create"
  default     = "ami-08025971"              #debian stretch
}

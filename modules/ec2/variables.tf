variable "project_name" {}
variable "environment" {}
variable "vpc_id" {}
variable "public_subnet_id" {}
variable "instance_profile_name" {}

variable "ami_id" {
  default = "ami-0f5ee92e2d63afc18"
}

variable "instance_type" {
  default = "t3.micro"
}

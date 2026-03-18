variable "aws_region" {
  default = "ap-northeast-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "instance_name" {
  default = "selfservice-ec2"
}

variable "os_type" {
  description = "OS type"
  type        = string

  validation {
    condition = contains([
      "amazonlinux2023",
      "ubuntu",
      "windows"
    ], var.os_type)

    error_message = "Invalid OS type."
  }
}
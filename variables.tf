variable "aws_region" {
  default = "ap-northeast-1"
}

variable "instance_type" {
  type = string
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
      "windowsserver2022"
    ], var.os_type)

    error_message = "Invalid OS type."
  }
}
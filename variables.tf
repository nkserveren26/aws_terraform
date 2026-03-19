variable "aws_region" {
  default = "ap-northeast-1"
}

variable "instance_type" {
  type = string

  validation {
    condition = (
      var.os_type != "windows" ||
      contains([
        "t3.small",
        "t3.medium",
        "t3.large"
      ], var.instance_type)
    )

    error_message = "Windowsの場合は t3.small 以上を指定してください"
  }
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
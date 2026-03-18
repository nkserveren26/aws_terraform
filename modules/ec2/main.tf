# Amazon Linux 2023
data "aws_ssm_parameter" "amazonlinux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64" # x86_64
}

# Ubuntu 22.04
data "aws_ssm_parameter" "ubuntu" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

# Windows Server 2022
data "aws_ssm_parameter" "windows" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2022-English-Full-Base"
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ssm_parameter.amazonlinux_2023.value
  instance_type = var.instance_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.sg_id
  ]

  iam_instance_profile = var.instance_profile

  tags = {
    Name = var.instance_name
  }
}
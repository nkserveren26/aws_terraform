data "aws_ssm_parameter" "amazonlinux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64" # x86_64
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
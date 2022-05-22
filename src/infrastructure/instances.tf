## EC2
resource "aws_instance" "sample_ec2" {
  ami           = data.aws_ami.ubuntu_free_tier.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.vpc_sample_subnet_a.id
  depends_on = [
    aws_subnet.vpc_sample_subnet_a,
    aws_security_group.ec2_sample_security_group,
  ]
  # To not generate a public IP instantanely
  associate_public_ip_address = false

  # security_groups = [ aws_security_group.ec2_sample_security_group.name]
  # If you are creating Instances in a VPC, use vpc_security_group_ids instead.
  vpc_security_group_ids = [aws_security_group.ec2_sample_security_group.id]

  # This will install node in the EC2 instance.
  user_data = <<EOF
#! /bin/bash
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
EOF

  tags = merge(local.common_tags, {
    Name = "${var.project}-${terraform.workspace}-ec2"
  })
}
# Security Group
resource "aws_security_group" "ec2_sample_security_group" {
  name        = "sample-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.sample_vpc.id
  depends_on = [
    aws_vpc.sample_vpc
  ]

  tags = merge(local.common_tags, {
    Name = "${var.project}-${terraform.workspace}-sg"
  })
}

# Security Group rule
resource "aws_security_group_rule" "allow_all" {
  type              = "ingress"
  protocol          = "TCP"
  to_port           = 3000
  from_port         = 3000
  security_group_id = aws_security_group.ec2_sample_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Egress means traffic that’s leaving from inside the private network out to the public internet
# Ingress refers to unsolicited traffic sent from an address in public internet to the private network – it is not a response to a request initiated by an inside system. 
resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  protocol          = "TCP"
  to_port           = 22
  from_port         = 22
  security_group_id = aws_security_group.ec2_sample_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "name" {
  type              = "egress"
  protocol          = "all"
  to_port           = 0
  from_port         = 0
  security_group_id = aws_security_group.ec2_sample_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}
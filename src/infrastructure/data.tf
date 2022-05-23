# Availability zones
data "aws_availability_zones" "az" {
  state = "available"
}

## AMI
data "aws_ami" "ubuntu_free_tier" {
  # Returns the most recent one
  most_recent = true
  filter {
    ## Filter by image id, this image is the free tier one
    name   = "image-id"
    values = ["ami-02584c1c9d05efa69"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "aws-marketplace", "099720109477"]
}
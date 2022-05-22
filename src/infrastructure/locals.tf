locals {
  common_tags = {
    project     = "${var.project}"
    environment = terraform.workspace
  }
}
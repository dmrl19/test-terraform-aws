# Providers
# Init the Terraform configuration to get the required providers.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-dev-dmr-bucket"
    #Path to set the state file inside the S3 Bucket
    key    = "state/terraform.tfstate"

    # Create enviroment variables with "AWS_SECRET_KEY", "AWS_ACCESS_KEY", "AWS_DEFAULT_REGION" to not set them here.
    # access_key = "[AWS_ACCESS_KEY]"
    # secret_key = "[AWS_SECRET_KEY]"
    # region = "eu-central-1"
  }
}

# Set the required keys of the AWS provider
provider "aws" {

  # Create enviroment variables with "AWS_SECRET_KEY", "AWS_ACCESS_KEY", "AWS_DEFAULT_REGION" to not set them here.
  # access_key = "[AWS_ACCESS_KEY]"
  # secret_key = "[AWS_SECRET_KEY]"
   region = var.region
}
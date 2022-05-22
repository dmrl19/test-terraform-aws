variable "project" {
  type        = string
  description = "Project name for resource tagging"
  default     = "dmr-terraform-aws-sample"
}

#export TF_VAR_region=[varriable-value]
# This variable is not longer required to set it, but for the purpose of using a variable in github actions we do just do it.
variable "region" {
  type = string
  description = "The region where the resources will live"
}

# These 2 variables are no longer required to set them since it will be feched from the env variables
# variable "AWS_ACCESS_KEY" {
#   type = string
#   description = "The access key of your AWS user account"
# }

# variable "AWS_SECRET_KEY" {
#   type = string
#   description = "The secret key of your AWS user account"
# }
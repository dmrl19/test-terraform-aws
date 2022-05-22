variable "project" {
  type        = string
  description = "Project name for resource tagging"
  default     = "dmr-terraform-aws-sample"
}

#export TF_VAR_region=[varriable-value]
variable "region" {
  type = string
  description = "The region where the resources will live"
}

variable "AWS_ACCESS_KEY" {
  type = string
  description = "The region where the resources will live"
}

variable "AWS_SECRET_KEY" {
  type = string
  description = "The region where the resources will live"
}
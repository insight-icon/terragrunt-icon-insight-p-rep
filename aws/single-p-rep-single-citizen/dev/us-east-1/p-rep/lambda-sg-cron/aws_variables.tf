variable "aws_region" {
  description = "AWS region to use for all resources"
  default     = "us-east-1"
}

variable "aws_allowed_account_ids" {
  description = "List of allowed AWS accounts where this configuration can be applied"
  type        = list
}


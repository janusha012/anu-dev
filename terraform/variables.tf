variable "project_name" {
  description = "Name of the DevSecOps project"
  type        = string
  default     = "anu-dev"
}

variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "ap-south-1"
}

variable "existing_instance_id" {
  description = "Existing EC2 instance ID"
  type        = string
  default     = "i-0977cdfa2acf4cd3a"
}

variable "existing_security_group_id" {
  description = "Existing EC2 security group ID"
  type        = string
  default     = "sg-0561ad062b4bb1df5"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"   # Mumbai (good for India)
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "event-pipeline"
}

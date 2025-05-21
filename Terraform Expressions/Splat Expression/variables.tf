# String type
variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod, staging)"
  default     = "dev"
}

# List type
variable "account_names" {
  type        = list(string)
  description = "List of allowed Azure storage accounts"
  default     = ["2016mystorageacc1", "2016mystorageacc2", "2016mystorageacc3"]
}



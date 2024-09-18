variable "region" {
  description = "AWS region"
  default     = "ap-south-1"  
}

variable "db_instance_identifier" {
  description = "RDS DB instance identifier"
  default     = "mydbinstance-v2"  
}

variable "db_name" {
  description = "Database name"
  default     = "mydatabase"
}

variable "db_username" {
  description = "Database username"
  default     = "admin"
}

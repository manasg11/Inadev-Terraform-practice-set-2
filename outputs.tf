output "secret_arn" {
  description = "The ARN of the created Secrets Manager secret"
  value       = aws_secretsmanager_secret.db_secret.arn
}

output "db_password" {
  description = "The generated database password"
  value       = random_password.db_password.result
  sensitive   = true
}

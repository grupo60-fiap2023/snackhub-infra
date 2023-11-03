output "ecr-repository-url" {
  value = aws_ecr_repository.ecr_terraform.repository_url
}

output "aws-db-instance" {
  value = aws_db_instance.snackhub-db.address
}
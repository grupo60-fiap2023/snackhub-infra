resource "aws_ecr_repository" "snackhub-app" {
  name                 = "snackhub-app"
  image_tag_mutability = "MUTABLE"
}
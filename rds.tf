resource "aws_db_instance" "snackhub-db" {
  allocated_storage = 10
  db_name = "snackhub"
  instance_class = "db.t3.micro"
  username = var.db_user
  password = var.db_password
  engine = "mysql"
  engine_version = "8.0.33"
  identifier = "snackhub-db-from-terraform"
  publicly_accessible = true
  skip_final_snapshot = true
  vpc_security_group_ids = [ aws_security_group.sec-group.id ]
  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.id
}

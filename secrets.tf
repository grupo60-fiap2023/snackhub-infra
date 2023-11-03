variable "db_user" {
    type = string
    default = "admin"
    description = "Username para o DB"
    sensitive = false
}

variable "db_password" {
  type = string
  default = "12345678"
  description = "Senha para o DB"
  sensitive = true
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "CIDR para a VPC"
  sensitive = false
}

variable "region" {
  type = string
  default = "us-east-1"
}
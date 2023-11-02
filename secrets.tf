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
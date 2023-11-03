resource "aws_vpc" "vpc-tf" {
 cidr_block = var.vpc_cidr
 enable_dns_hostnames = true
 tags = {
   name = "main"
 }
}

resource "aws_subnet" "subnet_a" {
 vpc_id                  = aws_vpc.vpc-tf.id
 cidr_block              = cidrsubnet(aws_vpc.vpc-tf.cidr_block, 4, 1)
 map_public_ip_on_launch = true
 availability_zone = "${var.region}a"
}

resource "aws_subnet" "subnet_b" {
 vpc_id                  = aws_vpc.vpc-tf.id
 cidr_block              = cidrsubnet(aws_vpc.vpc-tf.cidr_block, 7, 1)
 map_public_ip_on_launch = true
 availability_zone = "${var.region}b"
}

resource "aws_internet_gateway" "internet_gateway" {
 vpc_id = aws_vpc.vpc-tf.id
 tags = {
   Name = "internet_gateway"
 }
}

resource "aws_route_table" "route_table" {
 vpc_id = aws_vpc.vpc-tf.id
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.internet_gateway.id
 }
}

resource "aws_route_table_association" "subnet_route_a" {
 subnet_id      = aws_subnet.subnet_a.id
 route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet_route_b" {
 subnet_id      = aws_subnet.subnet_b.id
 route_table_id = aws_route_table.route_table.id
}


resource "aws_security_group" "sec-group" {
  name   = "sec-group"
  vpc_id = aws_vpc.vpc-tf.id

  # HTTP access from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id,aws_subnet.subnet_b.id]
}

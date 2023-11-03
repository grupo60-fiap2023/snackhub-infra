resource "aws_vpc" "vpc-tf" {
 cidr_block = var.vpc_cidr
 enable_dns_hostnames = true
 tags = {
   name = "main"
 }
}

resource "aws_subnet" "subnet" {
 vpc_id                  = aws_vpc.vpc-tf.id
 cidr_block              = cidrsubnet(aws_vpc.vpc-tf.cidr_block, 8, 1)
 map_public_ip_on_launch = true
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

resource "aws_route_table_association" "subnet_route" {
 subnet_id      = aws_subnet.subnet.id
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
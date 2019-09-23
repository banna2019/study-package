resource "aws_subnet" "tsbunet" {
  vpc_id                  = "vpc-03316aa6aea92dc83"
  cidr_block              = "10.13.10.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "tsubnet"
  }
}

resource "aws_vpc" "test_vpc" {
  cidr_block           = "10.13.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "test_vpc"
  }
}

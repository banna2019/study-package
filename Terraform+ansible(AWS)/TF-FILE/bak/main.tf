provider "aws" {
  version = "~> 2.0"
  region  = "ap-southeast-1"
}


#---------------VPC-------------
resource "aws_vpc" "tw1_vpc" {
  cidr_block           = "${var.vpc.cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "tw1_vpc"
  }
}


#internet gateway
resource "aws_internet_gateway" "tw1_internet_gateway" {
  vpc_id = "${aws_vpc.tw1_vpc.id}"

  tags {
    Name = "tw1_igw"
  }
}

#Route tables
resource "aws_route_table" "tw1_public_rt" {
  vpc_id = "${aws_vpc.tw1_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tw1_internet_gateway.id}"
  }

  tags {
    Name = "tw1_public"
  }
}

resource "aws_default_route_table" "tw1_private_rt" {
  default_route_table_id = "${aws_vpc.tw1_vpc.default_route_table_id}"

  tags {
    Name = "tw1_private"
  }
}

resource "aws_subnet" "tw1_public1_subnet" {
  vpc_id                  = "${aws_vpc.tw1_vpc.id}"
  cidr_block              = "${var.cidrs["public1"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.avaliable.names[0]}"

  tags {
    Name = "tw1_public1"
  }
}

resource "aws_subnet" "tw1_public2_subnet" {
  vpc_id                  = "${aws_vpc.tw1_vpc.id}"
  cidr_block              = "${var.cidrs["public2"]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.avaliable.names[0]}"

  tags {
    Name = "tw1_public2"
  }
}

resource "aws_subnet" "tw1_private1_subnet" {
  vpc_id                  = "${aws_vpc.tw1_vpc.id}"
  cidr_block              = "${var.cidrs["private1"]}"
  map_public_ip_on_launch = false
  avaliability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "tw1_private1"
  }
}


resource "aws_subnet" "tw1_private2_subnet" {
  vpc_id                  = "${aws_vpc.tw1_vpc.id}"
  cidr_block              = "${var.cidrs["private2"]}"
  map_public_ip_on_launch = false
  avaliability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "tw1_private2"
  }
}

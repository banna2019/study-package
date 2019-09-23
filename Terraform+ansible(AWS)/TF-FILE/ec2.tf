resource "aws_instance" "myinstance" {
  ami           = "ami-0b4dd9d65556cac22"
  instance_type = "t2.medium"

  key_name   = "IT_TPM"
  subnet_id  = "subnet-07e23a2ddf27c9ada"
  private_ip = "10.13.10.99"

  tags = {
    Name = "myinstance"
  }
}

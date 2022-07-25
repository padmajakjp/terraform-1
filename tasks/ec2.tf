resource "tls_private_key" "dev_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "keypair" {
  key_name   = var.keypair
  public_key = tls_private_key.dev_key.public_key_openssh

  provisioner "local-exec" {    # Generates "keypair.pem" in current directory
    command = <<-EOT
      echo '${tls_private_key.dev_key.private_key_pem}' > ./'${var.keypair}'.pem
      chmod 400 ./'${var.keypair}'.pem
    EOT
  }

}

resource "aws_instance" "dev-public" {
  ami                         = "${var.ami-id}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = ["${aws_security_group.public-sg.id}"]
  key_name                    = "${var.keypair}"
  associate_public_ip_address = true
  tags = {
    Name = "${var.tag}-public-instance"
  }
}

resource "aws_instance" "dev-private" {
  ami                         = "${var.ami-id}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = ["${aws_security_group.private-sg.id}"]
  key_name                    = "${var.keypair}"
  associate_public_ip_address = false
  tags = {
    Name = "${var.tag}-private-instance"
  }
}


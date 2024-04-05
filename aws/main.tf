resource "aws_security_group" "this" {
  name = "${var.namespace}-sg"
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = "m5.xlarge"

  vpc_security_group_ids      = [aws_security_group.this.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 1400 # https://ycharts.com/indicators/ethereum_chain_full_sync_data_size
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.namespace}-instance"
  }

  key_name = var.key_name
}

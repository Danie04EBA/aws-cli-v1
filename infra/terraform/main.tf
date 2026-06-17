resource "aws_security_group" "bars_sg" {
  name   = "dadavid-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "dadavid_server" {
  vpc_id     = var.vpc_id
  cidr_block = "172.31.96.0/24"

  tags = {
    name = "dadavid_server"
  }
}

# 1. Génération d'une clé privée RSA
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Association : création de la key pair AWS à partir de la clé publique
resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

# 3. Récupération : sauvegarde de la clé privée en local (.pem)
resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0400"
}

resource "aws_instance" "dadavid_serverweb" {
  ami                         = var.vm_image
  key_name                    = aws_key_pair.this.key_name
  instance_type               = var.vm_instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.dadavid_server.id
  vpc_security_group_ids      = [aws_security_group.bars_sg.id]

  tags = {
    name = var.instance_name
  }
}

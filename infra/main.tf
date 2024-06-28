terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  profile = "default"
  region  = var.regiao_aws
}

resource "aws_instance" "app_server" {
  ami           = "ami-0cf2b4e024cdb6960"
  instance_type = var.instacia
  key_name = var.chave
  # user_data = <<-EOF
  #               #!/bin/bash
  #               cd /home/ubuntu
  #               echo "<h1>Feito com Terraform</h1>" > index.html
  #               nohup busybox httpd -f -p 8080 &
  #               EOF

  tags = {
    Name = var.nome
  }
  security_groups = [ aws_security_group.acesso_geral.name ]
}

resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}

output "IP_public" {
  value = aws_instance.app_server.public_ip   
}
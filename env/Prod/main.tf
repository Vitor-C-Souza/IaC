module "aws-prod" {
    source = "../../infra"
    instacia = "t2.micro"
    regiao_aws = "us-west-2"
    chave = "IaC-PROD"
    nome = "prod"
}

output "IP" {
  value = module.aws-prod.IP_public
}
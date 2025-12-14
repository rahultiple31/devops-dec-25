module "vpc" {
  source = "git::https://github.com/rahultiple31/devops-dec-25.git//child-module/vpc?ref=main"

  name       = var.name
  cidr_block = var.cidr_block
  tags       = var.tags
}

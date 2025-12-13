resource "aws_vpc" "vpc-itheroes" {
  cidr_block           = var.cidr_block
  tags = merge(
    var.tags,
    { Name = "${var.name}-vpc" }
  )

}

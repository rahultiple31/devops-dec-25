resource "aws_vpc" "var.name" {
  cidr_block           = var.cidr_block
  tags = merge(
    var.tags,
    { Name = "${var.name}-vpc" }
  )
}
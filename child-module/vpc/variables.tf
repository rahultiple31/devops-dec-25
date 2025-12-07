variable "name" {
  type        = string
  description = "eks vpc"
}
variable "cidr_block" {
  type        = string
  description = "eks vpc"
}
variable "tags" {
  type        = map(string)
  default     = {}
}
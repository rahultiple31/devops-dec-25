terraform {
  backend "s3" {
    bucket = "terraformtushar123.com"
    key    = "app/flipkart/prod/terraform.tfstate"
    region = "ap-south-1"
    #use_lockfile = "true"
  }
}
terraform {
  backend "s3" {
    bucket = "flams-admin"
    key    = "d2si/lab/coreInfra.tfstate"
    region = "eu-west-1"
  }
}

terraform {
  backend "s3" {
    bucket = "flams-admin"
    key    = "d2si/lab/coreInfra_test.tfstate"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "coreinfra" {
  backend = "s3"

  config = {
    region = "eu-west-1"
    bucket = "flams-admin"
    key    = "d2si/lab/coreInfra.tfstate"
  }
}

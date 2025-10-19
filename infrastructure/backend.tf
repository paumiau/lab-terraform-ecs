# Backend local
#terraform {
#  backend "local" {
#    path = "terraform.tfstate"
#  }
#}

# Backend S3 Remoto
terraform {
  backend "s3" {
    bucket  = "lab-ecs-tfstate-942632789708" # Reemplazar
    key     = "lab-ecs/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}

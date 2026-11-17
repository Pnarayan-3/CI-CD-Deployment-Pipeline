terraform {
  backend "s3" {
    bucket       = "my-terraform-state-bucket"
    key          = "terraform-cicd-demo/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}

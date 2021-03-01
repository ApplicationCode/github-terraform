remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "appcode-tfstate-5790"
    prefix         = "github/${path_relative_to_include()}"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "github" {
  organization = "ApplicationCode"
}
EOF
}

generate "terraform" {
    path = "terraform.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
terraform {
  required_version = "~> 0.14"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.4.0"
    }
  }
}
EOF
}

generate "remote_state" {
    path = "remote_state.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
data "terraform_remote_state" "teams" {
  backend = "gcs"

  config = {
    bucket         = "appcode-tfstate-5790"
    prefix         = "github/teams"
  }
}
EOF
}

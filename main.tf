terraform {
  required_providers {
    harness = {
      source = "harness/harness"
    }
  }
}

#Configure the Harness provider for Next Gen resources
provider "harness" {
  endpoint         = "https://app.harness.io/gateway"
  account_id       = var.account_id
  platform_api_key = var.platform_api_key
}

resource "harness_platform_connector_github" "poc_github" {
  identifier  = "poc_github"
  name        = "POC Github"
  description = "Account level GitHub connector for Harness Account"
  tags        = ["foo:bar"]

  url             = "https://github.com/account"
  connection_type = "Account"
  validation_repo = "quick-react"
  #   delegate_selectors = ["harness-delegate"]
  credentials {
    http {
      username  = var.github_username
      token_ref = "account.poc_github_secret"
    }
  }
}

resource "harness_platform_connector_docker" "test" {
  identifier  = "poc_docker_hub_anon"
  name        = "POC Docker Hub Anonymous"
  description = "POC Docker Hub anonymous connection"
  tags        = ["purpose:poc"]

  type               = "DockerHub"
  url                = "https://hub.docker.com"
  delegate_selectors = ["harness-delegate"]
}

# credentials username password
resource "harness_platform_connector_docker" "poc_docker_hub" {
  identifier  = "poc_docker_hub"
  name        = "POC Docker Hub Authenticated"
  description = "POC Docker Hub authenticated connection"
  tags        = ["purpose:poc"]

  type               = "DockerHub"
  url                = "https://hub.docker.com"
  delegate_selectors = ["harness-delegate"]
  credentials {
    username     = "admin"
    password_ref = "account.secret_id"
  }
}

## OLD:

# module "delegate" {
#   source  = "harness/harness-delegate/kubernetes"
#   version = "0.1.5"

#   account_id = var.account_id
#   # create_namespace = var.create_namespace
#   delegate_token   = var.delegate_token
#   delegate_name    = var.delegate_name
#   namespace        = var.namespace
#   manager_endpoint = var.manager_endpoint
#   delegate_image   = var.delegate_image
#   replicas         = 1
#   upgrader_enabled = false

#   # Additional optional values to pass to the helm chart
#   values = yamlencode({
#     initScript : ""
#   })
# }

# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }

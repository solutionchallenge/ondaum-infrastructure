# Manage 'tfstate' on the alternative provider. (for HA)
terraform {
  backend "s3" {
    region                      = "auto"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

module "core" {
  source         = "./modules/core"
  GCP_PROJECT_ID = var.GCP_PROJECT_ID
}

module "network" {
  source         = "./modules/network"
  GCP_PROJECT_ID = var.GCP_PROJECT_ID
  GCP_REGION_ID  = var.GCP_REGION_ID
}

module "kubernetes" {
  source              = "./modules/kubernetes"
  GCP_PROJECT_ID      = var.GCP_PROJECT_ID
  GCP_REGION_ID       = var.GCP_REGION_ID
  GCP_LOCATION_IDS    = var.GCP_LOCATION_IDS
  GCP_GKE_VPC_NAME    = module.network.primary_vpc_name
  GCP_GKE_SUBNET_NAME = module.network.primary_subnet_name
  GCP_GKE_NODE_TYPE   = "e2-highcpu-4"
}

module "database" {
  source            = "./modules/database"
  GCP_PROJECT_ID    = var.GCP_PROJECT_ID
  GCP_REGION_ID     = var.GCP_REGION_ID
  GCP_DB_VPC_LINK   = module.network.primary_vpc_link
  GCP_DB_IP_ENABLED = true
  GCP_DB_SVC_NET    = module.network.primary_svc_net
  GCP_DB_USERS = {
    ondaum = {
      name     = "main"
      password = ""
    }
  }
}

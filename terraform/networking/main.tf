provider "porkbun" {
  api_key        = ephemeral.sops_file.secrets.data["PORKBUN_API_KEY"]
  secret_api_key = ephemeral.sops_file.secrets.data["PORKBUN_API_SECRET_KEY"]
}

terraform {
  required_providers {
    porkbun = {
      source  = "marcfrederick/porkbun"
      version = "~> 1.3"
    }

    dns = {
      source  = "hashicorp/dns"
      version = "~> 3.4"
    }

    sops = {
      source  = "carlpett/sops"
      version = "~> 1.3"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }

  required_version = "~> 1.14"
}

provider "cloudflare" {
  api_token = ephemeral.sops_file.secrets.data["CLOUDFLARE_API_TOKEN"]
}

provider "sops" {
  # Configuration options
}

ephemeral "sops_file" "secrets" {
  source_file = "../../.env"
}

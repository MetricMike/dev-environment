resource "porkbun_nameservers" "org_dweigle_cloudflare" {
  domain      = "dweigle.org"
  nameservers = ["dora.ns.cloudflare.com", "wells.ns.cloudflare.com"]
}

resource "porkbun_dnssec_record" "org_dweigle_cloudflare" {
  domain       = "dweigle.org"
  max_sig_life = 3600

  ds_data = {
    algorithm   = 13
    digest      = "F6A11BD6AB60F9B8D030DF1A8369FB41390223E2D5CAD5901856E13B29F64B85"
    digest_type = 2
    key_tag     = "2371"
  }
}

data "cloudflare_zone" "org_dweigle" {
  filter = {
    name = "dweigle.org"
  }
}

moved {
  from = cloudflare_dns_record.org_dweigle_proton_ownership
  to   = cloudflare_dns_record.org_dweigle_protonpass_ownership
}
resource "cloudflare_dns_record" "org_dweigle_protonpass_ownership" {
  zone_id = data.cloudflare_zone.org_dweigle.zone_id
  ttl     = 1
  proxied = false

  name    = "@"
  type    = "TXT"
  content = "\"pm-verification=swelqyeoqegksuqpuayjlkrtidjdew\""
}
resource "cloudflare_dns_record" "org_dweigle_protonmail_ownership" {
  zone_id = data.cloudflare_zone.org_dweigle.zone_id
  ttl     = 1
  proxied = false

  name    = "@"
  type    = "TXT"
  content = "\"protonmail-verification=9f3aca1d0138eaf9cbffa0f23f2fb069c5eb046d\""
}

resource "cloudflare_dns_record" "org_dweigle_email" {
  for_each = local.proton_mail

  zone_id = data.cloudflare_zone.org_dweigle.zone_id
  ttl     = 1
  proxied = false

  name     = try(each.value.subdomain, "@")
  priority = try(each.value.priority, null)
  type     = each.value.type
  content  = each.value.content
}


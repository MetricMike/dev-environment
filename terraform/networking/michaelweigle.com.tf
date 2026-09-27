data "porkbun_nameservers" "com_michaelweigle" {
  domain = "michaelweigle.com"
}

resource "porkbun_dns_record" "com_michaelweigle_proton_ownership" {
  domain    = data.porkbun_nameservers.com_michaelweigle.domain
  subdomain = ""
  type      = "TXT"
  content   = "pm-verification=ogkglkvslqwtgqfhbqbgwtjutdsvxr"
}

resource "porkbun_dns_record" "com_michaelweigle_protonmail_ownership" {
  domain    = data.porkbun_nameservers.com_michaelweigle.domain
  subdomain = ""
  type      = "TXT"
  content   = "protonmail-verification=ba72d38fe2d5a26d792a15cf48f84454a68551f7"
}

locals {
  com_michaelweigle_proton_mail = {
    dkim1 = { type = "CNAME", subdomain = "protonmail._domainkey", content = "protonmail.domainkey.djain66dzl6x2a23k25z2j7gz4wqqovtdcglhzsavhdtstmui62yq.domains.proton.ch." }
    dkim2 = { type = "CNAME", subdomain = "protonmail2._domainkey", content = "protonmail2.domainkey.djain66dzl6x2a23k25z2j7gz4wqqovtdcglhzsavhdtstmui62yq.domains.proton.ch." }
    dkim3 = { type = "CNAME", subdomain = "protonmail3._domainkey", content = "protonmail3.domainkey.djain66dzl6x2a23k25z2j7gz4wqqovtdcglhzsavhdtstmui62yq.domains.proton.ch." }
  }
}

resource "porkbun_dns_record" "com_michaelweigle_email" {
  for_each = merge(local.proton_mail, local.com_michaelweigle_proton_mail)

  domain = data.porkbun_nameservers.com_michaelweigle.domain

  subdomain = try(each.value.subdomain, "")
  prio      = try(each.value.priority, null)
  type      = each.value.type
  content   = each.value.content
}

moved {
  from = porkbun_dns_record.records["domain_ownership"]
  to   = porkbun_dns_record.com_michaelweigle_proton_ownership
}

moved {
  from = porkbun_dns_record.records
  to   = porkbun_dns_record.com_michaelweigle_email
}

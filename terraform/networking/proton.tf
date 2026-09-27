locals {
  proton_pass = {
    # domain_ownership = { type = "TXT", content = "pm-verification=swelqyeoqegksuqpuayjlkrtidjdew" }
    mx_1  = { type = "MX", priority = 10, content = "mx1.alias.proton.me" }
    mx_2  = { type = "MX", priority = 20, content = "mx2.alias.proton.me" }
    spf   = { type = "TXT", content = "\"v=spf1 include:alias.proton.me ~all\"" }
    dmarc = { type = "TXT", subdomain = "_dmarc", content = "\"v=DMARC1; p=quarantine; pct=100; adkim=s; aspf=s\"" }
    dkim1 = { type = "CNAME", subdomain = "dkim._domainkey", content = "dkim._domainkey.alias.proton.me" }
    dkim2 = { type = "CNAME", subdomain = "dkim02._domainkey", content = "dkim02._domainkey.alias.proton.me" }
    dkim3 = { type = "CNAME", subdomain = "dkim03._domainkey", content = "dkim03._domainkey.alias.proton.me" }
  }

  proton_mail = {
    mx_1  = { type = "MX", priority = 10, content = "mail.protonmail.ch" }
    mx_2  = { type = "MX", priority = 20, content = "mailsec.protonmail.ch" }
    spf   = { type = "TXT", content = "\"v=spf1 include:_spf.protonmail.ch ~all\"" }
    dmarc = { type = "TXT", subdomain = "_dmarc", content = "\"v=DMARC1; p=quarantine\"" }
    dkim1 = { type = "CNAME", subdomain = "protonmail._domainkey", content = "protonmail.domainkey.dlafe6xxeshuoeyujjpunkgxrky5yzt6hscidvjs2unm7slbzn2yq.domains.proton.ch." }
    dkim2 = { type = "CNAME", subdomain = "protonmail2._domainkey", content = "protonmail2.domainkey.dlafe6xxeshuoeyujjpunkgxrky5yzt6hscidvjs2unm7slbzn2yq.domains.proton.ch." }
    dkim3 = { type = "CNAME", subdomain = "protonmail3._domainkey", content = "protonmail3.domainkey.dlafe6xxeshuoeyujjpunkgxrky5yzt6hscidvjs2unm7slbzn2yq.domains.proton.ch." }
  }
}

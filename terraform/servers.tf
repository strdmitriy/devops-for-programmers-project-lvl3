resource "digitalocean_droplet" "web" {
  count  = 2
  image  = "docker-20-04"
  name   = "web-${count.index + 1}"
  region = "ams3"
  size   = "s-1vcpu-1gb"

  ssh_keys = [
    data.digitalocean_ssh_key.macbook.id
  ]
}

resource "digitalocean_domain" "domain" {
  name = "hexlet.devops-and1.club"
}

resource "digitalocean_record" "static_domain_record" {
  domain = digitalocean_domain.domain.name
  type   = "A"
  name   = "@"
  value  = digitalocean_loadbalancer.loadbalancer.ip
}

resource "digitalocean_certificate" "certification" {
  name    = "certification"
  type    = "lets_encrypt"
  domains = [digitalocean_domain.domain.name]
}

resource "digitalocean_loadbalancer" "loadbalancer" {
  name   = "loadbalancer"
  region = "ams3"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 5000
    target_protocol = "http"
  }


  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 5000
    target_protocol = "http"

    certificate_name = digitalocean_certificate.certification.name
  }

  healthcheck {
    port     = 5000
    protocol = "http"
    path     = "/"
  }

  droplet_ids = digitalocean_droplet.web.*.id
}

resource "datadog_monitor" "http_monitor" {
  name    = "Http Health Check Alert"
  type    = "service check"
  message = "@all"

  query = "\"http.can_connect\".over(\"instance:http_health_check\").by(\"host\",\"instance\",\"url\").last(4).count_by_status()"

  monitor_thresholds {
    warning  = 1
    ok       = 1
    critical = 3
  }

  notify_no_data    = true
  no_data_timeframe = 2
  renotify_interval = 0
  new_group_delay   = 60

  notify_audit = false
  locked       = false

  timeout_h    = 60
  include_tags = true

  priority = 5

  tags = ["dev-project"]
}

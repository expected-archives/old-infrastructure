debug = false
logLevel = "INFO"
defaultEntryPoints = ["http", "https"]

################################################################
# Entrypoints configuration
################################################################

[entryPoints]
  [entryPoints.http]
    address = ":80"
    [entryPoints.http.redirect]
      entryPoint = "https"
  [entryPoints.https]
    address = ":443"
    [entryPoints.https.tls]

[acme]
  email = "${email}"
  storage = "traefik/acme/account"
  entryPoint = "https"
  onHostRule = true
  [acme.httpChallenge]
    entryPoint = "http"

################################################################
# API and dashboard configuration
################################################################

[api]
  dashboard = true

################################################################
# Consul KV Provider
################################################################

[consul]
  endpoint = "127.0.0.1:8500"
  watch = true
  prefix = "traefik"

################################################################
# Consul configuration backend
################################################################

[consulCatalog]
  endpoint = "127.0.0.1:8500"
  exposedByDefault = false
  stale = false
  domain = "${domain}"
  prefix = "traefik"
  frontEndRule = "Host:{{.ServiceName}}.{{.Domain}}"

################################################################
# File configuration backend
################################################################

[file]
  directory = "/etc/traefik/rules"
  watch = true
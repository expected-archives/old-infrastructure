resource "scaleway_security_group" "tools_security_group" {
  name                    = "tools"
  description             = ""
  enable_default_security = false
  stateful                = true
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"
}

resource "scaleway_security_group_rule" "tools_security_rule_ssh" {
  action          = "accept"
  direction       = "inbound"
  ip_range        = "0.0.0.0/0"
  port            = "22"
  protocol        = "TCP"
  security_group  = "${scaleway_security_group.tools_security_group.id}"
}

resource "scaleway_security_group_rule" "tools_security_rule_http" {
  action          = "accept"
  direction       = "inbound"
  ip_range        = "0.0.0.0/0"
  port            = "80"
  protocol        = "TCP"
  security_group  = "${scaleway_security_group.tools_security_group.id}"
}

resource "scaleway_security_group_rule" "tools_security_rule_https" {
  action          = "accept"
  direction       = "inbound"
  ip_range        = "0.0.0.0/0"
  port            = "443"
  protocol        = "TCP"
  security_group  = "${scaleway_security_group.tools_security_group.id}"
}

resource "scaleway_security_group" "worker_security_group" {
  name                    = "worker"
  description             = ""
  enable_default_security = false
  stateful                = true
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"
}

resource "scaleway_security_group_rule" "worker_security_rule_ssh" {
  action          = "accept"
  direction       = "inbound"
  ip_range        = "0.0.0.0/0"
  port            = "22"
  protocol        = "TCP"
  security_group  = "${scaleway_security_group.worker_security_group.id}"
}

resource "scaleway_security_group_rule" "worker_security_rule_http" {
  action          = "accept"
  direction       = "inbound"
  ip_range        = "0.0.0.0/0"
  port            = "80"
  protocol        = "TCP"
  security_group  = "${scaleway_security_group.worker_security_group.id}"
}

resource "scaleway_security_group_rule" "worker_security_rule_https" {
  action          = "accept"
  direction       = "inbound"
  ip_range        = "0.0.0.0/0"
  port            = "443"
  protocol        = "TCP"
  security_group  = "${scaleway_security_group.worker_security_group.id}"
}

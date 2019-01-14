#cloud-config
write_files:
  - content: |
      {
        "datacenter": "${datacenter}",
        "data_dir": "/var/lib/consul",
        "log_level": "INFO",
        "server": true,
        "ui": false,
        "bootstrap_expect": ${bootstrap_expect},
        "retry_join": [
          "provider=scaleway organization=${scaleway_discovery_organization} tag_name=consul-server token=${scaleway_discovery_token} region=${scaleway_discovery_region}"
        ],
        "rejoin_after_leave": true,
        "encrypt": "${encryption_key}",
        "encrypt_verify_incoming": true,
        "encrypt_verify_outgoing": true,
        "acl" : {
          "enabled" : true,
          "default_policy" : "deny",
          "down_policy" : "extend-cache",
          "tokens" : {
            "agent_master" : "${agent_token}"
          }
        }
      }
    path: /etc/consul.d/consul.json
    owner: consul:consul
  - content: |
      {
        "region": "global",
        "datacenter": "${datacenter}",
        "data_dir": "/var/lib/nomad",
        "log_level": "INFO",
        "server": {
          "enabled": true,
          "encrypt": "${encryption_key}",
          "bootstrap_expect": ${bootstrap_expect}
        },
        "consul": {
          "address": "127.0.0.1:8500",
          "server_service_name": "nomad",
          "client_service_name": "nomad-client",
          "auto_advertise": true,
          "server_auto_join": true,
          "client_auto_join": true
        }
      }
    path: /etc/nomad.d/nomad.json
    owner: nomad:nomad
runcmd:
  - systemctl stop docker
  - systemctl disable docker
  - systemctl start consul
  - systemctl enable consul
  - systemctl start nomad
  - systemctl enable nomad

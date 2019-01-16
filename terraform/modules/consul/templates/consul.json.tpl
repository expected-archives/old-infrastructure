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
        "down_policy" : "extend-cache"
    },
    "client_addr": "127.0.0.1",
    "bind_addr": "${private_ip}"
}

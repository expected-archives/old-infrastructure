{
    "region": "global",
    "datacenter": "${datacenter}",
    "data_dir": "/var/lib/nomad",
    "log_level": "INFO",
    "client": {
        "enabled": true
    },
    "consul": {
        "address": "127.0.0.1:8500",
        "server_service_name": "nomad",
        "client_service_name": "nomad-client",
        "auto_advertise": true,
        "server_auto_join": true,
        "client_auto_join": true
    },
    "bind_addr": "${private_ip}"
}

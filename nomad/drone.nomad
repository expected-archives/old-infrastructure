job "drone" {
  datacenters = ["paris"]
  type = "service"

  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = true
    canary = 0
  }

  migrate {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }

  group "drone" {
    count = 1

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    ephemeral_disk {
      size = 300
    }

    task "drone" {
      driver = "docker"

      config {
        image = "drone/drone:1.0.0-rc.3"

        port_map {
          http = 80
        }
      }

      env {
        DRONE_GITHUB_SERVER = "https://github.com"
        DRONE_GITHUB_CLIENT_ID = ""
        DRONE_GITHUB_CLIENT_SECRET = ""
        DRONE_RUNNER_CAPACITY = "2"
        DRONE_SERVER_HOST = "drone.expected.sh"
        DRONE_SERVER_PROTO = "http"
        DRONE_REPOSITORY_FILTER = "expectedsh"
        DRONE_USER_FILTER = "expectedsh"
        DRONE_ADMIN = "remicaumette"
        //DRONE_DATABASE_DRIVER: postgres
        //DRONE_DATABASE_DATASOURCE: postgres://drone:drone@postgres/drone?sslmode=disable
      }

      resources {
        cpu    = 50
        memory = 128

        network {
          mbits = 100

          port "http" {}
        }
      }

      service {
        name = "drone"
        tags = ["traefik.enable=true"]
        port = "http"

        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}

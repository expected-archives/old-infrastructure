# infrastructure

### how it works

![schema](./assets/schema.png)

we have 3 types of nodes:
- master nodes: run main components required by kubernetes and kafka. (they are not exposed to the world)
- kubernetes nodes: run our internal workload
- kafka nodes: our messaging bus required by our services

### pricing

we planning to use for:
- master nodes: 3 x 1-S (1vCPU - 2GB - 50GB - $4) instances on scaleway
- kubernetes nodes: 3 x 1-C2S (4vCPU - 8GB - 50GB - $12) instances on scaleway + 3 volumes of 150GB ($3)
- kafka nodes: 3 x 1-S (1vCPU - 2GB - 50GB - $4) instances on scaleway

total per month: $69


### development pricing

- one master on 1-S ($4)
- three worker on 1-M ($24)

### env

- EMAIL: email de contact
- DOMAIN: le nom de domaine
- GRAFANA_CLIENT_ID: le client id github pour l'auth grafana
- GRAFANA_CLIENT_SECRET: le client secret github pour l'auth grafana
- DRONE_CLIENT_ID: le client id github pour l'auth drone
- DRONE_CLIENT_SECRET: le client secret github pour l'auth drone

### deploy

```
cd ./packer
packer build master.json
cd ../terraform
terraform apply -var "domain=$DOMAIN" -var "master_image=$MASTER_IMAGE" -var "datacenter=$DATACENTER"
```

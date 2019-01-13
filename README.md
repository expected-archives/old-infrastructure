# infrastructure

### how it works

![schema](./assets/schema.png)

### env

- EMAIL: email de contact
- DOMAIN: le nom de domaine
- GRAFANA_CLIENT_ID: le client id github pour l'auth grafana
- GRAFANA_CLIENT_SECRET: le client secret github pour l'auth grafana
- DRONE_CLIENT_ID: le client id github pour l'auth drone
- DRONE_CLIENT_SECRET: le client secret github pour l'auth drone

### deploy

```
cd ./terraform
terraform apply -var "domain=$DOMAIN"
cd ../ansible
ansible-playbook -i inventory cluster.yaml
```

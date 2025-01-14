# Monitoring ![Grafana](https://grafana.com/static/assets/img/fav32.png) 

## _Grafana - Prometheus - Exporters (metrics graphs)_

Grafana (OSS) enables you to query, visualize and explore your metrics, logs, and traces wherever they’re stored. 
We use Prometheus as datasources(time-series databases) for grafana graphs.

Prometheus server scrapes and stores time series data from different exporter services, in our case we use node_exporter to scrape servers metrics like CPU,RAM,DISK,NETWORK.

[Run Prometheus datasource](#prometheus)

[Run Grafana](#grafana)

[Run Node-prometheus-exporter](#node-exporter)

[Run AlertManager](#alertmanager)

## Run all Monitoring services:

connect by ssh to dev and su jenkins user:
```sh
su - jenkins
git clone https://github.com/sha-root/ptapp.git ptapp
cd ptapp/monitoring
docker-compose up -d
```

Grafana with dashboards must be here: http://<VPS_IP>:3000/ 

(Username: 'grafana', Password: 'Grafana!')

## Prometheus

run separate service:

```sh
docker-compose up -d prometheus
```

## Grafana

run separate service:
```sh
docker-compose up -d grafana
```

## Node-exporter

run separate service:
```sh
docker-compose up -d nodeexporter
```

## AlertManager

run separate service:
```sh
docker-compose up -d alertmanager
```

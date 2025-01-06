# Monitoring ![Grafana](https://grafana.com/static/assets/img/fav32.png) 

## _Grafana - Prometheus - Exporters (metrics graphs)_

Grafana (OSS) enables you to query, visualize and explore your metrics, logs, and traces wherever they’re stored. 
We use Prometheus as datasources(time-series databases) for grafana graphs.

Prometheus server scrapes and stores time series data from different exporter services, in our case we use node_exporter to scrape servers metrics like CPU,RAM,DISK,NETWORK.

[Run Prometheus datasource](#Prometheus)
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

## Prometheus

run separate service:

```sh
docker-compose up -d prometheus
```

## Grafana - visualize and explore your metrics

run separate service:
```sh
docker-compose up -d grafana
```

## Node_exporter returns server resources usage metrics for prometheus

run separate service:
```sh
docker-compose up -d nodeexporter
```

## AlertManager

run separate service:
```sh
docker-compose up -d alertmanager
```

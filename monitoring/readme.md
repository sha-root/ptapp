# Monitoring ![Grafana](https://grafana.com/static/assets/img/fav32.png) 

## _Grafana - Prometheus - Exporters (metrics graphs)_

Grafana (OSS) enables you to query, visualize and explore your metrics, logs, and traces wherever they’re stored. 
We use Prometheus as datasources(time-series databases) for grafana graphs.

Prometheus server scrapes and stores time series data from different exporter services, in our case we use node_exporter to scrape servers metrics like CPU,RAM,DISK,NETWORK.

[Run Prometheus datasource](#Prometheus)
[Run Grafana](#grafana)
[Run Node-prometheus-exporter](#node-exporter)


## Prometheus

run service:

```sh
docker-compose up -d prometheus
```

## Grafana - visualize and explore your metrics

run service:
```sh
docker-compose up -d grafana
```

## Node_exporter returns server resources usage metrics for prometheus

run service:
```sh
docker-compose up -d nodeexporter
```

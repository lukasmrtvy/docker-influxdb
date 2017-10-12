# docker-influxdb


`sudo docker rm -f influxdb ;sudo docker run -d --network my-bridge -p 25826:25826/udp --name influxdb --hostname influxdb myinfluxdb`

```curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE collectd"
curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE USER collectd WITH PASSWORD 'collectd' WITH ALL PRIVILEGES"
curl -i -XPOST http://localhost:8086/query --data-urlencode "q=GRANT ALL ON collectd TO collectd"
curl -i -XPOST 'http://localhost:8086/write?db=collectd' --data-binary 'cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000000'```

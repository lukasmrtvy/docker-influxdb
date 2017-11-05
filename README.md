# docker-influxdb

## Info:
Based on Alpine:latest

## Usage:
`sudo docker rm -f influxdb ;sudo docker run -d -e TZ=Europe/Prague --network my-bridge -p 8086:8086 -p 25826:25826/udp --name influxdb --hostname influxdb -v influxdb:/var/lib/influxdb myinfluxdb`

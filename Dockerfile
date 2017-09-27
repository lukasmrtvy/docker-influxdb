FROM alpine:latest

ENV INFLUXDB_VERSION 1.3.4

ENV UID 1000
ENV USER htpc
ENV GROUP htpc

COPY influxdb.conf /tmp/influxdb.custom.conf

RUN addgroup -S ${GROUP} && adduser -D -S -u ${UID} ${USER} ${GROUP} && \
    apk add --no-cache --virtual .build-deps curl  && apk add --no-cache tzdata && \
    mkdir -p /opt/influxdb && curl -sL https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz  | tar xz -C /opt/influxdb --strip-components=2 && \
    curl -sL https://github.com/collectd/collectd/blob/master/src/types.db -o /tmp/types.db  && \
    chmod +x /opt/influxdb/influxd && \
    mkdir -p /var/lib/influxdb && chown -R ${USER}:${GROUP} /var/lib/influxdb && \
    /opt/influxdb/influxd config -config /tmp/influxdb.custom.conf > /tmp/influxdb.conf  && \
    apk del .build-deps

EXPOSE 8086

VOLUME /var/lib/influxdb

LABEL name=influxdb
LABEL url=https://api.github.com/repos/influxdata/influxdb/releases/latest
LABEL version=${INFLUXDB_VERSION}

USER ${USER}

CMD /opt/influxdb/influxd -config /tmp/influxdb.conf

FROM alpine:latest

ENV UID 1000
ENV GID 1000
ENV USER htpc
ENV GROUP htpc

ENV INFLUXDB_VERSION 1.3.4

COPY influxdb_custom.conf /tmp/

RUN addgroup -S ${GROUP} -g ${GID} && adduser -D -S -u ${UID} ${USER} ${GROUP}  && \
    apk add --no-cache --virtual .build-deps curl  && apk add --no-cache tzdata && \
    mkdir -p /opt/influxdb && curl -sL https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz  | tar xz -C /opt/influxdb --strip-components=2 && \
    chmod +x /opt/influxdb/influxd && \
    mkdir -p /var/lib/influxdb  && \
    curl -sL https://github.com/collectd/collectd/blob/master/src/types.db -o /var/lib/influxdb/types.db  && \
    /opt/influxdb/influxd config -config /tmp/influxdb_custom.conf > /var/lib/influxdb/influxdb.conf && \
    chown -R ${USER}:${GROUP} /var/lib/influxdb && \
    apk del .build-deps 
    # && \ rm -rf /tmp/*

EXPOSE 8086

VOLUME /var/lib/influxdb/

LABEL url=https://api.github.com/repos/influxdata/influxdb/releases/latest
LABEL version=${INFLUXDB_VERSION}

USER ${USER}

CMD /opt/influxdb/influxd -config /var/lib/influxdb/influxdb.conf

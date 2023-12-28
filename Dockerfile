FROM alpine:latest as build

RUN \
 echo "***** install go ****" && \
 apk add go git make && \
 echo "***** install boringtun via cargo ****" && \
 git clone https://git.zx2c4.com/wireguard-go
WORKDIR /wireguard-go
RUN make

FROM alpine:latest

# add local files
COPY --from=build /wireguard-go/wireguard-go /data/wireguard-go
COPY scripts/healthcheck.sh /data/healthcheck.sh
COPY scripts/wireguard.sh /data/wireguard.sh

RUN \
 echo "***** install ip mgmt tools *****" && \
 apk add --no-cache wireguard-tools iproute2 libgcc && \
 echo "**** cleanup ****" && \
 rm -rf /tmp/* /var/tmp/*

# ports, volumes, env, etc
ENV WG_SUDO=1
HEALTHCHECK --interval=15m --timeout=30s CMD /bin/bash /data/healthcheck.sh
ENTRYPOINT ["/bin/bash", "/data/wireguard.sh"]

ARG CRYMAP_VERSION

FROM rust:1-alpine AS builder

RUN apk -U add musl-dev openssl-dev openssl-libs-static
RUN apk upgrade

ARG CRYMAP_VERSION
RUN cargo install crymap --locked --version ${CRYMAP_VERSION}

FROM alpine

RUN mkdir -p /etc/crymap/users && chown mail:mail /etc/crymap/users
COPY config/logging.toml /etc/crymap/
COPY config/inetd*.conf /etc/

# install inetd
RUN apk --no-cache add busybox-extras

COPY --from=builder /usr/local/cargo/bin/crymap /usr/local/bin/crymap

USER mail:mail
VOLUME /etc/crymap/users
ENTRYPOINT ["/usr/sbin/inetd", "-f", "-e"]
CMD ["/etc/inetd4.conf"]

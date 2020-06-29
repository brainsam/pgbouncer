FROM alpine:3.12 AS build_stage

ARG PGBOUNCER_VERSION=1.12.0
WORKDIR /
RUN apk --update add build-base automake libtool m4 autoconf libevent-dev openssl-dev c-ares-dev
RUN wget https://github.com/pgbouncer/pgbouncer/releases/download/pgbouncer_1_14_0/pgbouncer-1.14.0.tar.gz \
  && tar zxf pgbouncer-1.14.0.tar.gz && rm pgbouncer-1.14.0.tar.gz \
  && cd /pgbouncer-1.14.0/ \
  && ./configure --prefix=/pgbouncer \
  && make \
  && make install


WORKDIR /bin
RUN ln -s ../usr/bin/rst2man.py rst2man

FROM alpine:3.12
RUN apk --update add libevent openssl c-ares
WORKDIR /
COPY --from=build_stage /pgbouncer /pgbouncer
ADD entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]

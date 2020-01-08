FROM alpine:3.11.2 AS build_stage

WORKDIR /
RUN apk --update add python py-pip build-base automake libtool m4 autoconf libevent-dev openssl-dev c-ares-dev
RUN pip install docutils \
  && wget https://github.com/pgbouncer/pgbouncer/releases/download/pgbouncer_1_12_0/pgbouncer-1.12.0.tar.gz \
  && tar zxf pgbouncer-1.12.0.tar.gz && rm pgbouncer-1.12.0.tar.gz \
  && cd /pgbouncer-1.12.0/ \
  && ./configure --prefix=/pgbouncer \
  && make \
  && make install

WORKDIR /bin
RUN ln -s ../usr/bin/rst2man.py rst2man

FROM alpine:3.11.2
RUN apk --update add libevent openssl c-ares
WORKDIR /
COPY --from=build_stage /pgbouncer /pgbouncer
ADD entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]

FROM alpine:3.15 AS build_stage

WORKDIR /
RUN apk --update add python3 py3-pip build-base automake libtool m4 autoconf libevent-dev openssl-dev c-ares-dev
RUN pip install docutils \
  && wget https://github.com/pgbouncer/pgbouncer/releases/download/pgbouncer_1_16_1/pgbouncer-1.16.1.tar.gz \
  && tar zxf pgbouncer-1.16.1.tar.gz && rm pgbouncer-1.16.1.tar.gz \
  && cd /pgbouncer-1.16.1/ \
  && ./configure --prefix=/pgbouncer \
  && make \
  && make install

WORKDIR /bin
RUN ln -s ../usr/bin/rst2man.py rst2man

FROM alpine:3.15
RUN apk --update add libevent openssl c-ares
WORKDIR /
COPY --from=build_stage /pgbouncer /pgbouncer
ADD entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]

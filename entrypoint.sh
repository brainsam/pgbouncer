#!/bin/sh

PG_LOG=/var/log/pgbouncer/
PG_CONFIG=/etc/pgbouncer/pgbouncer.ini
PG_USER=postgres

adduser ${PG_USER}
mkdir -p ${PG_LOG}
chmod -R 755 ${PG_LOG}
chown -R ${PG_USER}:${PG_USER} ${PG_LOG}

echo "Starting pgbouncer..."
exec pgbouncer -v -u ${PG_USER} $PG_CONFIG

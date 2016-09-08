#!/bin/sh
# Here are some parameters. See all on
# https://pgbouncer.github.io/config.html

# PGBOUNCER_USER=postgres

# Specifies list of addresses, where to listen for TCP connections.
#You may also use * meaning “listen on all addresses”.
#When not set, only Unix socket connections are allowed.
# PGBOUNCER_PORT=6432

# PGBOUNCER_LISTEN_ADDR=0.0.0.0 #

# How to authenticate users.
# AUTH_TYPE=any

# Specifies when a server connection can be reused by other clients.
# POOL_MODE=session

# Maximum number of client connections allowed.
# MAX_CLIENT_CONN=10000

# How many server connections to allow per user/database pair.
# Can be overridden in the per-database configuration.
# DEFAULT_POOL_SIZE=20

# Add more server connections to pool if below this number.
# Improves behaviour when usual load comes suddenly back
# after period of total inactivity.
# MIN_POOL_SIZE=0

# How many additional connections to allow to a pool. 0 disables.
# RESERVE_POOL_SIZE=0

# Do not allow more than this many connections per-database
# (regardless of pool - i.e. user). It should be noted that when you hit
# the limit, closing a client connection to one pool will not immediately
# allow a server connection to be established for another pool, because
# the server connection for the first pool is still open. Once the server
# connection closes (due to idle timeout), a new server connection will
# immediately be opened for the waiting pool.
# MAX_DB_CONNECTIONS=10000

# By default, pgbouncer reuses server connections in LIFO (last-in, first-out)
# manner, so that few connections get the most load. This gives best
# performance if you have a single server serving a database.
# But if there is TCP round-robin behind a database IP, then it is better if
# pgbouncer also uses connections in that manner, thus achieving uniform load.
# SERVER_ROUND_ROBIN=0

# How long to keep released connections available for immediate re-use, without
# running sanity-check queries on it. If 0 then the query is ran always.
# SERVER_CHECK_DELAY=5

# DB_HOST=""
# DB_PORT=5432
# DB_USER=postgres

PG_LOG=/var/log/pgbouncer
PG_CONFIG_DIR=/etc/pgbouncer
PG_USER=postgres

if [ ! -f ${PG_CONFIG_DIR}/pgbouncer.ini ]; then
  echo "create pgbouncer config in ${PG_CONFIG_DIR}"
  mkdir -p ${PG_CONFIG_DIR}

  echo "[databases]
  * = host=${DB_HOST:?"Setup pgbouncer config error! \
        You must set DB_HOST env"} \
  port=${DB_PORT:-5432} \
  user=${DB_USER:-postgres} \
  ${DB_PASSWORD:+password=${DB_PASSWORD}}

  [pgbouncer]
  listen_port = ${PGBOUNCER_PORT:-6432}
  listen_addr = ${PGBOUNCER_LISTEN_ADDR:-0.0.0.0}
  auth_type   = ${AUTH_TYPE:-any}
  ignore_startup_parameters = extra_float_digits

  pool_mode = ${POOL_MODE:-session}
  max_client_conn = ${MAX_CLIENT_CONN:-10000}
  default_pool_size = ${DEFAULT_POOL_SIZE:-80}
  server_idle_timeout = ${SERVER_IDLE_TIMEOUT:-10}
  autodb_idle_timeout = ${AUTODB_IDLE_TRANSACTION:-10}
  admin_users=postgres\
  " > ${PG_CONFIG_DIR}/pgbouncer.ini
fi

adduser ${PG_USER}
mkdir -p ${PG_LOG}
chmod -R 755 ${PG_LOG}
chown -R ${PG_USER}:${PG_USER} ${PG_LOG}

echo "Starting pgbouncer..."
exec pgbouncer -v -u ${PG_USER} ${PG_CONFIG_DIR}/pgbouncer.ini

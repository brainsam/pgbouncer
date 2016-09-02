## Synopsis

*pgbouncer* is a popular, small connection pooler for Postgresql. This is yet another docker image with pgbouncer, based on alpine.

At the top of the file there should be a short introduction and/ or overview that explains **what** the project is. This description should match descriptions added for package managers (Gemspec, package.json, etc.)

## Code Example
```bash
$ docker run -d \
 --name=pgbouncer \
 -e DB_HOST=postgresql.example.com \
 -e DB_USER=postgres \
 -e DB_PASSWORD=mypassword \
 -e DB
 brainsam/pgbouncer:latest
```

## Motivation

This image is stateless, and configurable by environment variables. The list of parameters not contains all allowed by maintainer, only most usual, IMHO.

## Installation

```bash
$ docker pull braisam/pgbouncer:latest
```
## Environment variables

**DB_HOST** = {not set, required}
**DB_PORT** = 6432
**DB_USER** = postgres
**DB_PASSWORD** = {not set, mandatory}
**PGBOUNCER_PORT** = 6432
**PGBOUNCER_LISTEN_ADDR** = 0.0.0.0
**AUTH_TYPE** = any
**POOL_MODE** = session
**MAX_CLIENT_CONN** = 10000
**DEFAULT_POOL_SIZE** = 80
**SERVER_IDLE_TIMEOUT** = 10
**AUTODB_IDLE_TRANSACTION** = 10

####Troubleshooting

```
docker logs <your-pgbouncer-container-name>
```
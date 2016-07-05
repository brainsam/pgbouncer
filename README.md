# brainsam/pgbouncer

Pretty small (based on Alpine Linux) docker container, which uses version of pgbouncer from [pgbouncer repo](https://github.com/pgbouncer/pgbouncer) master branch.

####Usage:
```
docker run  --name pgbouncer  \
  -v /path/to/your/pgbouncer.ini:/etc/pgbouncer/pgbouncer.ini \
  brainsam/pgbouncer:latest
```
####Environment Variables
```
PG_LOG=/var/log/pgbouncer/ - log directory (if needed)
PG_CONFIG=/etc/pgbouncer/pgbouncer.ini - config directory
PG_USER=postgres
```
####Troubleshooting

```
docker logs <your-pgbouncer-container-name>
```

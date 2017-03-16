## Synopsis

**pgbouncer** is a popular, small connection pooler for Postgresql. This is yet another docker image with pgbouncer, based on alpine.

## Code Example
You can configure it by Environment variables:
```bash
$ docker run -d \
 --name=pgbouncer \
 -e DB_HOST=postgresql.example.com \
 -e DB_USER=admin \
 -e DB_PASSWORD=mypassword \
 brainsam/pgbouncer:latest
```
Or You can mount config file into docker container:
```bash
$ docker run -d \
 --name pgbouncer \
 -v pgbouncer-config-file:/etc/pgbouncer/pgbouncer.ini \
 brainsam/pgbouncer:latest
```
## Building

A simple makefile is provided which can be used to build and push an image.. just note this is a MANUAL process right now..there is NO automation.  The details of the registry/tagging are captured in that file.  The one thing to note is that versioning is manual, so to push a new version, the version file must have its contents updated in a text editor. :-(.

To build:
`make build`

To publish:
`make push`

If this container starts changing a lot, we will automate all of this stuff.


## Installation

```bash
$ docker pull brainsam/pgbouncer:latest
```
## Configuration

All configuration parameters of pgbouncer are available both by *--env* (use the same keys in upper case) and by mounting pgbouncer.ini into container.

#### Troubleshooting

```
docker logs <your-pgbouncer-container-name>
```

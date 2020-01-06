# docker-monit
A container running [monit](https://mmonit.com/monit/) for the purpose
of monitoring other containers.

# Usage

## docker

```
docker create \
  --name=monit \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e MMONIT_URL="https://USERID:PASSWORD@mmonit.your.domain:2812/collector"
  --expose 2812 \
  -v </path/to/appdata/config>:/config \
  --restart unless-stopped \
  jchonig/monit
```

### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  monit:
    image: jchonig/monit
    container_name: monit
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - MMONIT_URL="https://USERID:PASSWORD@mmonit.your.domain:2812/collector"
    volumes:
      - </path/to/appdata/config>:/config
    expose:
      - 2812
    restart: unless-stopped
```

# Parameters

## Ports (--expose)

| Volume | Function                                                   |
| ------ | --------                                                   |
| 2812   | Used by M/Monit to communicate with this instance of Monit |

XXX - Security

## Environment Variables (-e)

| Env        | Function                                |
| ---        | --------                                |
| PUID=1000  | for UserID - see below for explanation  |
| PGID=1000  | for GroupID - see below for explanation |
| TZ=UTC     | Specify a timezone to use EG UTC        |
| MMONIT_URL | URL used to communicate with M/Monit    |

## Volume Mappings (-v)

| Volume  | Function                         |
| ------  | --------                         |
| /config | All the config files reside here |

# Application Setup

XXX - Write me
## Local port

If the file `config/monit.d/http` is not present on startup, this file
will be created with the following content

```
set httpd port 2812
    allow localhost
    allow ${NETWORK}/${NETMASK}
```

Where `NETWORK` and `NETMASK` are those of the container.

## M/Monit connection

If the environment variable `MMONIT_URL` is defined, the file
`config/monit.d/mmonit` is created with the following content:

```
set monit ${MMONIT_URL}
```

## TODO

  * [ ] Document variables
  * [ ] Document configuration




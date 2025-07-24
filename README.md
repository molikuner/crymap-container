# crymap-container
Containerized Release of https://github.com/AltSysrq/crymap

## Usage

### Prerequisites

 * a crymap config as described in [the official crymap documentation](https://altsysrq.github.io/crymap/admin-guide/config.html).
 * a TLS certificate (e.g. from [Let's Encrypt](https://letsencrypt.org/))
 * a secure place to save the user data (and keep it backed up regularly)

### Simplified Example

```shell
docker run \ # or `podman` or what ever other container runtime you like
  -p 25:25 -p 465:465 -p 587:587 -p 993:993 \ # these ports need to be publicly available
  -v /path/to/user/data:/etc/crymap/users \ # mount the user data
  -v /path/to/crymap.toml:/etc/crymap/crymap.toml \ # mount your config
  -v /path/to/privkey.pem:/config/path/to/privkey.pem \ # mount pivkey (make sure to adjust path as in your config)
  -v /path/to/fullchain.pem:/config/path/to/fullchain.pem \ # mount fullchein (make sure to adjust path as in your config)
  ghcr.io/molikuner/crymap-container:latest
```

### Logs

The container is configured by default to log to stdout. If that needs to be adjusted, please refer to the official [documentation to setup logging](https://altsysrq.github.io/crymap/admin-guide/config.html#logging).

### IPv6

By default the container only binds IPv4 ports. If host networking is used or the container runtime supports IPv6, simply use the `/etc/inetd46.conf` to bind to IPv4 and IPv6 addresses.

```shell
docker run <...> ghcr.io/molikuner/crymap-container:latest /etc/inetd46.conf
```

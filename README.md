
# undergrid/bicbucstriim
A container hosting [BicBucStriim](http://projekte.textmulch.de/bicbucstriim/) 1.5 using [Alpine Linux](https://alpinelinux.org/) 3.7, [Apache](https://www.apache.org/) 2.4 and PHP 7.  

## Usage
```
docker create \
        --name bicbucstriim \
        -p 80:80 \
        -p 443:443 \
        -e PUID=<UID> \
        -e PGID=<GID> \
        -e TZ=<timezone> \
        -v /etc/localtime:/etc/localtime:ro \
        -v </path/to/config>:/config \
        -v </path/to/books>:/books:ro \
        undergrid/bicbucstriim
```

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side.

For example the option  `-p external:internal` defines a port mapping from internal to external of the container.  So `-p 8080:80` would expose port 80 from inside the container to be accessible from the host's IP on port 8080.  Accessing the server on http://192.168.x.x:8080 (replacing 192.168.x.x with your own IP address or fully qualified domain name) would show you what's running INSIDE the container on port 80.

* `-p 80` - the non-ssl port
* `-p 443` - the ssl port
* `-v /config` - container configuration
* `-v /books` - the directory containing the calibre library
* `-v /etc/localtime` for timesync - see [Localtime](#localtime) for important information
* `-e TZ` for timezone information, Europe/London - see [Localtime](#localtime) for important information
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation

It is based on Alpine Linux with S6 overlay.

## Localtime

It is important that you either set `-v /etc/localtime:/etc/localtime:ro` or the TZ variable.

## User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" <sup>TM</sup>.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```


## Setting up bicbucstriim

With a browser, open `https://<your-host>:<ssl-port>` where `<your-host>` is the domain name or IP address where you are hosting the container, and `<ssl-port>` is the ssl port you assigned on creation of the container.  Alternatively use `http://<your-host>:<non-ssl-port>`.

Log in with the following credentials:

 - Username: admin
 - Password: admin

In the configuration page, set the "Calibre library path" to `/books/`.  Other settings can be configured as you prefer.

### Email Settings
Please note that this container does not support the 'PHP Mail' or 'Sendmail' options for sending email.  If you wish to enable 'Allow Send-To-Kindle?' your **must** select 'SMTP' for sending mail and configure the SMTP settings.

## Info
Monitor the logs of the container in realtime `docker logs -f apache-webdav`.

## Versions

+ **06.02.19:** BicBucStriim version 1.5
+ **19.03.18:** Initial Release - BicBucStriim version 1.4.2a


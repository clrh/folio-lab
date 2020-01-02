# Vagrant box

## Install it

https://app.vagrantup.com/folio

```
# Take a box, download and launch it
vagrant init folio/snapshot-core
vagrant up

```

## Use it

=> http://localhost:3000/

```
vagrant ssh
```

## Understand it

### Fichiers

```
Okapi install /usr/share/folio/okapi
Conf files/etc/folio/okapi
Logs files/var/log/folio/okapi
Confs /etc/folio
```

### Stripes logs

Logs stripes:

```bash
docker logs stripes_stripes_1 --follow
```

### Module logs

Backend modules on the prebuilt boxes are deployed by Okapi as Docker containers. To view the logs:

* Log into the box using vagrant ssh.
* Get the container name of the module you want to check with docker ps.
* Look at the log with docker logs <container_name>. You can follow the log by adding the --follow parameter to the docker logs command.

## Upgrade it

```bash
#!/bin/bash

vagrant destroy -f
vagrant box update 
vagrant up
```

* 
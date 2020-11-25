# share-oc

`share-oc` is a set of tools that allows you to download and run lua scripts on OpenComputers server using networking card.

## Warning!

For local ips (and private subnet ones) you must remove them from OpenComputers' configuration file first. Navigate to `$MINECRAFT/config/opencomputers/settings.conf` and find `internet { blacklist=[...] }`. Remove required mask from this array.

## Running on local server/on remote server

You must have either public ip or running server locally (but first see warning).

It is basically easy. Run `serve.sh` with specifying backend.

Then use given ip address as address for `wget`.

## Running on remote server using ssh port forwarding

See warning first.

First, the server ssh daemon must allow `PortForwarding` option. Run `serve.sh` and then look for address.

```sh
serve.sh
# Running on 127.0.0.1:50000...
```

After that connect to ssh daemon like this way.

```sh
ssh -R 127.0.0.1:50000:50000 -T remote_user@remote_hostname '/bin/sh -c "echo Port forwarding...; read; exit 0;"'
```

Then, on minecraft server, run on your machine:

```sh
wget http://127.0.0.1:50000
# or any path, but check if serve.sh allows you doing that.
```

## Running on remote server other way

If you need this, there is a bunch of ways doing that. If you're looking for these, I bet you know how to implement this.


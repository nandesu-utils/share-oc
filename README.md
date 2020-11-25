# share-oc

`share-oc` is a set of tools that allows you to download and run lua scripts on OpenComputers server using networking card.

## Running on local server

It is basically easy. Run `serve.sh` specifying sharing directory, and the address will be printed out into standard output. That address should be used to download instance.

## Running on remote server using ssh

First, the server ssh daemon must allow `PortForwarding` option. Run `serve.sh` and then look for address.

```sh
serve.sh
# Running on 127.0.0.1:53436...
```

After that connect to ssh daemon like this way.

```sh
ssh -R 127.0.0.1:53436:50000 -T remote_user@remote_hostname '/bin/sh -c "echo Port forwarding...; read; exit 0;"'
```

Then, on minecraft server, run on your machine:

```sh
wget http://127.0.0.1:50000
# or any path, but check if serve.sh allows you doing that.
```

## Running on remote server other way

If you need this, there is a bunch of ways doing that. If you're looking for these, I bet you know how to implement this.


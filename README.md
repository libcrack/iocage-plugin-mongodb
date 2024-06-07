## Iocage plugin mongodb

This service provides a mongo server and nothing more!

## Create the plugin

Using a description local JSON file:

```sh
iocage fetch --plugin-name mongodb.json --name mongodb vnet=On dhcp=On nat=Off
```

Through the Internet:

```sh
iocage fetch --plugin-name mongodb --git_repository https://github.com/libcrack/iocage-plugin-index --branch mongodb --name mongodb vnet=On dhcp=On nat=Off
```

### Clean-up after testing

```sh
iocage destroy --recursive mongodb
```

### Login to a MongoDB shell from the host

```sh
iocage exec mongodb bash -c 'whoami'
```


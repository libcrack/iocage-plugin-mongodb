## Iocage plugin mongodb

This service provides a mongo server and nothing more!

## Create the plugin

```sh
iocage fetch --plugin-name "mongodb" --git_repository https://github.com/libcrack/iocage-plugin-index --branch mongodb --name mongodb vnet=On dhcp=On nat=Off
```

### Clean-up after testing

```sh
iocage destroy --recursive mongodb
```

## Use the server from the host

### Login to a MongoDB shell from the host

```sh
iocage exec mongodb bash -c 'PASS=$(</root/mysqlrootpassword); mysql -u root -p"${PASS}"'
```

### Execude SQL from the host shell

```sh
iocage exec mongodb bash -c 'PASS=$(</root/mysqlrootpassword); mysql -u root -p"${PASS}" -e "SHOW DATABASES"'
```

or

```sh
iocage exec mongodb bash -c 'PASS=$(\</root/mysqlrootpassword); mysql -u root -p"${PASS}"' << EOF
SHOW DATABASES;
USE MYSQL;
SHOW TABLES;
EOF
```

## Connect the server to an other jail

```sh
set jail_name=mongodb
set socket=`zfs list -o mountpoint | grep "iocage/.*${jail_name}/root" | head -n 1`/var/run/mysql

iocage exec second_jail mkdir /var/run/mysql
iocage fstab -a second_jail $socket /var/run/mysql nullfs ro 0 0
```

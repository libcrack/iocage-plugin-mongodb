#!/bin/sh

# Enable SSH
sysrc sshd_enable="YES"

# Enable SSH root login
sed -e 's|#PermitRootLogin no|PermitRootLogin yes|g' -i '' /etc/ssh/sshd_config

# Start SSH daemon
if $(service sshd start 2>/dev/null >/dev/null) ; then
    echo "Starting SSH server."
fi

# Configure remote SSH
mkdir /root/.ssh
touch /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# Enable MongoDB
sysrc mongod_enable="YES"
# sysrc mongod_pidfile=/var/db/mongodb/mongod.pid
# sysrc mongod_pidfile=/var/db/mongodb/mongod.lock

mkdir /var/log/mongod
chown -R mongodb:mongodb /var/log/mongod

# Set MongoDB listening IP
sed -e 's|127.0.0.1|0.0.0.0|g' -i '' /usr/local/etc/mongodb.conf

# Start MongoDB daemon
if $(service mongod start 2>/dev/null >/dev/null) ; then
    echo "Starting MongoBD server."
fi


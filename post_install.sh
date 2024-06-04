#!/usr/local/bin/bash

# Enable SSH
sysrc sshd_enable="YES"

# Enable SSH root login
sed -e 's|#PermitRootLogin no|PermitRootLogin yes|g' -i '' /etc/ssh/sshd_config

echo "Start SSH server"
service sshd start

# Configure remote SSH
mkdir /root/.ssh
touch /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# Enable MongoDB
sysrc mongod_enable="YES"
sysrc mongod_pidfile=/var/db/mongodb/mongod.pid

mkdir /var/log/mongod
chown mongodb /var/log/mongod

CFG_FILE="/usr/local/etc/mongodb.conf"

mv ${CFG_FILE} ${CFG_FILE}.orig
mv ${CFG_FILE}.template ${CFG_FILE}

echo "Start mongoDB server"
service mongod start

# MYUSER="root"
# (cat /dev/urandom | strings | tr -dc A-Za-z0-9\?\!\.\#\(\)\-\_ | head -c32; echo) > /root/mysqlrootpassword
# PASS=$(</root/mysqlrootpassword)
#
# # set mysql-password
# mysqladmin --user=$MYUSER password "$PASS"
# echo "MySQL passwort set to $PASS"
#
# # Configure mysql
# mysql -u $MYUSER -p"${PASS}" << EOF
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${PASS}';
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
# FLUSH PRIVILEGES;
# DROP DATABASE IF EXISTS test;
# EOF


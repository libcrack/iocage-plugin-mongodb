#!/bin/sh

get_port()
{
    while [ $# -gt 0 ]
    do
        if [ "$1" = "-p" ] ; then
            shift
            port="$1"
            break
        fi
        shift
    done
    if [ -z "$port" ] ; then
        port="27017"
    fi
    echo "$port"
}

# Stub for something which gets quasselsettings
case $1 in
    port)     serviceflags=`sysrc -n -f /etc/rc.conf mongod_port`
         get_port $serviceflags ;;
    *) echo "Unknown option" ;;
esac

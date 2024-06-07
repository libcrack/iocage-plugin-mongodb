#!/bin/sh

set_port()
{
    newargs=""
    while [ $# -gt 0 ]
    do
        if [ "$1" = "-p" ] ; then
            shift
            shift
            continue
        fi
        newargs="$newargs $1"
        shift
    done
    newargs="$newargs -p $NEWPORT"
    sysrc -f /etc/rc.conf mongod_args="$newargs"
    exit 0
}

# Stub for something which sets mongodbsettings
case $1 in
    port)     serviceflags=`sysrc -n -f /etc/rc.conf mongod_port`
        NEWPORT="$2"
         set_port $serviceflags ;;
    *) echo "Unknown option" ;;
esac


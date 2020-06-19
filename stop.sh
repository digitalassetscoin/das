#!/bin/sh
if [ -e ~/.das/das.pid ]; then
    PID=`cat ~/.das/das.pid`
    ps -p $PID > /dev/null
    STATUS=$?
    echo "stopping"
    while [ $STATUS -eq 0 ]; do
        kill `cat ~/.das/das.pid` > /dev/null
        sleep 5
        ps -p $PID > /dev/null
        STATUS=$?
    done
    rm -f ~/.das/das.pid
    echo "Das server stopped"
fi


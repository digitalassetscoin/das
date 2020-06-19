#!/bin/sh
if [ -e ~/.das/das.pid ]; then
    PID=`cat ~/.das/das.pid`
    ps -p $PID > /dev/null
    STATUS=$?
    if [ $STATUS -eq 0 ]; then
        echo "Das server already running"
        exit 1
    fi
fi
mkdir -p ~/.das/
DIR=`dirname "$0"`
cd "${DIR}"
if [ -x jre/bin/java ]; then
    JAVA=./jre/bin/java
else
    JAVA=java
fi
nohup ${JAVA} -cp classes:lib/*:conf:addons/classes:addons/lib/* -Ddas.runtime.mode=server das.Das > /dev/null 2>&1 &
echo $! > ~/.das/das.pid
cd - > /dev/null

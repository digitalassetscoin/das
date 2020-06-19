#!/bin/sh
if [ -x jre/bin/java ]; then
    JAVA=./jre/bin/java
else
    JAVA=java
fi
${JAVA} -cp classes:lib/*:conf:addons/classes:addons/lib/* -Ddas.runtime.mode=desktop -Ddas.runtime.dirProvider=das.env.DefaultDirProvider das.Das

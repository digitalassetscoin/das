#!/bin/sh
CP=conf/:classes/:lib/*:testlib/*
SP=src/java/:test/java/

if [ $# -eq 0 ]; then
TESTS="das.crypto.Curve25519Test das.crypto.ReedSolomonTest das.peer.HallmarkTest das.TokenTest das.FakeForgingTest
das.FastForgingTest das.ManualForgingTest"
else
TESTS=$@
fi

/bin/rm -f das.jar
/bin/rm -rf classes
/bin/mkdir -p classes/

javac -encoding utf8 -sourcepath ${SP} -classpath ${CP} -d classes/ src/java/das/*.java src/java/das/*/*.java test/java/das/*.java test/java/das/*/*.java || exit 1

for TEST in ${TESTS} ; do
java -classpath ${CP} org.junit.runner.JUnitCore ${TEST} ;
done




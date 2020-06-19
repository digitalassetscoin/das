#!/bin/sh
CP="conf/;classes/;lib/*;testlib/*"
SP="src/java/;test/java/"
TESTS="das.crypto.Curve25519Test das.crypto.ReedSolomonTest"

/bin/rm -f das.jar
/bin/rm -rf classes
/bin/mkdir -p classes/

javac -encoding utf8 -sourcepath $SP -classpath $CP -d classes/ src/java/das/*.java src/java/das/*/*.java test/java/das/*/*.java || exit 1

java -classpath $CP org.junit.runner.JUnitCore $TESTS


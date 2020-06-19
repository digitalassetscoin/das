#!/bin/sh
java -cp "classes:lib/*:conf" das.tools.SignTransactionJSON $@
exit $?

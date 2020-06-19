#!/bin/bash

PATHSEP=":" 
if [[ $OSTYPE == "cygwin" ]] ; then
PATHSEP=";" 
fi

java -cp "classes${PATHSEP}lib/*${PATHSEP}conf" das.tools.ConstantsExporter html/www/js/data/constants.js



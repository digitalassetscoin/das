#!/bin/sh
CP="lib/*:classes"
SP=src/java/

/bin/rm -f das.jar
/bin/rm -f dasservice.jar
/bin/rm -rf classes
/bin/mkdir -p classes/
/bin/rm -rf addons/classes
/bin/mkdir -p addons/classes/

echo "compiling das core..."
find src/java/das/ -name "*.java" > sources.tmp
javac -encoding utf8 -sourcepath "${SP}" -classpath "${CP}" -d classes/ @sources.tmp || exit 1
echo "das core class files compiled successfully"

echo "compiling das desktop..."
find src/java/dasdesktop/ -name "*.java" > sources.tmp
javac -encoding utf8 -sourcepath "${SP}" -classpath "${CP}" -d classes/ @sources.tmp
if [ $? -eq 0 ]; then
    echo "das desktop class files compiled successfully"
else
    echo "if javafx is not supported, das desktop compile errors are safe to ignore, but desktop wallet will not be available"
fi

rm -f sources.tmp

find addons/src/ -name "*.java" > addons.tmp
if [ -s addons.tmp ]; then
    echo "compiling add-ons..."
    javac -encoding utf8 -sourcepath "${SP}:addons/src" -classpath "${CP}:addons/classes:addons/lib/*" -d addons/classes @addons.tmp || exit 1
    echo "add-ons compiled successfully"
    rm -f addons.tmp
else
    echo "no add-ons to compile"
    rm -f addons.tmp
fi

echo "compilation done"

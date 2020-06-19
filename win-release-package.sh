#!/bin/bash
VERSION=$1
if [ -x ${VERSION} ];
then
	echo VERSION not defined
	exit 1
fi
PACKAGE=das-client-${VERSION}
echo PACKAGE="${PACKAGE}"
CHANGELOG=das-client-${VERSION}.changelog.txt
OBFUSCATE=$2

FILES="changelogs conf html lib resource contrib logs"
FILES="${FILES} das.exe dasservice.exe"
FILES="${FILES} 3RD-PARTY-LICENSES.txt AUTHORS.txt LICENSE.txt"
FILES="${FILES} DEVELOPERS-GUIDE.md OPERATORS-GUIDE.md README.md README.txt USERS-GUIDE.md"
FILES="${FILES} mint.bat mint.sh run.bat run.sh run-tor.sh run-desktop.sh start.sh stop.sh compact.sh compact.bat sign.sh"
FILES="${FILES} das.policy dasdesktop.policy DAS_Wallet.url Dockerfile"

# unix2dos *.bat
echo compile
./win-compile.sh
rm -rf html/doc/*
rm -rf das
rm -rf ${PACKAGE}.jar
rm -rf ${PACKAGE}.exe
rm -rf ${PACKAGE}.zip
mkdir -p das/
mkdir -p das/logs
mkdir -p das/addons/src

if [ "${OBFUSCATE}" == "obfuscate" ];
then
echo obfuscate
proguard.bat @das.pro
mv ../das.map ../das.map.${VERSION}
mkdir -p das/src/
else
FILES="${FILES} classes src COPYING.txt"
FILES="${FILES} compile.sh javadoc.sh jar.sh package.sh"
FILES="${FILES} win-compile.sh win-javadoc.sh win-package.sh"
echo javadoc
./win-javadoc.sh
fi
echo copy resources
cp installer/lib/JavaExe.exe das.exe
cp installer/lib/JavaExe.exe dasservice.exe
cp -a ${FILES} das
cp -a logs/placeholder.txt das/logs
echo gzip
for f in `find das/html -name *.gz`
do
	rm -f "$f"
done
for f in `find das/html -name *.html -o -name *.js -o -name *.css -o -name *.json  -o -name *.ttf -o -name *.svg -o -name *.otf`
do
	gzip -9c "$f" > "$f".gz
done
cd das
echo generate jar files
../jar.sh
echo package installer Jar
../installer/build-installer.sh ../${PACKAGE}
echo create installer exe
../installer/build-exe.bat ${PACKAGE}
echo create installer zip
cd -
zip -q -X -r ${PACKAGE}.zip das -x \*/.idea/\* \*/.gitignore \*/.git/\* \*.iml das/conf/das.properties das/conf/logging.properties das/conf/localstorage/\*
rm -rf das

echo creating change log ${CHANGELOG}
echo -e "Release $1\n" > ${CHANGELOG}
echo -e "https://bitbucket.org/JeanLucPicard/das/downloads/${PACKAGE}.exe\n" >> ${CHANGELOG}
echo -e "sha256:\n" >> ${CHANGELOG}
sha256sum ${PACKAGE}.exe >> ${CHANGELOG}

echo -e "https://bitbucket.org/JeanLucPicard/das/downloads/${PACKAGE}.jar\n" >> ${CHANGELOG}
echo -e "sha256:\n" >> ${CHANGELOG}
sha256sum ${PACKAGE}.jar >> ${CHANGELOG}

if [ "${OBFUSCATE}" == "obfuscate" ];
then
echo -e "\n\nThis is an experimental release for testing only. Source code is not provided." >> ${CHANGELOG}
fi
echo -e "\n\nChange log:\n" >> ${CHANGELOG}

cat changelogs/${CHANGELOG} >> ${CHANGELOG}
echo >> ${CHANGELOG}

#!/bin/sh
java -cp classes das.tools.ManifestGenerator
/bin/rm -f das.jar
jar cfm das.jar resource/das.manifest.mf -C classes . || exit 1
/bin/rm -f dasservice.jar
jar cfm dasservice.jar resource/dasservice.manifest.mf -C classes . || exit 1

echo "jar files generated successfully"
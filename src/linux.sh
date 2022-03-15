#!/usr/bin/env bash
clear
bad=none
function color() {
    echo -e "$1$2\033[0m"
}

color "\033[1;37m" "         STARTING SCRIPT"
echo 

#--- Checking ---
color "\033[1;33m" "🗘 Checking         - (Tar,Curl,Java,Java version,Internet)"

#Check tar
if ! [ -x "$(command -v tar)" ]; then
    color "\033[1;31m" "    ✗ Tar          - Tar doesn't exist on your pc."
    bad="Curl"
    color "\033[1;31m" "✗ Checking         - Error in $bad"
    exit 1
else
    color "\033[1;32m" "    ✓ Tar          - OK"
fi

#Check curl
if ! [ -x "$(command -v curl)" ]; then
    color "\033[1;31m" "    ✗ Curl         - Curl doesn't exist on your pc."
    bad="Curl"
    color "\033[1;31m" "✗ Checking         - Error in $bad"
    exit 1
else
    color "\033[1;32m" "    ✓ Curl         - OK"
fi

#Check java
if ! [ -x "$(command -v java)" ]; then
    color "\033[1;31m" "    ✗ Java         - Java doesn't exist on your pc."
    bad="Java"
    color "\033[1;31m" "✗ Checking         - Error in $bad"
    exit 1
else
    color "\033[1;32m" "    ✓ Java         - OK"
fi

#Check java version
_java=java
version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
if ! [[ "$version" > "17.0" ]]; then
    color "\033[1;31m" "    ✗ Java version - Your java version ($version) need be 17.0 or newer"
    bad="Java version"
    color "\033[1;31m" "✗ Checking         - Error in $bad"
    exit 1
else
    color "\033[1;32m" "    ✓ Java version - OK"
fi

#Check internet
if ! ping -q -w 1 -c 1 google.com > /dev/null ; then
    color "\033[1;31m" "    ✗ Internet     - No internet connection"
    bad="Internet"
    color "\033[1;31m" "✗ Checking         - Error in $bad"
    exit 1
else
    color "\033[1;32m" "    ✓ Internet     - OK"
fi

color "\033[1;32m" "✓ Checking         - OK"
#--- Checking ---

echo

#--- Downloading ---
color "\033[1;33m" "🗘 Downloading      - (Version,Start script,Server jar,Mods)"

#Version
if ! curl -s 'https://raw.githubusercontent.com/Adventures-of-Fox/FoxInstaller/main/cdn/version' > ".version"; then
    color "\033[1;31m" "    ✗ Version      - Error failed"
    bad="Version"
    color "\033[1;31m" "✗ Downloading      - Error in $bad"
    exit 1
else
    color "\033[1;32m" "    ✓ Version      - OK"
fi

#Start script
if ! curl -s 'https://raw.githubusercontent.com/Adventures-of-Fox/FoxInstaller/main/cdn/start-linux.sh' > "start.sh"; then
    color "\033[1;31m" "    ✗ Start script - Error failed"
    bad="Start script"
    color "\033[1;31m" "✗ Downloading      - Error in $bad"
    exit 1
else
    color "\033[1;32m" "    ✓ Start script - OK"
fi

#Server jar
if ! curl -s 'https://meta.fabricmc.net/v2/versions/loader/1.18.1/0.13.3/0.10.2/server/jar' > "server.jar"; then
    color "\033[1;31m" "    ✗ Server jar   - Error failed"
    bad="Server jar"
    color "\033[1;31m" "✗ Downloading      - Error in $bad"
    exit 1
else
    color "\033[1;32m" "    ✓ Server jar   - OK"
fi

#Mods
# if ! curl -s 'example.com' > "."; then
#     color "\033[1;31m" "    ✗ Mods         - Error failed"
#     bad="Server jar"
#     color "\033[1;31m" "✗ Downloading      - Error in $bad"
#     exit 1
# else
#     color "\033[1;32m" "    ✓ Mods         - OK"
# fi
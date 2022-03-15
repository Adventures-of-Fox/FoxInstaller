#!/usr/bin/env bash
clear
bad=none
function color() {
    echo -e "$1$2\033[0m"
}

color "\033[1;37m" "         STARTING SCRIPT"
echo 

#--- Checking ---
color "\033[1;33m" "🗘 Checking         - (Curl,Java,Java version,Internet)"

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
color "\033[1;33m" "🗘 Downloading      - (Start script,Server jar,Mods)"
if ! curl -s 'https://www.hevhe.pl/'; then
    color "\033[1;31m" "    ✗ Start script - Error failed"
    bad="Start script"
    color "\033[1;31m" "✗ Downloading      - Error in $bad"
    exit 1
else
    color "\033[1;32m" "    ✓ Start script     - OK"
fi
#!/usr/bin/env bash
clear
function color() {
    echo -e "$1$2\033[0m"
}
function error() {
    color "\033[1;31m" "    ✗ $1 - $2"
    color "\033[1;31m" "✗ $3         - Error in $1"
    exit 1
}

color "\033[1;37m" "         STARTING SCRIPT"
echo

#--- Checking ---
color "\033[1;33m" "🗘 Checking         - (Tar,Curl,Java,Java version,Internet)"
main="Checking        "

#Check tar
if ! [ -x "$(command -v tar)" ]; then
    error "Tar         " "Java doesn't exist on your pc." "$main"
else
    color "\033[1;32m" "    ✓ Tar          - OK"
fi

#Check curl
if ! [ -x "$(command -v curl)" ]; then
    error "Curl        " "Java doesn't exist on your pc." "$main"
else
    color "\033[1;32m" "    ✓ Curl         - OK"
fi

#Check java
if ! [ -x "$(command -v java)" ]; then
    error "Java        " "Java doesn't exist on your pc." "$main"
else
    color "\033[1;32m" "    ✓ Java         - OK"
fi

#Check java version
_java=java
version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
if ! [[ "$version" > "17.0" ]]; then
    error "Java version    " "Your java version ($version) need be 17.0 or newer" "$main"
else
    color "\033[1;32m" "    ✓ Java version - OK"
fi

#Check internet
if ! ping -q -w 1 -c 1 google.com >/dev/null; then
    error "Internet    " "No internet connection" "$main"
else
    color "\033[1;32m" "    ✓ Internet     - OK"
fi

color "\033[1;32m" "✓ Checking         - OK"
#--- Checking ---

echo

#--- Downloading ---
color "\033[1;33m" "🗘 Downloading      - (Version,Start script,Server jar,Mods)"
main="Downloading     "

#Version
if ! curl -s 'https://raw.githubusercontent.com/Adventures-of-Fox/FoxInstaller/main/cdn/version' >".version"; then
    error "Version     " "Error failed download" "$main"
else
    color "\033[1;32m" "    ✓ Version      - OK"
fi

#Start script
if ! curl -s 'https://raw.githubusercontent.com/Adventures-of-Fox/FoxInstaller/main/cdn/start-linux.sh' >"start.sh"; then
    error "Start script" "Error failed download" "$main"
else
    color "\033[1;32m" "    ✓ Start script - OK"
fi

#Server jar
if ! curl -s 'https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.10.2/fabric-installer-0.10.2.jar' >"installer_server.jar"; then
    error "Server jar  " "Error failed download" "$main"
else
    color "\033[1;32m" "    ✓ Server jar   - OK"
fi

#Mods
if ! curl -s 'https://raw.githubusercontent.com/Adventures-of-Fox/FoxInstaller/main/cdn/test.tar.gz' >"server.tar.gz"; then
    error "Mods        " "Error failed download" "$main"
else
    color "\033[1;32m" "    ✓ Mods         - OK"
fi

color "\033[1;32m" "✓ Downloading      - OK"
#--- Downloading ---

echo

#--- Preparing ---
main="Preparing     "
color "\033[1;33m" "🗘 Preparing        - (Server files,Extracting)"

# Server files
if ! java -jar installer_server.jar server -mcversion 1.18.1 -downloadMinecraft >/dev/null; then
    error "Server files" "Downloading server files failed" "$main"
else
    color "\033[1;32m" "    ✓ Server files - OK"
fi
rm installer_server.jar

if ! tar -xf server.tar.gz; then
    error "Extracting  " "Error failed" "$main"
else
    color "\033[1;32m" "    ✓ Extracting   - OK"
fi
rm server.tar.gz

color "\033[1;32m" "✓ Preparing        - OK"
#--- Preparing ---

echo

#--- END ---
color "\033[1;37m" "         RUN start.sh TO RUN SERVER"
color "\033[1;37m" "         CHECK README.TXT"
color "\033[1;37m" "         END SCRIPT"

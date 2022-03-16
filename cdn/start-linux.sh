#!/usr/bin/env bash
clear
function color() {
    echo -e "$1$2\033[0m"
}

color "\033[1;37m" "         STARTING SCRIPT"
color "\033[1;37m" "         CHECK README.txt"

#---CHECK---
if [[ $(<.version) == $(curl -s "https://raw.githubusercontent.com/Adventures-of-Fox/FoxInstaller/main/cdn/version") ]]; then
    color "\033[1;34m" "CURRENT '$(<.version)' VERSION OF SERVER IS NOT LATEST '$(curl -s "https://raw.githubusercontent.com/Adventures-of-Fox/FoxInstaller/main/cdn/version")'"
    color "\033[1;34m" "UPDATE IT"
fi

#---CONFIG---
RAM_MAX="6144"+"M"
RAM_MIN="6144"+"M"
SERVER_FILE="fabric-server-launch.jar"
#---RAM---

java -Xmx$RAM_MAX -Xms$RAM_MIN -jar $SERVER_FILE nogui

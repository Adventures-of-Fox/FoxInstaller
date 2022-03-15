#!/usr/bin/env bash
clear
function color() {
    echo -e "$1$2\033[0m"
}

color "\033[1;37m" "         STARTING SCRIPT"
color "\033[1;37m" "         CHECK README.txt"

#---CONFIG---
RAM_MAX="6144"+"M"
RAM_MIN="6144"+"M"
SERVER_FILE="server.jar"
#---RAM---

java -Xmx$RAM_MAX -Xms$RAM_MIN -jar $SERVER_FILE nogui
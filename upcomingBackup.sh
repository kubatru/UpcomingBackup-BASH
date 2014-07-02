#!/bin/bash

# Jakub Truhlar ©2014
# -------------------
# Skript informuje uzivatele o case a velikost pristi zalohy (zalohuje
# se var/log).

# Priklad vstupu: tentoscript.sh 1 14:00
# Priklad vystupu: Datum pristi zalohy: Monday, 21.3.2014 v 14:00:00 
#                  Velikost zalohy: 25M 

declare backupWeekday=$1
declare backupTime=$2
serverWeekday=$(date +"%u")
backuptimeToString=$(date -d "$backupTime" +"%H%M%S")
serverTime=$(date +"%H%M%S")

if (($backupWeekday > 7 | $backupWeekday < 1)); then
echo "Zadejte den tydne od 1 do 7"
else

if (($serverWeekday > $backupWeekday)); then
posun=$((7+$backupWeekday-$serverWeekday))
elif (($backupWeekday > $serverWeekday)); then
posun=$(($backupWeekday-$serverWeekday))
else

if (($backuptimeToString > $serverTime)); then
posun=$(($backupWeekday-$serverWeekday))
else
posun=$((7+$backupWeekday-$serverWeekday))
fi
fi

echo -n "Datum pristi zalohy: " 
date -d "$posun days $backupTime" +"%A, %-d.%-m.%y v %H:%M:%S"

echo -n "Velikost zalohy "
du -sh /var/log 2>/dev/null | cut -c 1-4

fi

#!/bin/bash

logger -s "Backup process initiated" 2>> /srv/minecraft/backup.log

if [ "$1" == "cloud" ]; then
  BKP_FILE_NAME=$(ls -t backups/ |head -1)

  logger -s "Sending file $BKP_FILE_NAME to BackBlaze bucket" 2>> /srv/minecraft/backup.log

  b2 upload_file minecraft-bkp-seattle /srv/minecraft/backups/$BKP_FILE_NAME $BKP_FILE_NAME
else
  mcrcon -H 127.0.0.1 -P 25575 -p baba-ganouj "save-off"
  mcrcon -H 127.0.0.1 -P 25575 -p baba-ganouj "save-all"
  
  BKP_FILE_NAME=server-$(date +%F-%H-%M).tar.gz
  
  tar -cvpzf /srv/minecraft/backups/$BKP_FILE_NAME /srv/minecraft/seattle
  
  mcrcon -H 127.0.0.1 -P 25575 -p baba-ganouj "save-on"
fi

logger -s "Cleaning up local backup files" 2>> /srv/minecraft/backup.log
find /srv/minecraft/backups -type f -mtime +1 -name '*.gz' -delete

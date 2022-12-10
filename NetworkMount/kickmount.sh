#!/bin/bash
#This script can sit in the /root directory.

/media/fat/Scripts/cifs_umount.sh
/media/fat/Scripts/cifs_mount.sh

cd /media/fat/games &&  find . | grep _Network | xargs rm
for p in `find . -maxdepth 1 -type d | grep -v " " | grep -v "\.$" `
do
        if [ -d /media/nas/${p} ];
        then
                ln -sv /media/nas/${p} ${p}/_Network;
        fi;
done

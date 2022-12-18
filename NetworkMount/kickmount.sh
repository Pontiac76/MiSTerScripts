#!/bin/bash
# This script can sit in the /root directory.

# Perform the remount using already provided scripts
/media/fat/Scripts/cifs_umount.sh
/media/fat/Scripts/cifs_mount.sh

# Go into the games directory and hunt down all the _Network files and delete them
cd /media/fat/games &&  find . | grep _Network | xargs rm

# Go into the games directory and get a list of the directories for each core
cd /media/fat/games && for p in `find . -maxdepth 1 -type d | grep -v " " | grep -v "\.$" `
do
        # If the directory exists on the NAS, link the directory and report verbosely.
        if [ -d /media/nas/${p} ];
        then
                ln -sv /media/nas/${p} ${p}/_Network;
        fi;
done

#!/bin/bash
# This script can be run anywhere, but should be located in /media/fat/Scripts
# For simplicity, you could run [ ln -s /media/fat/Scripts/kickmount.sh /root/kickmount.sh ]

if [ -d /media/fat/games ];
then
        if [ -d /media/nas ];
        then
                # Perform the remount using already provided scripts
                /media/fat/Scripts/cifs_umount.sh
                /media/fat/Scripts/cifs_mount.sh
                
                # Go into the games directory and hunt down all the _Network files and delete them
                cd /media/fat/games 
                find . | grep _Network | xargs rm

                # Go into the games directory and get a list of the directories for each core
                for p in `find . -maxdepth 1 -type d | grep -v " " | grep -v "\.$" `
                do
                        # If the directory exists on the NAS, link the directory and report verbosely.
                        if [ -d /media/nas/${p} ];
                        then
                                ln -sv /media/nas/${p} ${p}/_Network;
                        fi;
                done
        else
                echo "Script cannot continue as it doesn't seem like the /media/nas diretory exists."
                exit 1
        fi
else
        echo "Something is critically wrong.  /media/fat/games does not exist!"
        exit 1
fi

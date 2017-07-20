#!/bin/bash
#title          Caliditas-Pi
#description    BASH script for temperature scan and notification.
#author		      Ivan Batakov
#email          admin@selendis.eu

# Configuration
sendEmail="owner@domain.eu" # e-mail for notifications
warnCPUTemp="61" # warning cpu temperature (integer)
shutdownCPUTemp="80" # shutdown system when CPU reaches X temp
warnGPUTemp="45" # warning gpu temperature (integer)
shutdownGPUTemp="69" # shutdown system when GPU reaches X temp
warnLog="warn" # name of the warning .log file

# DO NOT EDIT
getCPU=$(</sys/class/thermal/thermal_zone0/temp)
currentCPUTemp=$((getCPU/1000))
getGPU=$(/opt/vc/bin/vcgencmd measure_temp)
currentGPUTemp=$(echo $getGPU | tr -d temp=C"'" | cut -f1 -d".")
shutdownPi=/sbin/shutdown
currentDate='['`date '+%d.%m.%y][%H:%M:%S]'`
warnMSG=": This is a WARNING temperature message!!!\n$currentDate: Server: $HOSTNAME"
alertLevel=0; shutLevel=0

if [ $currentCPUTemp -ge $shutdownCPUTemp ]; then
        echo $currentDate': CPU is overheating, current temperature' $currentCPUTemp'°C. The system will be powered off!' >> $warnLog.log
        alertLevel=$((alertLevel+1)); shutLevel=$((shutLevel+1))
elif [ $currentCPUTemp -ge $warnCPUTemp ]; then
        echo $currentDate': CPU is passing critical temperature' $warnCPUTemp'°C. Currently at' $currentCPUTemp'°C.' >> $warnLog.log
        alertLevel=$((alertLevel+1))
fi


if [ $currentGPUTemp -ge $shutdownGPUTemp ]; then
        echo $currentDate': GPU is overheating, current temperature' $currentGPUTemp'°C. The system will be powered off!' >> $warnLog.log
        alertLevel=$((alertLevel+1)); shutLevel=$((shutLevel+1))
elif [ $currentGPUTemp -ge $warnGPUTemp ]; then
        echo $currentDate': GPU is passing critical temperature' $warnGPUTemp'°C. Currently at' $currentGPUTemp'°C.' >> $warnLog.log
        alertLevel=$((alertLevel+1))
fi


if [ $alertLevel -ge 1 ]; then
        echo $currentDate": Problems found:" $alertLevel >> $warnLog.log
                if [ $currentCPUTemp -lt $warnCPUTemp ]; then
                        echo $currentDate': CPU currently at:' $currentCPUTemp'°C' >> $warnLog.log
                fi
                if [ $currentGPUTemp -lt $warnGPUTemp ]; then
                        echo $currentDate': GPU currently at:' $currentGPUTemp'°C' >> $warnLog.log
                fi
        echo $currentDate": End of warning report." >> $warnLog.log
        echo -e "$currentDate$warnMSG\n$(cat $warnLog.log)" > $warnLog.log
fi

if [ $shutLevel -ge 1 ]; then
        mail -s "Server SHUTDOWN: Temperature" $sendEmail < $warnLog.log
        rm $warnLog.log
        $shutdownPi
elif [ $alertLevel -ge 1 ]; then
        mail -s "Server WARNING: Temperature" $sendEmail < $warnLog.log
        rm $warnLog.log
fi

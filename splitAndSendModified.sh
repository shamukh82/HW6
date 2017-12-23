#!/bin/bash

if [ -z "$1" ]; then
        echo "Missing output folder name"
        exit 1
fi

split -l 10000 orders.txt chunk

for f in `ls chunk*`; do
        if [ "$2" == "local" ]; then
		mv $f /Users/smukherjee5/harvard_hw/hw6/staging/
		sleep 3
                mv /Users/smukherjee5/harvard_hw/hw6/staging/$f /Users/smukherjee5/harvard_hw/hw6/$1/
                rm -f $f
        else
        	hadoop fs -put $f /user/cloudera/staging
                sleep 3
                hadoop fs -mv /user/cloudera/staging/$f /user/cloudera/$1/
                rm -f $f
	fi
done


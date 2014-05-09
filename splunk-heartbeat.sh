#!/bin/bash
host_address=$1
splunk_path=$2
ping_count=$(ping -c 3 $host_address | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')

# check is $splunk_path exist or not
if [ ! -e ${splunk_path}/etc/system/local/ping_status ]; then
	echo 0 >  ${splunk_path}/etc/system/local/ping_status
fi

# check is $splunk_path/etc/system/local/outputs.conf.pre_* exist or not
if [[ ! -e ${splunk_path}/etc/system/local/outputs.conf.pre_ori && ! -e ${splunk_path}/etc/system/local/outputs.conf.pre_pre ]]; then
	echo "Please create preconfig file first."
	exit
fi

status=`cat ${splunk_path}/etc/system/local/ping_status`
if [ -z $ping_count ]; then
	if [ $status -eq 0 ]; then
		echo "1" > ${splunk_path}/etc/system/local/ping_status
		rm -f ${splunk_path}/etc/system/local/output.conf
		cp ${splunk_path}/etc/system/local/outputs.conf.pre_bak ${splunk_path}/etc/system/local/outputs.conf
		${splunk_path}/bin/splunk restart
	fi
else
	count=$ping_count
	if [ $count -eq 0 ]; then
		if [ $status -eq 0 ]; then
        		echo "1" > ${splunk_path}/etc/system/local/ping_status
			rm -f ${splunk_path}/etc/system/local/output.conf
			cp ${splunk_path}/etc/system/local/outputs.conf.pre_bak ${splunk_path}/etc/system/local/outputs.conf
			${splunk_path}/bin/splunk restart
        	fi
	elif [ $count -ge 1 ]; then
		if [ $status -eq 1 ]; then
			echo "0" > ${splunk_path}/etc/system/local/ping_status
			rm -f ${splunk_path}/etc/system/local/output.conf
			cp ${splunk_path}/etc/system/local/outputs.conf.pre_ori ${splunk_path}/etc/system/local/outputs.conf
			${splunk_path}/bin/splunk restart
		fi
	fi
fi

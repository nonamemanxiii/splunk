Splunk
======

Heartbeat
---------
splunk-heartbeat is real-time health check for splunk indexer. When splunk indexer die, the script will switch config file inside splunkforwarder in order to change destination to another indexer, and change back again when splunk indexer came up.

Heartbeat: How to
-----------------
	Firt, you need to create a pre-config file 'outputs.conf.pre' that pont splunkforwarder to alternative indexer. Put this file into $SPLUNK_HOME/etc/system/local. Then copy your original outputs.conf to outputs.conf.pre_ori
	Put splunk-heartbeat.sh into crontab, followed by two argument.
first argument is an IP address like '192.168.0.2'
second argument is a path to splunkforwarder, end without '/'
Example:
* * * * * /home/user/splunk-heartbeat.sh 192.168.0.2 /opt/splunkforwarder

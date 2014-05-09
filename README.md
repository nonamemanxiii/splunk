Splunk
======

Heartbeat
---------
	splunk-heartbeat is real-time health check for splunk indexer which implement with index replication. When splunk indexer die the script will swap pre-config file inside splunkforwarder. This script will work in case the machine is down. not just splunk service. To monitor service, I'll write another script(in python) to check port by port, but don't know when :p.

Heartbeat: How to
-----------------
	Firt you'll need to create a pre-config file 'outputs.conf.pre' that point splunkforwarder to alternative indexer. Put this file into "$SPLUNK_HOME/etc/system/local". Then copy your original outputs.conf to outputs.conf.pre_ori.
	After that put splunk-heartbeat.sh into crontab, followed by two argument.
	1. IP address
	2. path to splunkforwarder (end without '/')
	Example:
	* * * * * /home/user/splunk-heartbeat.sh 192.168.0.2 /opt/splunkforwarder

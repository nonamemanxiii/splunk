Splunk
======

Heartbeat
---------
	splunk-heartbeat is a real-time health check for splunk indexer(which implemented with index replication solution). When splunk indexer goes down this script will swap to pre-config file in splunkforwarder. This will only work in case an entire machine (of an indexer) goes down (not just splunk service).

Heartbeat: How to
-----------------
	Firt you'll need to create a pre-config file 'outputs.conf.pre' that point splunkforwarder to alternative indexer. Put this file into "$SPLUNK_HOME/etc/system/local". Then copy your original outputs.conf to outputs.conf.pre_ori.
	After that put splunk-heartbeat.sh into crontab, followed by two argument.
	1. IP address
	2. path to splunkforwarder (end without '/')
	Example:
	* * * * * /home/user/splunk-heartbeat.sh 192.168.0.2 /opt/splunkforwarder

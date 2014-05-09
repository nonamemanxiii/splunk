splunk
======

Heartbeat
---------
splunk-heartbeat is real-time health check for splunk indexer. When splunk indexer die, the script will switch config file inside splunkforwarder in order to change destination to another indexer, and change back again when splunk indexer came up.

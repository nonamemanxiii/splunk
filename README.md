splunk
======

Heartbeat
splunk-heartbeat is real-time health check for splunk indexer. if splunk indexer die, the script will switch config file of splunkforwarder in order to change destination to another indexer, and change back when splunk indexer came up.

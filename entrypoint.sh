#!/bin/bash

/var/ossec/bin/wazuh-control start
status=$?
if [ $status -ne 0 ]; then
	echo "Failed to start agent: $status"
	exit $status
fi

echo "background jobs running, listening for changes"

while sleep 60; do

	# check if wazuh agent is running
	/var/ossec/bin/wazuh-control status >/dev/null 2>&1
	status=$?
	if [ $status -ne 0 ]; then
		echo "looks like the agent died."
		exit 1
	fi

	# If the process is running
	#if [ -v GWSPID ]; then
	#	if ! ps -p "$GWSPID" >/dev/null; then
	#		echo "looks like gws-collect died."
	#		exit 1
	#	fi
	#else
	#	/gws-collect &
	#	GWSPID=$!
	#fi

done

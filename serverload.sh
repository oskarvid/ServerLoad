#!/usr/bin/env bash
# Uncomment to debug
#set -o xtrace

usage() {
echo "Usage: $0 device-name interval-in-seconds"
echo "e.g $0 /dev/sdb2 5"
echo "This will check the disk usage of /dev/sdb2, RAM usage and system load every 5 seconds"
1>&2; exit 1
}

if [[ $# -lt 2 ]]; then
	echo "Device name and/or time interval is missing."
	echo "" \
	&& usage \
	&& exit 1
fi

DEV=$1
INTERVAL=$2
NUMERICPATTERN='^[0-9]+$'
NOW=$(date +%F.%H.%M.%S)

if [[ "$INTERVAL" =~ $NUMERICPATTERN ]]; then
	echo "Started monitoring serverload at $NOW"
	while true; do
		sleep "$INTERVAL" \
		&& cat /proc/loadavg >> /tmp/mylogfileLoad-$NOW \
		&& date +%H:%M >> /tmp/mylogfileTime-$NOW \
		&& cat /proc/stat | grep procs_blocked >> /tmp/mylogfileBloc-$NOW \
		&& vmstat | tail -1 | awk {'print $1'} >> /tmp/mylogfileQueu-$NOW \
		&& df | grep $1 | awk {'print $2/1000000,$3/1000000,$4/1000000'} >> /tmp/mylogfileDisk-$NOW \
		&& free -m | awk 'FNR==2 { print $2, $3, $4, $7}' >> /tmp/mylogfileRAM-$NOW \
		&& paste /tmp/mylogfileLoad-$NOW /tmp/mylogfileTime-$NOW /tmp/mylogfileBloc-$NOW /tmp/mylogfileQueu-$NOW /tmp/mylogfileDisk-$NOW /tmp/mylogfileRAM-$NOW > \
		input/mylogfile-$NOW \
		&& sed -i 's|$| '"${DEV}"'|' input/mylogfile-$NOW
	done
else
	echo "Time interval format must be a number and cannot include decimal points"
	echo "" && usage
fi

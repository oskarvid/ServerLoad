#!/usr/bin/env bash

 now=$(date +%F.%H.%M.%S)
 echo "Started monitoring serverload at $now"
 while ( sleep 10 );
        do cat /proc/loadavg >> /tmp/mylogfileLoad-$now \
        && date +%H:%M >> /tmp/mylogfileTime-$now \
        && ps -eo size,pid,user,args --sort -size | awk '{ hr=$1/1024 ; printf("%13.2f MB ",hr) } { for (x=4; x<=NF ; x++ ) { printf("%s ",$x) } print "" }' | grep -e bwa -e java | grep -v grep | grep -v sh | awk -v OFS='\t' {'print $1, $2, $3'} >> /tmp/mylogfileProc-$now \
        && cat /proc/stat | grep procs_blocked >> /tmp/mylogfileBloc-$now \
        && vmstat|tail -1|awk {'print $1'} >> /tmp/mylogfileQueu-$now \
        && df -h | grep sdb1 | awk {'print $2,$3,$4'} >> /tmp/mylogfileDisk-$now \
        && free -m | awk 'FNR==2 { print $2, $3, $4, $7}' >> /tmp/mylogfileRAM-$now \
        && paste /tmp/mylogfileLoad-$now /tmp/mylogfileTime-$now /tmp/mylogfileBloc-$now /tmp/mylogfileQueu-$now /tmp/mylogfileDisk-$now /tmp/mylogfileRAM-$now > \
        input/mylogfile-$now;
done
# vmstat|tail -1|awk {'print $1'} gives the run queue number. It's like system load but it counts
# the number of processes in the run queue, i.e processes that are waiting to run.

#!/bin/bash


write_messages () {
    log_file="$1"
    for i in {1..10}; do
	echo "This is log message ${i}" >>"${log_file}"
	sleep 1
    done
}

. wait-for-log-message.sh

test_logfile=$(mktemp)
write_messages "${test_logfile}" &
echo "Now waiting to see 'This is log message 10' in ${test_logfile}"
wait_for_log_message "${test_logfile}" 'This is log message 10'
echo "Saw the log message, continuing..."

# Good tests clean up after themselves...
rm -f "${test_logfile}"

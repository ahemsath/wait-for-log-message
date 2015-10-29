#!/bin/bash


wait_for_log_message_the_wrong_way() {
    log_file="$1"
    message="$2"

    grep -m 1 "$message" <(tail -f "$log_file")
}
    

wait_for_log_message() {
    log_file="$1"
    message="$2"

    named_pipe=$(mktemp -u) # -u causes mktemp to just print a name without creating anything
    mkfifo "${named_pipe}"
    tail -f "$log_file" &>>"${named_pipe}" &
    pid_of_tail=$!
    grep -m 1 "$message" <"${named_pipe}"
    kill "$pid_of_tail" && wait "$pid_of_tail" 2>/dev/null
    rm -f "${named_pipe}"
}

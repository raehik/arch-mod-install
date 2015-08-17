# vim: set ft=sh :
#

# reset logfile
if [[ -f "$V_log_file" ]]; then
    rm "$V_log_file"
    touch "$V_log_file"
fi

_log() {
    ### Log a message.
    ### Use for logging important steps which you want to save to a
    ### user-specified file.
    echo "$1" | tee -a "$V_log_file"
}

_log_only() {
    ### Log a message only to the logfile.
    ### e.g. for fold markers
    if [[ "$V_log_file" ]]; then
        echo "$1" >> "$V_log_file"
    fi
}

_echo() {
    ### Echo a message to the screen (and potentially log to a file). ###
    ### Use for simple messages. (For now, this function is identical to _log.)
    _log "$1"
}

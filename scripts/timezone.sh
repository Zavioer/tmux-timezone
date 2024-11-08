#!/usr/bin/env bash

# Constans
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SAVED_TIMEZONES_FILE="$CURRENT_DIR/saved_timezones.txt"
TIMEZONES_LIMIT=3

# Map tmux option to variables
timezone_date_format="@timezone_date_format"


# Functions
prompt() {
    tz_count=$(cat $SAVED_TIMEZONES_FILE | wc -l)

    if [ "$tz_count" -lt "$TIMEZONES_LIMIT" ]; then
        tmux command-prompt \
            -p "Enter timezone (Continent/City):" \
            "run-shell 'echo %1 >> $SAVED_TIMEZONES_FILE'"
    else
        tmux display-message \
            "You have reached the maximum number ($TIMEZONES_LIMIT) of timezones!"
    fi
}

display() {
    date_format=$(tmux show-option -gv "$timezone_date_format")
    timezones=() 

    while IFS= read -r line; do
        timezones+=("$line $(TZ=$line date +"$date_format")" "" "")
    done < "$SAVED_TIMEZONES_FILE"

    tmux display-menu \
        -T "Timezones" \
        "${timezones[@]}"
}

remove() {
    lineno=1
    timezones=()
 
    while IFS= read -r line; do
        timezones+=("$line" "" "run-shell 'sed -i '"$lineno"d' $SAVED_TIMEZONES_FILE'")
        ((lineno++))
    done < "$SAVED_TIMEZONES_FILE"

    tmux display-menu \
        -T "Choose a timezone to remove" \
        "${timezones[@]}"
}

menu() {
    tmux display-menu \
        -T "Menu" \
        "Add" "" "run-shell '$CURRENT_DIR/timezone.sh prompt'" \
        "Remove" "" "run-shell '$CURRENT_DIR/timezone.sh remove'" \
        "Display" "" "run-shell '$CURRENT_DIR/timezone.sh display'"
}

main() {
    cmd="$1" 
    shift

    if [ "$cmd" = "prompt" ]; then
        prompt
    elif [ "$cmd" = "display" ]; then
        display
    elif [ "$cmd" = "remove" ]; then
        remove
    else
        menu
    fi
}

main "$@"

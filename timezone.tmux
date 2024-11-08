#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

timezone_date_format="@timezone_date_format"


set_options() {
    tmux set-option -g "$timezone_date_format" "%D %H:%M:%S %Z"  
}

set_keybinding() {
    tmux bind-key -N "Display timezone prompt" "C-t" run-shell "$CURRENT_DIR/scripts/timezone.sh menu"
    tmux bind-key -N "Display timezone prompt" "M-t" run-shell "$CURRENT_DIR/scripts/timezone.sh display"
}

main() {
    set_options
    set_keybinding
}

main

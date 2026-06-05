#!/usr/bin/env bash

# Launch and arrange the daily GNOME workspace.
# Requirements: bash, xdotool, wmctrl, awk, pgrep

set -Eeuo pipefail

readonly SCRIPT_NAME="$(basename "$0")"
readonly LOG_PREFIX="[$SCRIPT_NAME]"

# Timing knobs. Increase WINDOW_TIMEOUT on slower machines or remote desktops.
readonly GNOME_TIMEOUT="${GNOME_TIMEOUT:-60}"
readonly WINDOW_TIMEOUT="${WINDOW_TIMEOUT:-45}"
readonly POLL_INTERVAL="${POLL_INTERVAL:-0.5}"

# Terminator layout names.
readonly TERMINATOR_MAIN_LAYOUT="${TERMINATOR_MAIN_LAYOUT:-layout_4}"
readonly TERMINATOR_COMM_LAYOUT="${TERMINATOR_COMM_LAYOUT:-layout_6}"

log() {
    printf '%s %s\n' "$LOG_PREFIX" "$*" >&2  # Print status messages
}

die() {
    printf '%s ERROR: %s\n' "$LOG_PREFIX" "$*" >&2 # Print an error and exits
    exit 1
}

require_command() {
    command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}

# Checks that required programs exist
check_dependencies() { 
    require_command awk
    require_command code
    require_command nautilus
    require_command pgrep
    require_command terminator
    require_command wmctrl
    require_command xdotool
}

# Waits until GNOME/X11 is ready
wait_for_gnome() {
    log "Waiting for GNOME/X11 session..."

    local deadline=$((SECONDS + GNOME_TIMEOUT))
    while (( SECONDS < deadline )); do
        # Checks whether the script can talk to the display/window manager
        if xdotool getdisplaygeometry >/dev/null 2>&1 && wmctrl -m >/dev/null 2>&1; then
            log "GNOME/X11 session is ready."
            return 0
        fi
        sleep "$POLL_INTERVAL"
    done

    die "GNOME/X11 session did not become ready within ${GNOME_TIMEOUT}s. This script requires an X11 session, not a Wayland-only session."
}

launch_if_needed() {
    local process_name="$1"
    shift

    if pgrep -x "$process_name" >/dev/null 2>&1; then
        log "$process_name is already running."
        return 0
    fi

    log "Launching $process_name..."
    "$@" >/dev/null 2>&1 &
}

launch_terminator_window() {
    local title="$1"
    local layout="$2"

    log "Launching Terminator window: $title ($layout)..."
    terminator -T "$title" -l "$layout" >/dev/null 2>&1 &
}

find_first_window_id() {
    local search_type="$1"
    local search_value="$2"

    case "$search_type" in
        class)
            xdotool search --onlyvisible --class "$search_value" 2>/dev/null | head -n 1
            ;;
        name)
            xdotool search --onlyvisible --name "$search_value" 2>/dev/null | head -n 1
            ;;
        *)
            die "Unknown search type: $search_type"
            ;;
    esac
}

wait_for_window() {
    local label="$1"
    local search_type="$2"
    local search_value="$3"
    local deadline=$((SECONDS + WINDOW_TIMEOUT))
    local window_id=""

    log "Waiting for $label window..."
    while (( SECONDS < deadline )); do
        window_id="$(find_first_window_id "$search_type" "$search_value")"
        if [[ -n "$window_id" ]]; then
            log "Found $label window: $window_id"
            printf '%s\n' "$window_id"
            return 0
        fi
        sleep "$POLL_INTERVAL"
    done

    log "WARNING: Could not find $label window within ${WINDOW_TIMEOUT}s."
    return 1
}

move_resize_window() {
    local window_id="$1"
    local x="$2"
    local y="$3"
    local width="$4"
    local height="$5"

    xdotool windowmove "$window_id" "$x" "$y"
    xdotool windowsize "$window_id" "$width" "$height"
}

send_to_workspace() {
    local window_id="$1"
    local workspace="$2"

    wmctrl -i -r "$window_id" -t "$workspace"
}

set_above() {
    local window_id="$1"

    wmctrl -i -r "$window_id" -b add,above
}

get_screen_size() {
    xdotool getdisplaygeometry | awk '{print $1, $2}'
}

main() {
    check_dependencies
    wait_for_gnome

    read -r screen_width screen_height < <(get_screen_size)
    local small_width=$((screen_width / 2))
    local small_height=$((screen_height / 2))

    log "Screen size: ${screen_width}x${screen_height}"

    launch_if_needed code code
    launch_if_needed nautilus nautilus
    launch_terminator_window "Terminator" "$TERMINATOR_MAIN_LAYOUT"
    launch_terminator_window "Communication" "$TERMINATOR_COMM_LAYOUT"

    local code_id=""
    local file_id=""
    local term_main_id=""
    local term_comm_id=""

    # VS Code can report either Code or code depending on package/version.
    code_id="$(wait_for_window "Visual Studio Code" class "code" || true)"
    if [[ -z "$code_id" ]]; then
        code_id="$(wait_for_window "Visual Studio Code" class "Code" || true)"
    fi

    file_id="$(wait_for_window "Files" class "nautilus" || true)"
    term_main_id="$(wait_for_window "main Terminator" name "^Terminator$" || true)"
    term_comm_id="$(wait_for_window "communication Terminator" name "^Communication$" || true)"

    if [[ -n "$code_id" ]]; then
        log "Arranging Visual Studio Code on workspace 0."
        move_resize_window "$code_id" 0 0 "$screen_width" "$screen_height"
        send_to_workspace "$code_id" 0
    fi

    if [[ -n "$file_id" ]]; then
        log "Arranging Files on workspace 1."
        move_resize_window "$file_id" -100 -100 "$((small_width + 190))" "$((small_height + 230))"
        send_to_workspace "$file_id" 1
        set_above "$file_id"
    fi

    if [[ -n "$term_main_id" ]]; then
        log "Arranging main Terminator on workspace 1."
        move_resize_window "$term_main_id" 0 0 "$screen_width" "$screen_height"
        send_to_workspace "$term_main_id" 1
    fi

    if [[ -n "$term_comm_id" ]]; then
        log "Arranging communication Terminator on workspace 2."
        move_resize_window "$term_comm_id" 0 0 "$screen_width" "$screen_height"
        send_to_workspace "$term_comm_id" 2
    fi

    log "Done."
}

main "$@"
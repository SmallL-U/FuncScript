#!/usr/bin/env bash

# Utils for logging

# Function to log an informational message to the console
# Arguments:
#   $* - the message to log
info() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')]: $*"
}

# Function to log a warning message to the console in yellow color
# Arguments:
#   $* - the message to log
warn() {
    echo -e "\033[1;33m[$(date +'%Y-%m-%d %H:%M:%S')]: $*\033[0m"
}

# Function to log an error message to the console in red color, and outputs to stderr
# Arguments:
#   $* - the message to log
error() {
    echo -e "\033[0;31m[$(date +'%Y-%m-%d %H:%M:%S')]: $*\033[0m" >&2
}

# Function to copy file A to file B if their SHA256 checksums differ
# Arguments:
#   $1 - Source file path
#   $2 - Destination file path
cp_if_diff() {
    local file_a="$1"
    local file_b="$2"

    # Check if the source file exists
    if [ ! -f "$file_a" ]; then
        error "Source file '$file_a' does not exist."
        return 1
    fi

    # If the destination file doesn't exist, copy directly
    if [ ! -f "$file_b" ]; then
        cp "$file_a" "$file_b"
        if [ $? -eq 0 ]; then
            info "Destination file did not exist; copied '$file_a' to '$file_b'."
        else
            error "Failed to copy '$file_a' to '$file_b'."
        fi
        return $?
    fi

    # Calculate the SHA256 checksums of both files
    local hash_a hash_b
    hash_a=$(sha256sum "$file_a" | awk '{print $1}')
    hash_b=$(sha256sum "$file_b" | awk '{print $1}')

    # If the checksums differ, copy the source file to destination
    if [ "$hash_a" != "$hash_b" ]; then
        cp "$file_a" "$file_b"
        if [ $? -eq 0 ]; then
            info "SHA256 checksums differ; copied '$file_a' to '$file_b'."
        else
            error "Failed to copy '$file_a' to '$file_b'."
        fi
        return $?
    else
        info "The SHA256 checksums are identical; no need to copy."
    fi
}
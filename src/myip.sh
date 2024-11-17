#!/bin/bash

# Function to run commands as root
run_as_root() {
    su -c "$1"
}

echo "==================================="

# Print username
usr=$(whoami)
echo "User:              $usr"

# Localhost
localhost=$(hostname -i | awk '{print $1}')
echo "Localhost:         $localhost"

# Function to get local IP address
get_local_ip() {
    local_ip=$(run_as_root "ip addr show | grep -E 'inet .* global' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1")
    if [ -z "$local_ip" ]; then
        local_ip=$(run_as_root "ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -1")
    fi
    echo "$local_ip"
}

# Function to get public IP address
get_public_ip() {
    public_ip=$(run_as_root "curl -s https://api.ipify.org")
    echo "$public_ip"
}

# Get and display local IP
local_ip=$(get_local_ip)
echo "Local IP Address:  $local_ip"

# Get and display public IP
public_ip=$(get_public_ip)
echo "Public IP Address: $public_ip"

echo "==================================="


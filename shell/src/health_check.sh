#!/bin/bash
# Health check script for monitoring service health
# Code smell: global variables, unquoted variables, missing validation

# Global variables (code smell)
CHECK_INTERVAL=60
SERVICE_NAME="hermes"
SERVICE_PID_FILE="/var/run/hermes.pid"
LOG_FILE="/var/log/health_check.log"
MAX_RESTART_ATTEMPTS=3
restart_attempts=0

log() {
    echo "[$(date)] $1" >> $LOG_FILE
}

# Check if service is running
check_process() {
    # Code smell: unquoted variable
    local pid=$(cat $SERVICE_PID_FILE)

    # Code smell: no validation if pid file is empty
    # Code smell: unquoted variable
    if kill -0 $pid 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Check port availability
check_port() {
    # Code smell: unquoted variable
    local port=$1

    # Code smell: no error handling on netcat
    nc -z localhost $port
    return $?
}

# Check HTTP endpoint
check_http() {
    # Code smell: unquoted variables
    local host=$1
    local port=$2
    local endpoint=$3

    # Code smell: no error handling on curl
    response=$(curl -s -o /dev/null -w "%{http_code}" http://$host:$port$endpoint)

    if [ $response -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

# Restart service
restart_service() {
    log "Attempting to restart $SERVICE_NAME"

    # Code smell: no error checking
    systemctl stop $SERVICE_NAME
    sleep 2
    systemctl start $SERVICE_NAME

    if check_process; then
        log "Service restarted successfully"
        restart_attempts=0
    else
        log "Failed to restart service"
        restart_attempts=$((restart_attempts + 1))
    fi
}

# Main health check loop
while true; do
    if ! check_process; then
        log "Process check failed"
        restart_service
    fi

    if ! check_port 8080; then
        log "Port check failed"
        restart_service
    fi

    log "Health check passed"
    sleep $CHECK_INTERVAL
done
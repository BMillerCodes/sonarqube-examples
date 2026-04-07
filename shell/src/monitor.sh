#!/bin/bash
# Monitor system resources
# Code smell: global variables, unquoted variables

# Global configuration (code smell)
THRESHOLD_CPU=80
THRESHOLD_MEM=85
THRESHOLD_DISK=90
OUTPUT_FILE="/var/log/resource_monitor.log"
ALERT_EMAIL="admin@example.com"

log() {
    echo "[$(date)] $1" >> $OUTPUT_FILE
}

# Check CPU usage
check_cpu() {
    # Code smell: parsing top output which can vary
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)

    # Code smell: unquoted variable comparison
    if [ $cpu_usage -gt $THRESHOLD_CPU ]; then
        log "ALERT: CPU usage is ${cpu_usage}% (threshold: ${THRESHOLD_CPU}%)"
        return 1
    fi

    return 0
}

# Check memory usage
check_memory() {
    # Code smell: parsing free output
    local mem_usage=$(free | grep Mem | awk '{printf("%.0f"), $3/$2 * 100}')

    if [ $mem_usage -gt $THRESHOLD_MEM ]; then
        log "ALERT: Memory usage is ${mem_usage}% (threshold: ${THRESHOLD_MEM}%)"
        return 1
    fi

    return 0
}

# Check disk usage
check_disk() {
    # Code smell: parsing df output, unquoted path
    local disk_usage=$(df -h / | tail -1 | awk '{print $5}' | cut -d'%' -f1)

    if [ $disk_usage -gt $THRESHOLD_DISK ]; then
        log "ALERT: Disk usage is ${disk_usage}% (threshold: ${THRESHOLD_DISK}%)"
        return 1
    fi

    return 0
}

# Send alert email
send_alert() {
    # Code smell: unquoted variables
    local subject=$1
    local message=$2

    # Code smell: no error handling on mail command
    echo "$message" | mail -s "$subject" $ALERT_EMAIL
}

# Main monitoring loop
main() {
    log "Starting resource monitoring"

    check_cpu
    check_memory
    check_disk

    if [ $? -ne 0 ]; then
        send_alert "Resource Alert" "One or more resource thresholds exceeded"
    fi

    log "Resource monitoring completed"
}

main
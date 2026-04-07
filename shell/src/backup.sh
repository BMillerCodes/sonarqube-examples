#!/bin/bash
# Backup database and configuration
# Code smell: global variables, unquoted variables, missing error handling

# Global variables (code smell)
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="hermes_db"
DB_USER="postgres"
BACKUP_DIR="/backup/postgres"
CONFIG_DIR="/etc/hermes"
RETENTION_DAYS=30
LOG_FILE="/var/log/backup.log"

log() {
    echo "[$(date)] $1" | tee -a $LOG_FILE
}

# Create backup directory
setup() {
    # Code smell: no error handling
    mkdir -p $BACKUP_DIR
    chmod 700 $BACKUP_DIR
}

# Backup database
backup_database() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="$BACKUP_DIR/${DB_NAME}_${timestamp}.sql"

    log "Starting database backup to $backup_file"

    # Code smell: password on command line (visible in process list)
    # Code smell: no error handling on pg_dump
    PGPASSWORD="postgres123" pg_dump -h $DB_HOST -p $DB_PORT -U $DB_USER -F c -b -f $backup_file $DB_NAME

    # Code smell: no verification that backup file was created
    log "Database backup completed: $backup_file"
}

# Backup configuration
backup_config() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local config_backup="$BACKUP_DIR/config_${timestamp}.tar.gz"

    log "Backing up configuration"

    # Code smell: no error handling on tar
    tar -czf $config_backup $CONFIG_DIR

    log "Configuration backup completed: $config_backup"
}

# Cleanup old backups
cleanup() {
    log "Cleaning up backups older than $RETENTION_DAYS days"

    # Code smell: unquoted variable in path, no error handling
    find $BACKUP_DIR -name "*.sql" -mtime +$RETENTION_DAYS -delete
    find $BACKUP_DIR -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete

    log "Cleanup completed"
}

# Verify backups
verify() {
    log "Verifying backup integrity"

    # Code smell: unquoted variable
    latest_backup=$(ls -lt $BACKUP_DIR/*.sql 2>/dev/null | head -1 | awk '{print $NF}')

    if [ -f $latest_backup ]; then
        # Code smell: no error handling
        pg_restore --list $latest_backup > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            log "Backup verification passed: $latest_backup"
        else
            log "Backup verification failed: $latest_backup"
        fi
    else
        log "No backup found to verify"
    fi
}

setup
backup_database
backup_config
cleanup
verify
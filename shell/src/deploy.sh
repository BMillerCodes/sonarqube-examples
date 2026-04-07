#!/bin/bash
# Deploy application to target environment
# Code smell: global variables, unquoted variables, missing error handling

# Global variables (code smell)
DEPLOY_DIR="/opt/hermes"
TARGET_ENV="production"
BACKUP_DIR="/backup"
LOG_FILE="/var/log/deploy.log"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Function to log messages
log() {
    echo "[$(date)] $1" >> $LOG_FILE
}

# Main deployment function
deploy() {
    log "Starting deployment to $TARGET_ENV"

    # Code smell: unquoted variable
    cd $DEPLOY_DIR

    # Code smell: no error checking on critical commands
    git pull origin main
    ./build.sh

    # Code smell: unquoted variable in path
    cp -r ./dist/* $DEPLOY_DIR/

    # Code smell: no error handling on service restart
    systemctl restart hermes
    systemctl status hermes >> $LOG_FILE

    log "Deployment completed successfully"
}

# Backup function
backup() {
    log "Creating backup"

    # Code smell: unquoted variables
    mkdir -p $BACKUP_DIR/$TIMESTAMP

    # Code smell: no error checking on copy
    cp -r $DEPLOY_DIR/* $BACKUP_DIR/$TIMESTAMP/

    log "Backup created at $BACKUP_DIR/$TIMESTAMP"
}

# Rollback function
rollback() {
    # Code smell: unquoted variable
    local backup_dir=$1

    if [ -z $backup_dir ]; then
        echo "Usage: rollback <backup_dir>"
        return 1
    fi

    # Code smell: no validation of backup directory
    systemctl stop hermes
    cp -r $backup_dir/* $DEPLOY_DIR/
    systemctl start hermes

    log "Rolled back to $backup_dir"
}

deploy
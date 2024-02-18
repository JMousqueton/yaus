#!/bin/bash
LOG_FILE="/var/log/system_maintenance.log"
# Enable or disable debug logging ('true' to enable, 'false' to disable)
DEBUG=false
QUIET=false 

# Function to log messages
log_message() {
    if ! $QUIET; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - INFO - $1" | tee -a "$LOG_FILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - INFO - $1" >> "$LOG_FILE"
    fi
}

# Function to log errors and exit
log_error() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR - $1" | tee -a "$LOG_FILE"
    exit 1
}

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root"
fi

# Update the package lists
log_message "Updating package lists..."
if $DEBUG; then
  apt-get update 2>&1 | tee -a "$LOG_FILE"
else
  apt-get update > /dev/null 2>&1
fi

# Check for errors in the last command
if [ "${PIPESTATUS[0]}" -ne 0 ]; then
  log_error "Failed to update package lists"
fi

# Check if there are packages to be upgraded
upgradable=$(apt list --upgradable 2>/dev/null | wc -l)
let upgradable=upgradable-1

if [ $upgradable -gt 0 ]; then
  log_message "$upgradable packages can be upgraded, proceeding with upgrade."
  if $DEBUG; then
    apt-get -y upgrade 2>&1 | tee -a "$LOG_FILE"
  else
    apt-get -y upgrade > /dev/null 2>&1
  fi

  # Check for errors in the last command
  if [ "${PIPESTATUS[0]}" -ne 0 ]; then
    log_error "Failed to upgrade packages"
  fi
else
  log_message "No packages to upgrade."
fi

# Clean up unused packages and old package versions
log_message "Cleaning up unused packages and old package versions..."
if $DEBUG; then
  apt-get autoremove -y 2>&1 | tee -a "$LOG_FILE"
  apt-get autoclean -y 2>&1 | tee -a "$LOG_FILE"
else
  apt-get autoremove -y > /dev/null 2>&1
  apt-get autoclean -y > /dev/null 2>&1
fi

# Check for errors after cleanup commands
if [ "${PIPESTATUS[0]}" -ne 0 ]; then
  log_error "Failed during cleanup process"
fi

# Check if reboot is needed
if [ -f /var/run/reboot-required ]; then
  log_message 'Reboot required, rebooting now...'
  shutdown -r now
else
  log_message 'No reboot required.'
fi

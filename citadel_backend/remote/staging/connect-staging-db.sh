#!/bin/bash

# SSH tunnel script to connect to staging MySQL database
# This forwards local port 3307 to remote port 3306 (MySQL)
#
# Usage: ./connect-staging-db.sh
#
# After running this script:
# - Remote DB accessible via localhost:3307
# - Local DB (if any) still accessible via localhost:3306
#
# Update your application properties to use:
# spring.datasource.url=jdbc:mysql://localhost:3307/citadel?TimeZone=Asia/Kuala_Lumpur

echo "Starting SSH tunnel to staging database..."
echo "Local port 3307 -> Remote port 3306"
echo "Press Ctrl+C to close the tunnel"
echo ""

# Replace 'user@your-staging-server.com' with your actual SSH connection details
ssh -N -L 3307:localhost:3306 root@188.166.179.190 &

# Store the SSH process ID
SSH_PID=$!

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "Closing SSH tunnel..."
    kill $SSH_PID 2>/dev/null
    exit 0
}

# Trap Ctrl+C and cleanup
trap cleanup INT

# Wait for the SSH process
wait $SSH_PID
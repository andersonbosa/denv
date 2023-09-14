#!/bin/bash
set -e

echo -------------------------------------------------
echo "[$(date)] DENV entrypoint.sh"
echo -------------------------------------------------
# Start the SSH server
service ssh start

# Start the X session
su - denv -c "startx"

su - denv -c "vncserver -geometry 1280x720 :1"

# Keep the container running to prevent it from exiting
tail -f /dev/null

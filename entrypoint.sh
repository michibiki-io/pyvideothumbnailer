#!/bin/bash
set -eo pipefail

# If container is started as root user, restart as non root user
if [ "$(id -u)" = "0" ]; then
    
    USER_ID=${LOCAL_UID:-1000}
    GROUP_ID=${LOCAL_GID:-1000}

    echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
    usermod -u $USER_ID -o pyuser
    groupmod -g $GROUP_ID pyuser
    
    exec gosu pyuser "$BASH_SOURCE" "$@"
fi

exec "$@"

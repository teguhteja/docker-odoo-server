#!/bin/bash
set -e
# Define the MODE variable
MODE='production'

# Execute based on MODE
if [ "$MODE" = "dev" ]; then
    # Execute in development mode with debugpy
    # exec /usr/bin/python3 -m debugpy --listen 0.0.0.0:8888 /usr/bin/odoo -c /etc/odoo/odoo-dev.conf --load=web,queue_job --workers 3 --gevent-port=9090 "$@"
    exec /usr/bin/python3 -m debugpy --listen 0.0.0.0:8888 /usr/bin/odoo -c /etc/odoo/odoo.conf --dev=all "$@"
elif [ "$MODE" = "dev-saas" ]; then
    # Execute in staging mode
    exec /usr/bin/python3 -m debugpy --listen 0.0.0.0:8888 /usr/lib/python3/dist-packages/odoo/odoo-bin -c /etc/odoo/odoo-dev.conf --dev=all "$@"
elif [ "$MODE" = "staging" ]; then
    # Execute in staging mode
    exec /usr/bin/python3 -m debugpy --listen 0.0.0.0:8888 /usr/bin/odoo -c /etc/odoo/odoo.conf "$@"
else
    # Execute in production mode
    exec /usr/bin/odoo -c /etc/odoo/odoo.conf "$@"  
fi
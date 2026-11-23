#!/bin/sh
# Runs once on first cluster init, after 00-app-role.sql creates the erp_app
# role with its upstream dev password. Rotate it to the generated password
# supplied via ERP_APP_PASSWORD, so no dev default reaches production.
# The password is alphanumeric hex, so no shell or SQL quoting is needed.
set -e
if [ -n "$ERP_APP_PASSWORD" ]; then
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" \
    -c "ALTER ROLE erp_app PASSWORD '$ERP_APP_PASSWORD';"
  echo "erp_app password rotated from init script"
fi

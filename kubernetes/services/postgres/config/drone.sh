#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER drone;
    CREATE DATABASE drone;
    GRANT ALL PRIVILEGES ON DATABASE drone TO drone;
EOSQL

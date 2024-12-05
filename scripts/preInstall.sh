#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./langfuse_clickhouse_data
mkdir -p ./langfuse_clickhouse_logs
chmod -R 777 ./langfuse_clickhouse_data
chmod -R 777 ./langfuse_clickhouse_logs

cat <<EOT > ./servers.json
{
    "Servers": {
        "1": {
            "Name": "local",
            "Group": "Servers",
            "Host": "172.17.0.1",
            "Port": 54329,
            "MaintenanceDB": "${POSTGRES_DB}",
            "SSLMode": "prefer",
            "Username": "${POSTGRES_USER}",
            "PassFile": "/pgpass"
        }
    }
}
EOT

ENCRYPTION_KEY=$(openssl rand -hex 32)

cat << EOT >> ./.env

ENCRYPTION_KEY=${ENCRYPTION_KEY}
EOT
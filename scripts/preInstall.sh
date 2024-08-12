#set env vars
set -o allexport; source .env; set +o allexport;

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


# Create User
curl -X POST https://langfuse-saga-u353.vm.elestio.app/api/auth/signup \
-H "Content-Type: application/json" \
-d '{
    "name": "'"$ADMIN_EMAIL"'",
    "email": "'"$ADMIN_EMAIL"'",
    "password": "'"$ADMIN_PASSWORD"'"
}'

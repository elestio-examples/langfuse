#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;

# Create User
curl -X POST "https://${LANGFUSE_WEB_UI}/api/auth/signup" \
-H "Content-Type: application/json" \
-d '{
    "name": "'"$ADMIN_EMAIL"'",
    "email": "'"$ADMIN_EMAIL"'",
    "password": "'"$ADMIN_PASSWORD"'"
}'

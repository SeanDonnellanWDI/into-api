#!/bin/bash

curl "http://localhost:4741/accounts" \
  --include \
  --request POST \
  --header "Authorization: Token token=${TOKEN}" \
  --header "Content-Type: application/json" \
  --data '{
    "account": {
      "service": "'"${SERVICE}"'",
      "username": "'"${USERNAME}"'"
    }
  }'

echo

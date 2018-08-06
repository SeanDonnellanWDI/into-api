#!/bin/bash

curl "http://localhost:4741/accounts/${ID}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "account": {
      "service": "'"${SERVICE}"'",
      "username": "'"${USERNAME}"'"
    }
  }'

echo

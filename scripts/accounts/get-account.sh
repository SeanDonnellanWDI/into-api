#!/bin/bash

curl "http://localhost:4741/accounts/${ID}" \
  --include \
  --request GET

echo

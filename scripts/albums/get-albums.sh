#!/bin/bash

curl "http://localhost:4741/albums" \
  --include \
  --request GET

echo

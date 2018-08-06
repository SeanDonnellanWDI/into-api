#!/bin/bash

# call using :
# ID=3 sh scripts/recipe_ingredients/delete-recipe_ingredients.sh

curl "http://localhost:4741/accounts/${ID}" \
  --include \
  --request DELETE \
  --header "Authorization: Token token=${TOKEN}"

echo

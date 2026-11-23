#!/usr/bin/env bash
# Sets the next word from words.tsv as the GitHub status, keeping Busy/expiry as-is.
set -euo pipefail
cd "$(dirname "$0")"

n=$(grep -c . words.tsv)
i=$(( $(cat next_index 2>/dev/null || echo 0) % n ))
IFS=$'\t' read -r emoji word < <(sed -n "$((i + 1))p" words.tsv)

status=$(gh api graphql -f query='{viewer{status{indicatesLimitedAvailability expiresAt}}}' --jq '.data.viewer.status')
busy=$(jq -r '.indicatesLimitedAvailability // false' <<<"${status:-null}")
expires=$(jq -r '.expiresAt // empty' <<<"${status:-null}")

args=(-f e="$emoji" -f m="$word" -F b="$busy")
var='' input=''
if [[ -n $expires ]]; then args+=(-f x="$expires"); var=',$x:DateTime'; input=',expiresAt:$x'; fi

gh api graphql "${args[@]}" -f query="mutation(\$e:String!,\$m:String!,\$b:Boolean!$var){changeUserStatus(input:{emoji:\$e,message:\$m,limitedAvailability:\$b$input}){status{emoji message indicatesLimitedAvailability expiresAt}}}"

echo $(( (i + 1) % n )) > next_index

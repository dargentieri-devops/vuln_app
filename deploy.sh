#!/bin/bash
source utility.sh

logger "i" "Retrieving secrets"
APP_SECRETS=$(echo "$APP_SECRETS" | sed "s/'/\"/g")
payload="["
for row in $(echo "$APP_SECRETS" | jq -c '.[]'); do
    key=$(echo "$row" | jq -r '.key')
    value=$(echo "$row" | jq -r '.value')
    payload+="{\"key\": \"$key\", \"value\": \"$value\"},"
done
payload="${payload%,}]"

response=$(curl --write-out "%{http_code}" --silent --output response_body.json \
     --request PUT \
     --url "https://api.render.com/v1/services/$RENDER_SERVICE_ID/env-vars" \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --header "Authorization: Bearer $RENDER_TOKEN" \
     --data "$payload")

if [[ "$response" == "200" || "$response" == "201" ]]; then
    logger "i" "APP_SECRETS configured successfully"
else
    logger "e" "Problem setting APP_SECRETS! HTTP Status: $response"
    logger "e" "Response: $(cat response_body.json)"
    exit 1
fi


export name=$(grep -A5 '<groupId>it.devops</groupId>' pom.xml | grep -m1 '<artifactId>' | sed -E 's/.*<artifactId>(.*)<\/artifactId>.*/\1/')
export version=$(grep -A5 '<groupId>it.devops</groupId>' pom.xml | grep -m1 '<version>' | sed -E 's/.*<version>(.*)<\/version>.*/\1/')

if [[ -z "$name" || -z "$version" ]]; then
    logger "e" "Error: Unable to retrieve name or version from pom.xml"
    exit 1
else
    logger "i" "The app name is: $name"
    logger "i" "The app version is: $version"
fi

response=$(curl --write-out "%{http_code}" --silent --output response_body.json \
     --request PATCH \
     --url "https://api.render.com/v1/services/$RENDER_SERVICE_ID" \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --header "Authorization: Bearer $RENDER_TOKEN" \
     --data "{
        \"autoDeploy\": \"yes\",
        \"image\": {
          \"imagePath\": \"docker.io/$DOCKER_USERNAME/$name:$version\",
          \"ownerId\": \"$RENDER_OWNER_ID\"
        },
        \"serviceDetails\": {
          \"pullRequestPreviewsEnabled\": \"no\",
          \"previews\": {
            \"generation\": \"off\"
          }
        }
      }")

if [[ "$response" == "200" || "$response" == "201" ]]; then
    logger "i" "Deploying $name:$version"
else
    logger "e" "Problem setting app name and app version HTTP Status: $response"
    logger "e" "Response: $(cat response_body.json)"
    exit 1
fi

response=$(curl --write-out "%{http_code}" --silent --output response_body.json \
        -X GET "https://api.render.com/deploy/$RENDER_SERVICE_ID?key=$RENDER_SERVICE_KEY")

if [[ "$response" == "200" || "$response" == "201" ]]; then
    logger "i" "App deployed successfully"
else
    logger "e" "Problem deploying app! HTTP Status: $response"
    logger "e" "Response: $(cat response_body.json)"
    exit 1
fi
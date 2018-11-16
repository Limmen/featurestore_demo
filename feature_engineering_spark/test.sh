#!/bin/bash

PORT=$1
PROJECT=$2
PROJECTID=$3

#login
TOKEN=$(curl -i -X POST \
  http://localhost:$PORT/hopsworks-api/api/auth/login \
  -H 'Cache-Control: no-cache' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: f4cba844-380b-4110-900f-571a41ab542e' \
  -d 'email=admin%40kth.se&password=admin' | grep "Authorization: Bearer")

echo $TOKEN

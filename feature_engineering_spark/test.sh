#!/bin/bash

PORT=$1
PROJECT=$2
PROJECTID=$3
FEATURESTOREID=$4
JOBID=$5

#login
TOKEN=$(curl -i -X POST \
  http://localhost:$PORT/hopsworks-api/api/auth/login \
  -H 'Cache-Control: no-cache' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: f4cba844-380b-4110-900f-571a41ab542e' \
  -d 'email=admin%40kth.se&password=admin' | grep "Authorization: Bearer")

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "trx_type_lookup",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/trx.csv",
	"jobId": '4',
	"features": [
		{
			"type": "BIGINT",
			"name": "id",
			"description": "The numeric id of the transaction type",
			"primary": true
		},
		{
			"type": "STRING",
			"name": "trx_type",
			"description": "The categorical transaction type",
			"primary": false
		}
		],
	"description": "lookup table for id to trx_type type, used when converting from numeric to categorical representation and vice verse",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

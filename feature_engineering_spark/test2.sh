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
# create jobs
curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -H "${TOKEN}" \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/'$PROJECT'/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"spark.dynamicAllocation.enabled":false,
	"spark.executor.cores":1,
	"spark.executor.memory":1024,
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"spark.dynamicAllocation.maxExecutors":1500,
	"spark.dynamicAllocation.minExecutors":1,
	"spark.executor.instances":1,
	"spark.dynamicAllocation.initialExecutors":1,
	"spark.executor.gpus":0,
	"appName":"customer_type_lookup_job",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/kyc.csv\" --partitions 1 --version 1 --cluster --featuregroup \"customer_type_lookup\""
}'

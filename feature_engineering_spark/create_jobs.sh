#!/bin/bash

PORT=28759
PROJECT="test"

#login
curl -c cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/auth/login \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: f4cba844-380b-4110-900f-571a41ab542e' \
  -d 'email=admin%40kth.se&password=admin'

# create jobs
curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"customer_type_lookup_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/kyc.csv\" --partitions 1 --version 1 --cluster --featuregroup \"customer_type_lookup\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"pep_lookup_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/kyc.csv\" --partitions 1 --version 1 --cluster --featuregroup \"pep_lookup\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"gender_lookup_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/kyc.csv\" --partitions 1 --version 1 --cluster --featuregroup \"gender_lookup\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"trx_type_lookup_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/trx.csv\" --partitions 1 --version 1 --cluster --featuregroup \"trx_type_lookup\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"country_lookup_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/trx.csv\" --partitions 1 --version 1 --cluster --featuregroup \"country_lookup\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"industry_sector_lookup_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/hipo.csv\" --partitions 1 --version 1 --cluster --featuregroup \"industry_sector_lookup\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"alert_type_lookup_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/alerts.csv\" --partitions 1 --version 1 --cluster --featuregroup \"alert_type_lookup\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"rule_name_lookup_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/alerts.csv\" --partitions 1 --version 1 --cluster --featuregroup \"rule_name_lookup\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"web_address_lookup_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/web_logs.csv\" --partitions 1 --version 1 --cluster --featuregroup \"web_address_lookup\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"browser_action_lookup_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/web_logs.csv\" --partitions 1 --version 1 --cluster --featuregroup \"browser_action_lookup\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"demographic_features_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/kyc.csv\" --partitions 1 --version 1 --cluster --featuregroup \"demographic_features\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"trx_graph_edge_list_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/trx.csv\" --partitions 1 --version 1 --cluster --featuregroup \"trx_graph_edge_list\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"trx_graph_summary_features_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/trx.csv\" --partitions 1 --version 1 --cluster --featuregroup \"trx_graph_summary_features\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"trx_features_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/trx.csv\" --partitions 1 --version 1 --cluster --featuregroup \"trx_features\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"trx_summary_features_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/trx.csv\" --partitions 1 --version 1 --cluster --featuregroup \"trx_summary_features\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"hipo_features_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/hipo.csv\" --partitions 1 --version 1 --cluster --featuregroup \"hipo_features\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"alert_features_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/alerts.csv\" --partitions 1 --version 1 --cluster --featuregroup \"alert_features\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"police_report_features_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/police_reports.csv\" --partitions 1 --version 1 --cluster --featuregroup \"police_report_features\""
}'

curl -b cookie.txt -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/1/jobs/spark \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: 887f91b9-c800-4ee2-bd8c-dd9faa27596d' \
  -d '{
	"type":"sparkJobConfiguration",
	"amMemory":1024,
	"amQueue":"default",
	"amVCores":1,
	"localResources":[],
	"appPath":"hdfs:///Projects/test/Resources/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar",
	"dynamicExecutors":false,
	"executorCores":1,
	"executorMemory":1024,
	"historyServerIp":"10.0.2.15:18080",
	"mainClass":"limmen.github.com.feature_engineering_spark.Main",
	"maxExecutors":1500,
	"minExecutors":1,
	"numberOfExecutors":1,
	"numberOfExecutorsInit":1,
	"numberOfGpusPerExecutor":0,
	"selectedMaxExecutors":10,
	"selectedMinExecutors":1,
	"appName":"web_logs_features_job",
	"flinkjobtype":"Streaming",
	"args":"--input \"hdfs:///Projects/'$PROJECT'/sample_data/web_logs.csv\" --partitions 1 --version 1 --cluster --featuregroup \"web_logs_features\""
}'

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
	"featuregroupName": "customer_type_lookup",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/kyc.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "BIGINT",
			"name": "id",
			"description": "The numeric id of the customer_type",
			"primary": true
		},
		{
			"type": "STRING",
			"name": "customer_type",
			"description": "The categorical customer_type",
			"primary": false
		}
		],
	"description": "lookup table for id to customer type, used when converting from numeric to categrorical representation and vice verse",
        "version": 1,
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null
}'

((JOBID++))


curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "pep_lookup",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/kyc.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "BIGINT",
			"name": "id",
			"description": "The numeric id of the pep_lookup",
			"primary": true
		},
		{
			"type": "STRING",
			"name": "pep",
			"description": "The categorical pep",
			"primary": false
		}
		],
	"description": "lookup table for id to pep type, used when converting from numeric to categrorical representation and vice verse",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "gender_lookup",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/kyc.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "BIGINT",
			"name": "id",
			"description": "The numeric id of the gender",
			"primary": true
		},
		{
			"type": "STRING",
			"name": "gender",
			"description": "The categorical gender",
			"primary": false
		}
		],
	"description": "lookup table for id to gender type, used when converting from numeric to categrorical representation and vice verse",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "trx_type_lookup",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/trx.csv",
	"jobId": '$JOBID',
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

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "country_lookup",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/trx.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "BIGINT",
			"name": "id",
			"description": "The numeric id of the country",
			"primary": true
		},
		{
			"type": "STRING",
			"name": "trx_country",
			"description": "The categorical country",
			"primary": false
		}
		],
	"description": "lookup table for id to country, used when converting from numeric to categorical representation and vice verse",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "industry_sector_lookup",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/hipo.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "BIGINT",
			"name": "id",
			"description": "The numeric id of the industry_sector",
			"primary": true
		},
		{
			"type": "STRING",
			"name": "industry_sector",
			"description": "The categorical industry_sector",
			"primary": false
		}
		],
	"description": "lookup table for id to industry_sector, used when converting from numeric to categorical representation and vice verse",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "alert_type_lookup",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/alerts.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "BIGINT",
			"name": "id",
			"description": "The numeric id of the alert_type",
			"primary": true
		},
		{
			"type": "STRING",
			"name": "alert_type",
			"description": "The categorical alert_type",
			"primary": false
		}
		],
	"description": "lookup table for id to alert_type, used when converting from numeric to categorical representation and vice verse",
	"featureCorrelationMatrix": null,
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "rule_name_lookup",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/alerts.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "BIGINT",
			"name": "id",
			"description": "The numeric id of the rule_name",
			"primary": true
		},
		{
			"type": "STRING",
			"name": "rule_name",
			"description": "The categorical rule_name",
			"primary": false
		}
		],
	"description": "lookup table for id to rule_name of an alert, used when converting from numeric to categorical representation and vice verse",
	"featureCorrelationMatrix": null,
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "web_address_lookup",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/web_logs.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "BIGINT",
			"name": "id",
			"description": "The numeric id of the web_address",
			"primary": true
		},
		{
			"type": "STRING",
			"name": "web_address",
			"description": "The categorical web_address",
			"primary": false
		}
		],
	"description": "lookup table for id to web_address, used when converting from numeric to categorical representation and vice verse",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "browser_action_lookup",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/web_logs.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "BIGINT",
			"name": "id",
			"description": "The numeric id of the browser_action",
			"primary": true
		},
		{
			"type": "STRING",
			"name": "browser_action",
			"description": "The categorical browser_action",
			"primary": false
		}
		],
	"description": "lookup table for id to browser_action, used when converting from numeric to categorical representation and vice verse",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "demographic_features",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/kyc.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "INT",
			"name": "cust_id",
			"description": "The id of the customer",
			"primary": true
		},
		{
			"type": "FLOAT",
			"name": "balance",
			"description": "the balance of the customer",
			"primary": false
		},
		{
			"type": "TIMESTAMP",
			"name": "birthdate",
			"description": "the birthdate of the customer",
			"primary": false
		},
		{
			"type": "BIGINT",
			"name": "customer_type",
			"description": "the type of customer",
			"primary": false
		},
		{
			"type": "BIGINT",
			"name": "gender",
			"description": "the gender of the customer",
			"primary": false
		},
		{
			"type": "TIMESTAMP",
			"name": "join_date",
			"description": "the date that the customer joined Swedbank",
			"primary": false
		},
		{
			"type": "INT",
			"name": "number_of_accounts",
			"description": "the number of Swedbank accounts of the customer",
			"primary": false
		},
		{
			"type": "BIGINT",
			"name": "pep",
			"description": "whether the person is a PEP or not",
			"primary": false
		}
		],
	"description": "preprocessed features from the KYC table",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))


curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "trx_graph_edge_list",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/trx.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "INT",
			"name": "cust_id_1",
			"description": "The customer making the transaction",
			"primary": true
		},
		{
			"type": "INT",
			"name": "cust_id_2",
			"description": "The customer receiving the transaction",
			"primary": false
		},
		{
			"type": "FLOAT",
			"name": "amount",
			"description": "The amount transferred in the transaction",
			"primary": false
		}
		],
	"description": "The edge list of the transactions graph",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "trx_graph_summary_features",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/trx.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "INT",
			"name": "cust_id",
			"description": "Id of the customer",
			"primary": true
		},
		{
			"type": "FLOAT",
			"name": "pagerank",
			"description": "The pagerank of the customer in the transaction graph",
			"primary": false
		},
		{
			"type": "FLOAT",
			"name": "triangle_count",
			"description": "The triangle count of the customer in the transaction graph",
			"primary": false
		}
		],
	"description": "Contain aggregate graph features of a customers transactions",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "trx_features",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/trx.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "INT",
			"name": "trx_id",
			"description": "The id of the transaction",
			"primary": true
		},
		{
			"type": "INT",
			"name": "cust_id_in",
			"description": "The cust_id of the customer making the transaction",
			"primary": false
		},
		{
			"type": "INT",
			"name": "cust_id_out",
			"description": "The id of the customer receiving the transaction",
			"primary": false
		},
		{
			"type": "BIGINT",
			"name": "trx_type",
			"description": "The type of the transaction",
			"primary": false
		},
		{
			"type": "BIGINT",
			"name": "trx_country",
			"description": "The country of the customer making the transaction",
			"primary": false
		},
		{
			"type": "TIMESTAMP",
			"name": "trx_date",
			"description": "The date of the transaction",
			"primary": false
		},
		{
			"type": "Float",
			"name": "trx_amount",
			"description": "The amount of money transferred in the transaction",
			"primary": false
		},
		{
			"type": "INT",
			"name": "trx_bankid",
			"description": "The bankid of the customer making the transaction",
			"primary": false
		},
		{
			"type": "INT",
			"name": "trx_clearingnum",
			"description": "The clearingnumber of the customer making the transaction",
			"primary": false
		}
		],
	"description": "Features for single transactions",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "trx_summary_features",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/trx.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "INT",
			"name": "cust_id",
			"description": "Id of the customer",
			"primary": true
		},
		{
			"type": "FLOAT",
			"name": "min_trx",
			"description": "The minimum transaction amount made by the customer",
			"primary": false
		},
		{
			"type": "FLOAT",
			"name": "max_trx",
			"description": "The maximum transaction amount made by the customer",
			"primary": false
		},
		{
			"type": "FLOAT",
			"name": "avg_trx",
			"description": "The average transaction amount of the customer",
			"primary": false
		},
		{
			"type": "BIGINT",
			"name": "count_trx",
			"description": "The number of transactions made by the customer",
			"primary": false
		}
		],
	"description": "Aggregate of transactions for customers",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "hipo_features",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/hipo.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "INT",
			"name": "corporate_id",
			"description": "id of the corporate customer",
			"primary": true
		},
		{
			"type": "FLOAT",
			"name": "externa_kostnader",
			"description": "The amount paid to external accounts by the corporate",
			"primary": false
		},
		{
			"type": "INT",
			"name": "industry_sector",
			"description": "The line of business of the corporate",
			"primary": false
		},
		{
			"type": "FLOAT",
			"name": "netomsettning_1year",
			"description": "The net turnover for the first year of the corporate",
			"primary": false
		},
		{
			"type": "FLOAT",
			"name": "netomsettning_2year",
			"description": "The net turnover for the frist two years of the corporate",
			"primary": false
		},
		{
			"type": "FLOAT",
			"name": "netomsettning_3year",
			"description": "The net turnover for the first three years of the corporate",
			"primary": false
		}
		],
	"description": "Features on corporate customers",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "alert_features",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/alerts.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "INT",
			"name": "alert_id",
			"description": "The id of the alert",
			"primary": true
		},
		{
			"type": "INT",
			"name": "trx_id",
			"description": "The id of the transaction that was alerted",
			"primary": false
		},
		{
			"type": "TIMESTAMP",
			"name": "alert_date",
			"description": "The date of the alert",
			"primary": false
		},
		{
			"type": "FLOAT",
			"name": "alert_score",
			"description": "The score of the alert indicating how severe the alert was",
			"primary": false
		},
		{
			"type": "INT",
			"name": "alert_type",
			"description": "The type of the alert, e.g TERRORISM",
			"primary": false
		},
		{
			"type": "INT",
			"name": "rule_name",
			"description": "The name of the rule that fired the alert",
			"primary": false
		}
		],
	"description": "Features from transaction alerts",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "police_report_features",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/police_reports.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "INT",
			"name": "cust_id",
			"description": "The id of the reported customer",
			"primary": false
		},
		{
			"type": "TIMESTAMP",
			"name": "report_date",
			"description": "The date the customer was reported",
			"primary": false
		},
		{
			"type": "INT",
			"name": "report_id",
			"description": "The id of the report",
			"primary": true
		}
		],
	"description": "Features on customers reported to the police",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

curl -X POST \
  http://localhost:$PORT/hopsworks-api/api/project/$PROJECTID/featurestores/$FEATURESTOREID/featuregroups \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a91e2f27-8088-4b24-bb17-5c5c0f531a94' \
  -H "${TOKEN}" \
  -d '{
	"featuregroupName": "web_logs_features",
	"inputDataset": "hdfs:///Projects/'$PROJECT'/sample_data/web_logs.csv",
	"jobId": '$JOBID',
	"features": [
		{
			"type": "INT",
			"name": "cust_id",
			"description": "Id of the customer",
			"primary": false
		},
		{
			"type": "INT",
			"name": "web_id",
			"description": "Id of the web activity",
			"primary": true
		},
		{
			"type": "INT",
			"name": "action",
			"description": "The type of web action",
			"primary": false
		},
		{
			"type": "INT",
			"name": "address",
			"description": "IP address used by the customer",
			"primary": false
		},
		{
			"type": "INT",
			"name": "time_spent_seconds",
			"description": "Number of seconds the web session was active",
			"primary": false
		}
		],
	"description": "Features on web logs recording customers activity with the internet bank",
	"featureCorrelationMatrix": null,
	"descriptiveStatistics": null,
	"featuresHistogram": null,
	"clusterAnalysis": null,
	"version": 1
}'

((JOBID++))

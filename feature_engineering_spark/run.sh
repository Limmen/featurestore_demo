#!/bin/bash

$SPARK_HOME/bin/spark-submit \
    --master spark://limmen:7077 \
    --class "limmen.github.com.feature_engineering_spark.Main" \
    --conf spark.executorEnv.JAVA_HOME="$JAVA_HOME" \
    --conf spark.rpc.message.maxSize=2000 \
    --executor-memory 16g \
    --conf spark.cores.max=4 \
    --conf spark.task.cpus=4 \
    /home/kim/workspace/python/featurestore_demo/feature_engineering_spark/target/scala-2.11/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar --input "/home/kim/workspace/python/featurestore_demo/sample_data/web_logs.csv"  --partitions 1 --version 1 --cluster --featuregroup "browser_action_lookup"

#
#"/home/kim/workspace/python/featurestore_demo/sample_data/alerts.csv"
#"alert_type_lookup"
#"/home/kim/workspace/python/featurestore_demo/sample_data/hipo.csv"
# "country_lookup"
# "/home/kim/workspace/python/featurestore_demo/sample_data/trx.csv"
#"trx_type_lookup"
# "/home/kim/workspace/python/featurestore_demo/sample_data/kyc.csv"
#"gender_lookup"
#"pep_lookup"
#"customer_type_lookup"

#    --conf spark.cores.max=4 \
#    --conf spark.task.cpus=4 \
#    --executor-memory 8g \
#    --driver-memory 8g \

#java -jar /home/kim/workspace/python/synthethic_AML_detection/aml_graph/target/scala-2.11/aml_graph-assembly-0.1.0-SNAPSHOT.jar  --input "/home/kim/workspace/python/synthethic_AML_detection/data/cleaned_transactions.csv" --output "/home/kim/workspace/python/synthethic_AML_detection/data/output"


#java -jar /home/kim/workspace/python/featurestore_demo/feature_engineering_spark/target/scala-2.11/feature_engineering_spark-assembly-0.1.0-SNAPSHOT.jar --input "/home/kim/workspace/python/featurestore_demo/sample_data/kyc.csv" --partitions 1 --featuregroup "customer_type_lookup" --version 1

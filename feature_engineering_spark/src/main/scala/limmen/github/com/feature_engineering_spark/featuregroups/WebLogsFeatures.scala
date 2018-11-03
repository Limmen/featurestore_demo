package limmen.github.com.feature_engineering_spark.featuregroup

import org.apache.log4j.{ Level, LogManager, Logger }
import org.apache.spark.sql.SparkSession

/**
 * Contains logic for computing the web_logs_features featuregroup
 */
object WebLogsFeatures {

  case class RawWebLog(
    action: String,
    address: String,
    cust_id: Int,
    time_spent_seconds: Int,
    web_id: Int)

  case class WebLogFeature(
    action: Int,
    address: Int,
    cust_id: Int,
    time_spent_seconds: Int,
    web_id: Int)

  /**
   * Computes the featuregroup
   *
   * @param input path to the input dataset to read (csv)
   * @param output name of the output featuregroup table
   * @param version version of the featuregroup
   * @param partitions number of spark partitions to parallelize the compute on
   * @param logger spark logger
   */
  def computeFeatures(spark: SparkSession, input: String, featuregroupName: String, version: Int, partitions: Int, log: Logger): Unit = {
    log.info(s"Running computeFeatures for featuregroup: ${featuregroupName}")
    val rawDf = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load(input).repartition(partitions)
    log.info("Read raw dataframe")
    import spark.implicits._
    val rawDs = rawDf.as[RawWebLog]
    log.info("Parsed dataframe to dataset")
    val parsedDs = rawDs.map((webLog: RawWebLog) => {
      val action = 1 //placeholder
      val address = 1 //placeholder
      val cust_id = webLog.cust_id
      val time_spent_seconds = webLog.time_spent_seconds
      val web_id = webLog.web_id
      WebLogFeature(action, address, cust_id, time_spent_seconds, web_id)
    })
    log.info("Converted dataset to numeric, feature engineering complete")
    log.info(parsedDs.show(5))
    log.info("Schema: \n" + parsedDs.printSchema)
  }
}

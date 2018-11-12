package limmen.github.com.feature_engineering_spark.featuregroup

import org.apache.log4j.{ Level, LogManager, Logger }
import org.apache.spark.sql.SparkSession
import io.hops.util.Hops
import org.apache.spark.sql.Row

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
    action: Long,
    address: Long,
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
    val featurestore = Hops.getProjectFeaturestore
    val browserActionLookupDf = Hops.getFeaturegroup(spark, "browser_action_lookup", featurestore, 1)
    log.info(browserActionLookupDf.show(5))
    val browserActionLookupList: Array[Row] = browserActionLookupDf.collect
    val browserActionLookupMap = browserActionLookupList.map((row: Row) => {
      row.getAs[String]("browser_action") -> row.getAs[Long]("id")
    }).toMap
    val webAddressLookupDf = Hops.getFeaturegroup(spark, "web_address_lookup", featurestore, 1)
    log.info(webAddressLookupDf.show(5))
    val webAddressLookupList: Array[Row] = webAddressLookupDf.collect
    val webAddressLookupMap = webAddressLookupList.map((row: Row) => {
      row.getAs[String]("web_address") -> row.getAs[Long]("id")
    }).toMap
    val parsedDs = rawDs.map((webLog: RawWebLog) => {
      val action = browserActionLookupMap(webLog.action)
      val address = webAddressLookupMap(webLog.address)
      val cust_id = webLog.cust_id
      val time_spent_seconds = webLog.time_spent_seconds
      val web_id = webLog.web_id
      WebLogFeature(action, address, cust_id, time_spent_seconds, web_id)
    })
    log.info("Converted dataset to numeric, feature engineering complete")
    log.info(parsedDs.show(5))
    log.info("Schema: \n" + parsedDs.printSchema)
    log.info(s"Inserting into featuregroup $featuregroupName version $version in featurestore $featurestore")
    Hops.insertIntoFeaturegroup(parsedDs.toDF, spark, featuregroupName, featurestore, version, "overwrite")
    log.info(s"Insertion into featuregroup $featuregroupName complete")
  }
}

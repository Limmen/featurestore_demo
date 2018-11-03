package limmen.github.com.feature_engineering_spark.featuregroup

import org.apache.log4j.{ Level, LogManager, Logger }
import org.apache.spark.sql.SparkSession
import java.sql.Timestamp

/**
 * Contains logic for computing the alert_features featuregroup
 */
object AlertFeatures {

  case class RawAlert(
    alert_date: String,
    alert_desc: String,
    alert_id: Int,
    alert_score: Double,
    alert_type: String,
    rule_name: String,
    trx_id: Int)

  case class AlertFeature(
    alert_date: Timestamp,
    alert_id: Int,
    alert_score: Float,
    alert_type: Int,
    rule_name: Int,
    trx_id: Int)

  val formatter = new java.text.SimpleDateFormat("yyyy-MM-dd")

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
    val rawDs = rawDf.as[RawAlert]
    log.info("Parsed dataframe to dataset")
    val parsedDs = rawDs.map((alert: RawAlert) => {
      val alertDate = new Timestamp(formatter.parse(alert.alert_date).getTime)
      val alertId = alert.alert_id
      val alertScore = alert.alert_score.toFloat
      val alertType = 1 //placeholder
      val ruleName = 1 //placeholder
      val trxId = alert.trx_id
      AlertFeature(alertDate, alertId, alertScore, alertType, ruleName, trxId)
    })
    log.info("Converted dataset to numeric, feature engineering complete")
    log.info(parsedDs.show(5))
    log.info("Schema: \n" + parsedDs.printSchema)

  }
}

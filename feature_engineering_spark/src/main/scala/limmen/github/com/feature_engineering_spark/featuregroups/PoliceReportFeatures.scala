package limmen.github.com.feature_engineering_spark.featuregroup

import org.apache.log4j.{ Level, LogManager, Logger }
import org.apache.spark.sql.SparkSession
import java.sql.Timestamp

/**
 * Contains logic for computing the PoliceReportFeatures featuregroup
 */
object PoliceReportFeatures {

  case class RawPoliceReport(
    cust_id: Int,
    description: String,
    report_date: String,
    report_id: Int)

  case class PoliceReportFeature(
    cust_id: Int,
    report_date: Timestamp,
    report_id: Int)

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
    val rawDs = rawDf.as[RawPoliceReport]
    log.info("Parsed dataframe to dataset")
    val parsedDs = rawDs.map((report: RawPoliceReport) => {
      val reportDate = new Timestamp(formatter.parse(report.report_date).getTime)
      val custId = report.cust_id
      val reportId = report.report_id
      PoliceReportFeature(custId, reportDate, reportId)
    })
    log.info("Converted dataset to numeric, feature engineering complete")
    log.info(parsedDs.show(5))
    log.info("Schema: \n" + parsedDs.printSchema)
  }
}

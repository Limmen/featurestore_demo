package limmen.github.com.feature_engineering_spark.featuregroup

import org.apache.log4j.{ Level, LogManager, Logger }
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.Row
/**
 * Contains logic for computing the trx_summary_features featuregroup
 */
object TrxSummaryFeatures {

  case class RawTrx(
    cust_id_in: Int,
    cust_id_out: Int,
    trx_amount: Double,
    trx_bankid: Int,
    trx_clearinnum: Int,
    trx_country: String,
    trx_date: String,
    trx_type: String,
    trx_id: Int)

  case class TrxSummaryFeature(
    cust_id: Long,
    min_trx: Float,
    max_trx: Float,
    avg_trx: Float,
    count_trx: Long)

  case class ParsedTrx(
    cust_id: Int,
    amount: Float)

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
    val rawDs = rawDf.as[RawTrx]
    val inTrx = rawDs.map((trx: RawTrx) => {
      ParsedTrx(trx.cust_id_in, trx.trx_amount.toFloat)
    })
    val outTrx = rawDs.map((trx: RawTrx) => {
      ParsedTrx(trx.cust_id_in, trx.trx_amount.toFloat)
    })
    val allTrx = inTrx.unionAll(outTrx)
    log.info(s"Split transaction into two: ${allTrx.show(5)}")
    val min = allTrx.groupBy("cust_id").min("amount")
    log.info(s"min: ${min.show(5)}")
    val max = allTrx.groupBy("cust_id").max("amount")
    val sum = allTrx.groupBy("cust_id").sum("amount")
    log.info(s"max: ${max.show(5)}")
    val count = allTrx.groupBy("cust_id").count
    log.info(s"count: ${count.show(5)}")
    val rawFeaturesDf = min.join(max, "cust_id").join(count, "cust_id").join(sum, "cust_id")
    log.info(s"Joined features: ${rawFeaturesDf.show(5)}")
    log.info(s"Joined features schema: ${rawFeaturesDf.printSchema()}")
    val features = rawFeaturesDf.rdd.map((row: Row) => {
      val min = row.getAs[Float]("min(amount)")
      val max = row.getAs[Float]("max(amount)")
      val sum = row.getAs[Double]("sum(amount)")
      val count = row.getAs[Long]("count")
      val avg = sum.toFloat / count.toFloat
      val custId = row.getAs[Int]("cust_id")
      new TrxSummaryFeature(custId.toLong, min, max, avg, count)
    }).toDS
    log.info(s"Joined parsed features: ${features.show(5)}")
  }
}

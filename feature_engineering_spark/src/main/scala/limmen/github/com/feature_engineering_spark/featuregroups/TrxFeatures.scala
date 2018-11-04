package limmen.github.com.feature_engineering_spark.featuregroup

import org.apache.log4j.{ Level, LogManager, Logger }
import java.sql.Timestamp
import org.apache.spark.sql.SparkSession

/**
 * Contains logic for computing the trx_features featuregroup
 */
object TrxFeatures {

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

  case class TrxFeature(
    cust_id_in: Int,
    trx_type: Int,
    trx_date: Timestamp,
    trx_amount: Float,
    trx_bankid: Int,
    cust_id_out: Int,
    trx_clearingnum: Int,
    trx_country: Int,
    trx_id: Int)

  val formatter = new java.text.SimpleDateFormat("yyyy-MM-dd")

  /**
   * Computes the featuregroup
   *
   * @param input path to the input dataset to read (csv)
   * @param output name of the output featuregroup table
   * @param version version of the featuregroup
   * @param partitions number of spark partitions to parallelize the compute on
   */
  def computeFeatures(spark: SparkSession, input: String, featuregroupName: String, version: Int, partitions: Int, log: Logger): Unit = {
    log.info(s"Running computeFeatures for featuregroup: ${featuregroupName}")
    val rawDf = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load(input).repartition(partitions)
    log.info("Read raw dataframe")
    import spark.implicits._
    val rawDs = rawDf.as[RawTrx]
    log.info("Parsed dataframe to dataset")
    val parsedDs = rawDs.map((trx: RawTrx) => {
      val cust_id_in = trx.cust_id_in
      val cust_id_out = trx.cust_id_out
      val trxDate = new Timestamp(formatter.parse(trx.trx_date).getTime)
      val trx_amount = trx.trx_amount.toFloat
      val trx_bankid = trx.trx_bankid
      val trx_clearingnum = trx.trx_clearinnum
      val trx_country = 1 //placeholder
      val trx_type = 1 //placeholder
      val trx_id = trx.trx_id
      TrxFeature(cust_id_in, trx_type, trxDate, trx_amount, trx_bankid, cust_id_out, trx_clearingnum, trx_country, trx_id)
    })
    log.info("Converted dataset to numeric, feature engineering complete")
    log.info(parsedDs.show(5))
    log.info("Schema: \n" + parsedDs.printSchema)
  }
}

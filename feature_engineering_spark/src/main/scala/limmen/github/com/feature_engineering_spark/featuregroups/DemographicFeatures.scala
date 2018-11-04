package limmen.github.com.feature_engineering_spark.featuregroup

import org.apache.log4j.{ Level, LogManager, Logger }
import org.apache.spark.sql.SparkSession
import java.util.Date
import java.sql.Timestamp
import org.apache.spark.sql.Row

/**
 * Contains logic for computing the demographic_features featuregroup
 */
object DemographicFeatures {

  case class RawParty(
    balance: Double,
    birthdate: String,
    customer_type: String,
    gender: String,
    join_date: String,
    name: String,
    number_of_accounts: Int,
    pep: Boolean,
    cust_id: Int)

  case class ParsedParty(
    balance: Float,
    birthdate: Timestamp,
    customer_type: Long,
    gender: Long,
    join_date: Timestamp,
    number_of_accounts: Int,
    pep: Long,
    cust_id: Int)

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
    log.info("Converting strings into dates")
    import spark.implicits._
    val rawDs = rawDf.as[RawParty]
    log.info("Parsed dataframe to dataset")
    val parsedDs = rawDs.map((party: RawParty) => {
      val balance = party.balance.toFloat
      val birthdate = new Timestamp(formatter.parse(party.birthdate).getTime)
      val customerType = 1 //placeholder
      val gender = 1 //placeholder
      val joinDate = new Timestamp(formatter.parse(party.join_date).getTime)
      val numberOfAccounts = party.number_of_accounts
      val pep = 1 //placeholder
      val cust_id = party.cust_id
      new ParsedParty(balance, birthdate, customerType, gender, joinDate, numberOfAccounts, pep: Long, cust_id)
    })
    log.info("Converted dataset to numeric, feature engineering complete")
    log.info(parsedDs.show(5))
    log.info("Schema: \n" + parsedDs.printSchema)
  }
}

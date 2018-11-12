package limmen.github.com.feature_engineering_spark.featuregroup

import org.apache.log4j.{ Level, LogManager, Logger }
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.Row
import io.hops.util.Hops

/**
 * Contains logic for computing the hipo_features featuregroup
 */
object HiPoFeatures {

  case class RawHipoRow(
    corporate_id: Int,
    externa_kostnader: Double,
    industry_sector: String,
    netomsettning_1year: Double,
    netomsettning_2year: Double,
    netomsettning_3year: Double)

  case class ParsedHipoRow(
    corporate_id: Int,
    externa_kostnader: Float,
    industry_sector: Long,
    netomsettning_1year: Float,
    netomsettning_2year: Float,
    netomsettning_3year: Float)

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
    val rawDs = rawDf.as[RawHipoRow]
    log.info("Parsed dataframe to dataset")
    val featurestore = Hops.getProjectFeaturestore
    val industrySectorLookupDf = Hops.getFeaturegroup(spark, "industry_sector_lookup", featurestore, 1)
    log.info(industrySectorLookupDf.show(5))
    val industrySectorLookupList: Array[Row] = industrySectorLookupDf.collect
    val industrySectorLookupMap = industrySectorLookupList.map((row: Row) => {
      row.getAs[String]("industry_sector") -> row.getAs[Long]("id")
    }).toMap
    val parsedDs = rawDs.map((hipoRow: RawHipoRow) => {
      val corporateId = hipoRow.corporate_id
      val externaKostnader = hipoRow.externa_kostnader.toFloat
      val industrySector = industrySectorLookupMap(hipoRow.industry_sector)
      val netomsettningOneYear = hipoRow.netomsettning_1year.toFloat
      val netomsettningTwoYear = hipoRow.netomsettning_2year.toFloat
      val netomsettningThreeYear = hipoRow.netomsettning_3year.toFloat
      new ParsedHipoRow(corporateId, externaKostnader, industrySector, netomsettningOneYear, netomsettningTwoYear, netomsettningThreeYear)
    })
    log.info("Converted dataset to numeric, feature engineering complete")
    log.info(parsedDs.show(5))
    log.info("Schema: \n" + parsedDs.printSchema)
    log.info(s"Inserting into featuregroup $featuregroupName version $version in featurestore $featurestore")
    Hops.insertIntoFeaturegroup(parsedDs.toDF, spark, featuregroupName, featurestore, version, "overwrite")
    log.info(s"Insertion into featuregroup $featuregroupName complete")
  }
}

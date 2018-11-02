package limmen.github.com.feature_engineering_spark.featuregroup

import org.apache.log4j.{ Level, LogManager, Logger }
import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions.monotonically_increasing_id
import io.hops.util.Hops

/**
 * Contains logic for computing the industry_sector_lookup featuregroup
 */
object IndustrySectorLookup {

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
    val industrySectors = rawDf.select("industry_sector").distinct
    val industrySectorsWithIndex = industrySectors.withColumn("id", monotonically_increasing_id())
    log.info("Extracted industry sectors and mapped to ids:")
    log.info(industrySectorsWithIndex.show(5))
    log.info("Schema: \n" + industrySectorsWithIndex.printSchema)
    val featurestore = Hops.getProjectFeaturestore
    log.info(s"Inserting into featuregroup $featuregroupName version $version in featurestore $featurestore")
    Hops.insertIntoFeaturegroup(industrySectorsWithIndex, spark, featuregroupName, featurestore, version)
    log.info(s"Insertion into featuregroup $featuregroupName complete")
  }
}

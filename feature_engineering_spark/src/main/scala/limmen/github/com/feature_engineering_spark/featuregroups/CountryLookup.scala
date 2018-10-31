package limmen.github.com.feature_engineering_spark.featuregroup

import org.apache.log4j.{ Level, LogManager, Logger }

/**
  * Contains logic for computing the country_lookup featuregroup
  */
object CountryLookup {

  /**
    * Computes the featuregroup
    *
    * @param input path to the input dataset to read (csv)
    * @param output name of the output featuregroup table
    * @param version version of the featuregroup
    * @param partitions number of spark partitions to parallelize the compute on
    * @param logger spark logger
    */
  def computeFeatures(input: String, featuregroupName: String, version: Int, partitions: Int, log:Logger): Unit = {
    log.info(s"Running computeFeatures for featuregroup: ${featuregroupName}")
  }
}

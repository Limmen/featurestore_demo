package limmen.github.com.feature_engineering_spark.featuregroup

/**
  * Contains logic for computing the demographic_features featuregroup
  */
object DemographicFeatures {

  /**
    * Computes the featuregroup
    *
    * @param input path to the input dataset to read (csv)
    * @param output name of the output featuregroup table
    * @param version version of the featuregroup
    * @param partitions number of spark partitions to parallelize the compute on
    */
  def computeFeatures(input: String, featuregroupName: String, version: Int, partitions: Int): Unit = {
  }
}
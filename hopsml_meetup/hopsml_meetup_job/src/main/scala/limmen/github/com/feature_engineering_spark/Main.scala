package limmen.github.com.feature_engineering_spark

import org.apache.log4j.{ Level, LogManager, Logger }
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.{ Row, SparkSession }
import org.apache.spark.{ SparkConf, SparkContext }
import org.rogach.scallop.ScallopConf
import limmen.github.com.feature_engineering_spark._

object Main {

  def main(args: Array[String]): Unit = {

    // Setup logging
    val log = LogManager.getRootLogger()
    log.setLevel(Level.INFO)
    log.info(s"Starting Feature Engineering in Spark to compute Feature groups")

    // Setup Spark
    val sparkConf = sparkClusterSetup()
    val spark = SparkSession.builder().config(sparkConf).enableHiveSupport().getOrCreate();
    val sc = spark.sparkContext

    val clusterStr = sc.getConf.toDebugString
    log.info(s"Cluster settings: \n" + clusterStr)
    log.info("Shutting down spark job")
    spark.close
  }

  /**
   * Hard coded settings for local spark training
   *
   * @return spark configurationh
   */
  def localSparkSetup(): SparkConf = {
    new SparkConf().setAppName("feature_engineering_spark").setMaster("local[*]")
  }

  /**
   * Hard coded settings for cluster spark training
   *
   * @return spark configuration
   */
  def sparkClusterSetup(): SparkConf = {
    new SparkConf().setAppName("feature_engineering_spark").set("spark.executor.heartbeatInterval", "20s").set("spark.rpc.message.maxSize", "512").set("spark.kryoserializer.buffer.max", "1024")
  }
}

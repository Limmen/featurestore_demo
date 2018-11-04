package limmen.github.com.feature_engineering_spark

import org.apache.log4j.{ Level, LogManager, Logger }
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.{ Row, SparkSession }
import org.apache.spark.{ SparkConf, SparkContext }
import org.rogach.scallop.ScallopConf
import limmen.github.com.feature_engineering_spark._

/**
 * Parser of command-line arguments
 */
class Conf(arguments: Seq[String]) extends ScallopConf(arguments) {
  val input = opt[String](required = false, descr = "input path")
  val cluster = opt[Boolean](descr = "Flag set to true means that the application is running in cluster mode, otherwise it runs locally")
  val partitions = opt[Int](required = true, validate = (0<), default = Some(1), descr = "number of partitions to distribute the graph")
  val featuregroup = opt[String](required = true, default = Some("customer_type_lookup"), descr = "which featuregroup to compute")
  val version = opt[Int](required = true, validate = (0<), default = Some(1), descr = "featuregroup version")
  verify()
}

object Main {

  def main(args: Array[String]): Unit = {

    // Setup logging
    val log = LogManager.getRootLogger()
    log.setLevel(Level.INFO)
    log.info(s"Starting Feature Engineering in Spark to compute Feature groups")

    //Parse cmd arguments
    val conf = new Conf(args)

    //Save the configuration string
    val argsStr = printArgs(conf, log)

    // Setup Spark
    var sparkConf: SparkConf = null
    if (conf.cluster()) {
      sparkConf = sparkClusterSetup()
    } else {
      sparkConf = localSparkSetup()
    }

    val spark = SparkSession.builder().config(sparkConf).enableHiveSupport().getOrCreate();

    val sc = spark.sparkContext

    val clusterStr = sc.getConf.toDebugString
    log.info(s"Cluster settings: \n" + clusterStr)

    import spark.implicits._
    conf.featuregroup() match {
      case "customer_type_lookup" => featuregroup.CustomerTypeLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "gender_lookup" => featuregroup.GenderLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "pep_lookup" => featuregroup.PepLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "trx_type_lookup" => featuregroup.TrxTypeLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "country_lookup" => featuregroup.CountryLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "industry_sector_lookup" => featuregroup.IndustrySectorLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "alert_type_lookup" => featuregroup.AlertTypeLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "rule_name_lookup" => featuregroup.RuleNameLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "web_address_lookup" => featuregroup.WebAddressLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "browser_action_lookup" =>
        featuregroup.BrowserActionLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "demographic_features" => featuregroup.DemographicFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "trx_graph_edge_list" => featuregroup.TrxGraphEdgeList.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "trx_graph_summary_features" => featuregroup.TrxGraphSummaryFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "trx_features" => featuregroup.TrxFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "trx_summary_features" => featuregroup.TrxSummaryFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "hipo_features" => featuregroup.HiPoFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "alert_features" => featuregroup.AlertFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "police_report_features" => featuregroup.PoliceReportFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
      case "web_logs_features" => featuregroup.WebLogsFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log)
    }
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

  /**
   * Utility function for printing training configuration
   *
   * @param conf command line arguments
   * @param log logger
   * @return configuration string
   */
  def printArgs(conf: Conf, log: Logger): String = {
    val argsStr = s"Args:  | input: ${conf.input()} | cluster: ${conf.cluster()} | partitions: ${conf.partitions()} |  featuregroup: ${conf.featuregroup()} | version: ${conf.version()}"
    log.info(argsStr)
    argsStr
  }
}

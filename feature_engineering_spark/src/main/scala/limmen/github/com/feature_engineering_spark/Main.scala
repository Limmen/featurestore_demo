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
  val featuregroup = opt[String](required = true, default = Some("all"), descr = "which featuregroup to compute")
  val version = opt[Int](required = true, validate = (0<), default = Some(1), descr = "featuregroup version")
  val create = opt[Boolean](descr = "Flag set to true means that feature groups are created instead of just inserted into")
  val jobid = opt[Int](required = false, validate = (0<), default = None, descr = "jobid for featuregroup")
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
      case "customer_type_lookup" => featuregroup.CustomerTypeLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "gender_lookup" => featuregroup.GenderLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "pep_lookup" => featuregroup.PepLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "trx_type_lookup" => featuregroup.TrxTypeLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "country_lookup" => featuregroup.CountryLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "industry_sector_lookup" => featuregroup.IndustrySectorLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "alert_type_lookup" => featuregroup.AlertTypeLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "rule_name_lookup" => featuregroup.RuleNameLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "web_address_lookup" => featuregroup.WebAddressLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "browser_action_lookup" =>
        featuregroup.BrowserActionLookup.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "demographic_features" => featuregroup.DemographicFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "trx_graph_edge_list" => featuregroup.TrxGraphEdgeList.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "trx_graph_summary_features" => featuregroup.TrxGraphSummaryFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "trx_features" => featuregroup.TrxFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "trx_summary_features" => featuregroup.TrxSummaryFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "hipo_features" => featuregroup.HiPoFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "alert_features" => featuregroup.AlertFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "police_report_features" => featuregroup.PoliceReportFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "web_logs_features" => featuregroup.WebLogsFeatures.computeFeatures(spark, conf.input(), conf.featuregroup(), conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      case "all" => {
        featuregroup.CustomerTypeLookup.computeFeatures(spark, conf.input() + "kyc.csv", "customer_type_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.GenderLookup.computeFeatures(spark, conf.input() + "kyc.csv", "gender_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.PepLookup.computeFeatures(spark, conf.input() + "kyc.csv", "pep_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.TrxTypeLookup.computeFeatures(spark, conf.input() + "trx.csv", "trx_type_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.CountryLookup.computeFeatures(spark, conf.input() + "trx.csv", "country_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.IndustrySectorLookup.computeFeatures(spark, conf.input() + "hipo.csv", "industry_sector_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.AlertTypeLookup.computeFeatures(spark, conf.input() + "alerts.csv", "alert_type_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.RuleNameLookup.computeFeatures(spark, conf.input() + "alerts.csv", "rule_name_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.WebAddressLookup.computeFeatures(spark, conf.input() + "web_logs.csv", "web_address_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.BrowserActionLookup.computeFeatures(spark, conf.input() + "web_logs.csv", "browser_action_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.DemographicFeatures.computeFeatures(spark, conf.input() + "kyc.csv", "demographic_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.TrxGraphEdgeList.computeFeatures(spark, conf.input() + "trx.csv", "trx_graph_edge_list", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.TrxGraphSummaryFeatures.computeFeatures(spark, conf.input() + "trx.csv", "trx_graph_summary_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.TrxFeatures.computeFeatures(spark, conf.input() + "trx.csv", "trx_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.TrxSummaryFeatures.computeFeatures(spark, conf.input() + "trx.csv", "trx_summary_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.HiPoFeatures.computeFeatures(spark, conf.input() + "hipo.csv", "hipo_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.AlertFeatures.computeFeatures(spark, conf.input() + "alerts.csv", "alert_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.PoliceReportFeatures.computeFeatures(spark, conf.input() + "police_reports.csv", "police_report_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.WebLogsFeatures.computeFeatures(spark, conf.input() + "web_logs.csv", "web_logs_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      }
      case "demo" => {
        val customerTypeLookupMap = featuregroup.CustomerTypeLookup.computeFeatures(spark, conf.input() + "kyc.csv", "customer_type_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), keepInMemory = true)
        val genderLookupMap = featuregroup.GenderLookup.computeFeatures(spark, conf.input() + "kyc.csv", "gender_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), keepInMemory = true)
        val pepLookupMap = featuregroup.PepLookup.computeFeatures(spark, conf.input() + "kyc.csv", "pep_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), keepInMemory = true)
        val trxTypeLookupMap = featuregroup.TrxTypeLookup.computeFeatures(spark, conf.input() + "trx.csv", "trx_type_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), keepInMemory = true)
        val countryLookupMap = featuregroup.CountryLookup.computeFeatures(spark, conf.input() + "trx.csv", "country_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), keepInMemory = true)
        val alertTypeLookupMap = featuregroup.AlertTypeLookup.computeFeatures(spark, conf.input() + "alerts.csv", "alert_type_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), keepInMemory = true)
        val ruleNameLookupMap = featuregroup.RuleNameLookup.computeFeatures(spark, conf.input() + "alerts.csv", "rule_name_lookup", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), keepInMemory = true)
        val trxEdgeListDs = featuregroup.TrxGraphEdgeList.computeFeatures(spark, conf.input() + "trx.csv", "trx_graph_edge_list", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), keepInMemory = true)
        featuregroup.DemographicFeatures.computeFeatures(spark, conf.input() + "kyc.csv", "demographic_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), customerTypeLookup = customerTypeLookupMap, genderLookup = genderLookupMap, pepLookup = pepLookupMap)
        featuregroup.TrxGraphSummaryFeatures.computeFeatures(spark, conf.input() + "trx.csv", "trx_graph_summary_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), edgesLookup = trxEdgeListDs)
        featuregroup.TrxFeatures.computeFeatures(spark, conf.input() + "trx.csv", "trx_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), countryLookup = countryLookupMap, trxTypeLookup = trxTypeLookupMap)
        featuregroup.TrxSummaryFeatures.computeFeatures(spark, conf.input() + "trx.csv", "trx_summary_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
        featuregroup.AlertFeatures.computeFeatures(spark, conf.input() + "alerts.csv", "alert_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid(), alertTypeLookup = alertTypeLookupMap, ruleNameLookup = ruleNameLookupMap)
        featuregroup.PoliceReportFeatures.computeFeatures(spark, conf.input() + "police_reports.csv", "police_report_features", conf.version(), conf.partitions(), log, conf.create(), conf.jobid())
      }
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

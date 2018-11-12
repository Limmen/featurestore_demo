package limmen.github.com.feature_engineering_spark.featuregroup

import org.apache.log4j.{ Level, LogManager, Logger }
import org.apache.spark.SparkContext
import org.apache.spark.sql.SparkSession
import org.apache.spark.graphx._
import org.apache.spark.sql.Row
import io.hops.util.Hops

/**
 * Contains logic for computing the trx_graph_summary_features featuregroup
 */
object TrxGraphSummaryFeatures {

  case class TrxEdge(
    cust_id_1: Int,
    cust_id_2: Int,
    amount: Float)

  case class TrxNode(cust_id: Int)

  case class GraphSummaryFeature(
    cust_id: Int,
    pagerank: Float,
    triangle_count: Int)

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
    import spark.implicits._
    /*val edges = List(
      TrxEdge(1, 2, 10.0f),
      TrxEdge(1, 3, 5.0f),
      TrxEdge(1, 4, 10.0f),
      TrxEdge(2, 4, 7.0f),
      TrxEdge(4, 1, 10.0f),
      TrxEdge(5, 2, 10.0f),
      TrxEdge(6, 3, 11.0f),
      TrxEdge(7, 5, 10.0f),
      TrxEdge(8, 5, 14.0f),
      TrxEdge(9, 8, 10.0f),
      TrxEdge(10, 9, 10.0f),
      TrxEdge(10, 1, 15.0f))
     */
    val featurestore = Hops.getProjectFeaturestore
    val edges = Hops.getFeaturegroup(spark, "trx_graph_edge_list", featurestore, 1)
    val edgesDs = edges.as[TrxEdge]
    //spark.sparkContext.parallelize(edges).toDS
    val inNodesDs = edgesDs.map((edge: TrxEdge) => TrxNode(edge.cust_id_1))
    val outNodesDs = edgesDs.map((edge: TrxEdge) => TrxNode(edge.cust_id_2))
    val propertyEdges = edgesDs.map((edge: TrxEdge) => Edge(edge.cust_id_1, edge.cust_id_2, edge))
    val nodesDs = inNodesDs.union(outNodesDs).distinct.map((node: TrxNode) => (node.cust_id.toLong, node))
    log.info(s"Parsed edges:\n ${edgesDs.show(5)}")
    log.info(s"Parsed nodes:\n ${nodesDs.show(5)}")
    val graph = Graph(nodesDs.rdd, propertyEdges.rdd)
    log.info("Graphx graph created")
    log.info("Computing pageranks")
    val alpha = 0.01
    val numIter = 100
    val pageRanks = graph.pageRank(numIter, resetProb = alpha).vertices.toDF
      .withColumnRenamed("_1", "cust_id")
      .withColumnRenamed("_2", "pagerank")
    log.info(s"Pageranks: \n: ${pageRanks.show(5)}")
    log.info("Computing triangle count per node")
    val triangleCounts = graph.triangleCount().vertices.toDF
      .withColumnRenamed("_1", "cust_id")
      .withColumnRenamed("_2", "triangle_count")
    log.info(s"Triangle counts: \n: ${triangleCounts.show(5)}")
    val joined = pageRanks.join(triangleCounts, "cust_id")
    log.info(s"Joined: \n: ${joined.show(5)}")
    log.info(s"Schema: \n: ${joined.printSchema}")
    val features = joined.rdd.map((row: Row) => {
      val cust_id = row.getAs[Long]("cust_id").toInt
      val pagerank = row.getAs[Double]("pagerank").toFloat
      val triangleCount = row.getAs[Int]("triangle_count")
      GraphSummaryFeature(cust_id, pagerank, triangleCount)
    }).toDS
    log.info(s"Features: \n: ${features.show(5)}")
    log.info(s"Inserting into featuregroup $featuregroupName version $version in featurestore $featurestore")
    Hops.insertIntoFeaturegroup(features.toDF, spark, featuregroupName, featurestore, version, "overwrite")
    log.info(s"Insertion into featuregroup $featuregroupName complete")
  }
}

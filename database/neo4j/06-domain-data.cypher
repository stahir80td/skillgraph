// ========================================
// SKILL PATH NAVIGATOR - DATA ENGINEERING DOMAIN
// ========================================
// Run AFTER base domains script
// Creates complete Data Engineering skill tree with modern data stack

// ========================================
// 1. CREATE SUBDOMAINS
// ========================================

CREATE (data_pipelines:SubDomain {
    id: 'sub-data-pipelines',
    name: 'Data Pipelines',
    description: 'ETL/ELT, batch and stream processing, orchestration',
    order: 1
});

CREATE (data_warehousing:SubDomain {
    id: 'sub-data-warehousing',
    name: 'Data Warehousing',
    description: 'Modern data warehouses, lakehouses, data modeling',
    order: 2
});

CREATE (streaming:SubDomain {
    id: 'sub-streaming',
    name: 'Stream Processing',
    description: 'Real-time data processing, event streaming',
    order: 3
});

CREATE (analytics_engineering:SubDomain {
    id: 'sub-analytics-eng',
    name: 'Analytics Engineering',
    description: 'dbt, data modeling, self-service analytics',
    order: 4
});

CREATE (data_governance:SubDomain {
    id: 'sub-data-governance',
    name: 'Data Governance',
    description: 'Data quality, lineage, catalog, privacy',
    order: 5
});

// Connect to domain
MATCH (data:Domain {id: 'domain-data'}), (data_pipelines:SubDomain {id: 'sub-data-pipelines'})
CREATE (data)-[:CONTAINS]->(data_pipelines);

MATCH (data:Domain {id: 'domain-data'}), (data_warehousing:SubDomain {id: 'sub-data-warehousing'})
CREATE (data)-[:CONTAINS]->(data_warehousing);

MATCH (data:Domain {id: 'domain-data'}), (streaming:SubDomain {id: 'sub-streaming'})
CREATE (data)-[:CONTAINS]->(streaming);

MATCH (data:Domain {id: 'domain-data'}), (analytics_engineering:SubDomain {id: 'sub-analytics-eng'})
CREATE (data)-[:CONTAINS]->(analytics_engineering);

MATCH (data:Domain {id: 'domain-data'}), (data_governance:SubDomain {id: 'sub-data-governance'})
CREATE (data)-[:CONTAINS]->(data_governance);

// ========================================
// 2. CREATE DATA PIPELINE SKILLS
// ========================================

CREATE (etl_concepts:Skill {
    id: 'skill-etl-concepts',
    name: 'ETL/ELT Concepts',
    description: 'Extract, Transform, Load patterns and best practices',
    difficulty_level: 'beginner',
    estimated_hours: 30,
    demand_score: 9,
    category: 'data-pipelines',
    last_updated: date('2025-01-15')
});

CREATE (apache_spark:Skill {
    id: 'skill-apache-spark',
    name: 'Apache Spark',
    description: 'Large-scale data processing, PySpark, Spark SQL',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 9,
    category: 'data-pipelines',
    market_insights: 'Essential for big data processing',
    last_updated: date('2025-01-15')
});

CREATE (airflow:Skill {
    id: 'skill-airflow',
    name: 'Apache Airflow',
    description: 'Workflow orchestration, DAGs, scheduling',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 9,
    category: 'data-pipelines',
    market_insights: 'Industry standard for orchestration',
    last_updated: date('2025-01-15')
});

CREATE (dagster:Skill {
    id: 'skill-dagster',
    name: 'Dagster',
    description: 'Modern data orchestration, asset-based pipelines',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 6,
    category: 'data-pipelines',
    market_insights: 'Growing alternative to Airflow',
    last_updated: date('2025-01-15')
});

CREATE (prefect:Skill {
    id: 'skill-prefect',
    name: 'Prefect',
    description: 'Python-native workflow orchestration',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 6,
    category: 'data-pipelines',
    last_updated: date('2025-01-15')
});

CREATE (data_integration:Skill {
    id: 'skill-data-integration',
    name: 'Data Integration Tools',
    description: 'Fivetran, Stitch, Airbyte, CDC patterns',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 7,
    category: 'data-pipelines',
    last_updated: date('2025-01-15')
});

// ========================================
// 3. CREATE DATA WAREHOUSING SKILLS
// ========================================

CREATE (snowflake:Skill {
    id: 'skill-snowflake',
    name: 'Snowflake',
    description: 'Cloud data warehouse, data sharing, zero-copy cloning',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 9,
    category: 'data-warehousing',
    market_insights: 'Leading cloud data warehouse',
    last_updated: date('2025-01-15')
});

CREATE (databricks:Skill {
    id: 'skill-databricks',
    name: 'Databricks',
    description: 'Lakehouse platform, Delta Lake, Unity Catalog',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 8,
    category: 'data-warehousing',
    market_insights: 'Popular for ML and data engineering',
    last_updated: date('2025-01-15')
});

CREATE (bigquery:Skill {
    id: 'skill-bigquery-data',
    name: 'BigQuery',
    description: 'Google serverless data warehouse, ML integration',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'data-warehousing',
    last_updated: date('2025-01-15')
});

CREATE (redshift:Skill {
    id: 'skill-redshift',
    name: 'Amazon Redshift',
    description: 'AWS data warehouse, Spectrum, data sharing',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 7,
    category: 'data-warehousing',
    last_updated: date('2025-01-15')
});

CREATE (data_modeling:Skill {
    id: 'skill-data-modeling',
    name: 'Data Modeling',
    description: 'Dimensional modeling, star schema, data vault',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 9,
    category: 'data-warehousing',
    market_insights: 'Fundamental skill for data architects',
    last_updated: date('2025-01-15')
});

CREATE (delta_lake:Skill {
    id: 'skill-delta-lake',
    name: 'Delta Lake',
    description: 'ACID transactions on data lakes, time travel',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'data-warehousing',
    last_updated: date('2025-01-15')
});

// ========================================
// 4. CREATE STREAMING SKILLS
// ========================================

CREATE (kafka:Skill {
    id: 'skill-kafka',
    name: 'Apache Kafka',
    description: 'Event streaming, topics, producers, consumers',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 8,
    category: 'streaming',
    market_insights: 'De facto standard for event streaming',
    last_updated: date('2025-01-15')
});

CREATE (spark_streaming:Skill {
    id: 'skill-spark-streaming',
    name: 'Spark Streaming',
    description: 'Real-time processing with Spark, structured streaming',
    difficulty_level: 'advanced',
    estimated_hours: 40,
    demand_score: 7,
    category: 'streaming',
    last_updated: date('2025-01-15')
});

CREATE (flink:Skill {
    id: 'skill-flink',
    name: 'Apache Flink',
    description: 'Stream processing framework, stateful computations',
    difficulty_level: 'advanced',
    estimated_hours: 50,
    demand_score: 6,
    category: 'streaming',
    last_updated: date('2025-01-15')
});

CREATE (kinesis:Skill {
    id: 'skill-kinesis',
    name: 'AWS Kinesis',
    description: 'Real-time data streaming on AWS',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'streaming',
    last_updated: date('2025-01-15')
});

CREATE (pubsub:Skill {
    id: 'skill-pubsub',
    name: 'Pub/Sub Systems',
    description: 'GCP Pub/Sub, Azure Event Hubs, message queuing',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'streaming',
    last_updated: date('2025-01-15')
});

// ========================================
// 5. CREATE ANALYTICS ENGINEERING SKILLS
// ========================================

CREATE (dbt:Skill {
    id: 'skill-dbt',
    name: 'dbt (data build tool)',
    description: 'Transform data in warehouse, testing, documentation',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 9,
    category: 'analytics-eng',
    market_insights: 'Must-have for modern data teams',
    last_updated: date('2025-01-15')
});

CREATE (looker:Skill {
    id: 'skill-looker',
    name: 'Looker/LookML',
    description: 'Semantic layer, data modeling for BI',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 7,
    category: 'analytics-eng',
    last_updated: date('2025-01-15')
});

CREATE (tableau:Skill {
    id: 'skill-tableau',
    name: 'Tableau',
    description: 'Data visualization and business intelligence',
    difficulty_level: 'beginner',
    estimated_hours: 30,
    demand_score: 8,
    category: 'analytics-eng',
    last_updated: date('2025-01-15')
});

CREATE (power_bi:Skill {
    id: 'skill-power-bi',
    name: 'Power BI',
    description: 'Microsoft BI tool, DAX, Power Query',
    difficulty_level: 'beginner',
    estimated_hours: 30,
    demand_score: 8,
    category: 'analytics-eng',
    last_updated: date('2025-01-15')
});

// ========================================
// 6. CREATE DATA GOVERNANCE SKILLS
// ========================================

CREATE (data_quality:Skill {
    id: 'skill-data-quality',
    name: 'Data Quality Engineering',
    description: 'Great Expectations, Soda, data validation',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'data-governance',
    market_insights: 'Critical for production data',
    last_updated: date('2025-01-15')
});

CREATE (data_catalog:Skill {
    id: 'skill-data-catalog',
    name: 'Data Cataloging',
    description: 'DataHub, Alation, data discovery',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'data-governance',
    last_updated: date('2025-01-15')
});

CREATE (data_lineage:Skill {
    id: 'skill-data-lineage',
    name: 'Data Lineage',
    description: 'Tracking data flow, impact analysis',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 7,
    category: 'data-governance',
    last_updated: date('2025-01-15')
});

CREATE (data_privacy:Skill {
    id: 'skill-data-privacy',
    name: 'Data Privacy & Compliance',
    description: 'GDPR, CCPA, PII handling, data masking',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'data-governance',
    last_updated: date('2025-01-15')
});

// ========================================
// 7. CONNECT SKILLS TO SUBDOMAINS
// ========================================

// Data Pipelines connections
MATCH (data_pipelines:SubDomain {id: 'sub-data-pipelines'}), (etl_concepts:Skill {id: 'skill-etl-concepts'})
CREATE (data_pipelines)-[:CONTAINS]->(etl_concepts);

MATCH (data_pipelines:SubDomain {id: 'sub-data-pipelines'}), (apache_spark:Skill {id: 'skill-apache-spark'})
CREATE (data_pipelines)-[:CONTAINS]->(apache_spark);

MATCH (data_pipelines:SubDomain {id: 'sub-data-pipelines'}), (airflow:Skill {id: 'skill-airflow'})
CREATE (data_pipelines)-[:CONTAINS]->(airflow);

MATCH (data_pipelines:SubDomain {id: 'sub-data-pipelines'}), (dagster:Skill {id: 'skill-dagster'})
CREATE (data_pipelines)-[:CONTAINS]->(dagster);

MATCH (data_pipelines:SubDomain {id: 'sub-data-pipelines'}), (prefect:Skill {id: 'skill-prefect'})
CREATE (data_pipelines)-[:CONTAINS]->(prefect);

MATCH (data_pipelines:SubDomain {id: 'sub-data-pipelines'}), (data_integration:Skill {id: 'skill-data-integration'})
CREATE (data_pipelines)-[:CONTAINS]->(data_integration);

// Data Warehousing connections
MATCH (data_warehousing:SubDomain {id: 'sub-data-warehousing'}), (snowflake:Skill {id: 'skill-snowflake'})
CREATE (data_warehousing)-[:CONTAINS]->(snowflake);

MATCH (data_warehousing:SubDomain {id: 'sub-data-warehousing'}), (databricks:Skill {id: 'skill-databricks'})
CREATE (data_warehousing)-[:CONTAINS]->(databricks);

MATCH (data_warehousing:SubDomain {id: 'sub-data-warehousing'}), (bigquery:Skill {id: 'skill-bigquery-data'})
CREATE (data_warehousing)-[:CONTAINS]->(bigquery);

MATCH (data_warehousing:SubDomain {id: 'sub-data-warehousing'}), (redshift:Skill {id: 'skill-redshift'})
CREATE (data_warehousing)-[:CONTAINS]->(redshift);

MATCH (data_warehousing:SubDomain {id: 'sub-data-warehousing'}), (data_modeling:Skill {id: 'skill-data-modeling'})
CREATE (data_warehousing)-[:CONTAINS]->(data_modeling);

MATCH (data_warehousing:SubDomain {id: 'sub-data-warehousing'}), (delta_lake:Skill {id: 'skill-delta-lake'})
CREATE (data_warehousing)-[:CONTAINS]->(delta_lake);

// Streaming connections
MATCH (streaming:SubDomain {id: 'sub-streaming'}), (kafka:Skill {id: 'skill-kafka'})
CREATE (streaming)-[:CONTAINS]->(kafka);

MATCH (streaming:SubDomain {id: 'sub-streaming'}), (spark_streaming:Skill {id: 'skill-spark-streaming'})
CREATE (streaming)-[:CONTAINS]->(spark_streaming);

MATCH (streaming:SubDomain {id: 'sub-streaming'}), (flink:Skill {id: 'skill-flink'})
CREATE (streaming)-[:CONTAINS]->(flink);

MATCH (streaming:SubDomain {id: 'sub-streaming'}), (kinesis:Skill {id: 'skill-kinesis'})
CREATE (streaming)-[:CONTAINS]->(kinesis);

MATCH (streaming:SubDomain {id: 'sub-streaming'}), (pubsub:Skill {id: 'skill-pubsub'})
CREATE (streaming)-[:CONTAINS]->(pubsub);

// Analytics Engineering connections
MATCH (analytics_engineering:SubDomain {id: 'sub-analytics-eng'}), (dbt:Skill {id: 'skill-dbt'})
CREATE (analytics_engineering)-[:CONTAINS]->(dbt);

MATCH (analytics_engineering:SubDomain {id: 'sub-analytics-eng'}), (looker:Skill {id: 'skill-looker'})
CREATE (analytics_engineering)-[:CONTAINS]->(looker);

MATCH (analytics_engineering:SubDomain {id: 'sub-analytics-eng'}), (tableau:Skill {id: 'skill-tableau'})
CREATE (analytics_engineering)-[:CONTAINS]->(tableau);

MATCH (analytics_engineering:SubDomain {id: 'sub-analytics-eng'}), (power_bi:Skill {id: 'skill-power-bi'})
CREATE (analytics_engineering)-[:CONTAINS]->(power_bi);

// Data Governance connections
MATCH (data_governance:SubDomain {id: 'sub-data-governance'}), (data_quality:Skill {id: 'skill-data-quality'})
CREATE (data_governance)-[:CONTAINS]->(data_quality);

MATCH (data_governance:SubDomain {id: 'sub-data-governance'}), (data_catalog:Skill {id: 'skill-data-catalog'})
CREATE (data_governance)-[:CONTAINS]->(data_catalog);

MATCH (data_governance:SubDomain {id: 'sub-data-governance'}), (data_lineage:Skill {id: 'skill-data-lineage'})
CREATE (data_governance)-[:CONTAINS]->(data_lineage);

MATCH (data_governance:SubDomain {id: 'sub-data-governance'}), (data_privacy:Skill {id: 'skill-data-privacy'})
CREATE (data_governance)-[:CONTAINS]->(data_privacy);

// ========================================
// 8. CREATE SKILL PREREQUISITES
// ========================================

// SQL is prerequisite for almost everything in data
MATCH (snowflake:Skill {id: 'skill-snowflake'}), (sql:Skill {id: 'skill-sql'})
CREATE (snowflake)-[:REQUIRES]->(sql);

MATCH (bigquery:Skill {id: 'skill-bigquery-data'}), (sql:Skill {id: 'skill-sql'})
CREATE (bigquery)-[:REQUIRES]->(sql);

MATCH (redshift:Skill {id: 'skill-redshift'}), (sql:Skill {id: 'skill-sql'})
CREATE (redshift)-[:REQUIRES]->(sql);

MATCH (dbt:Skill {id: 'skill-dbt'}), (sql:Skill {id: 'skill-sql'})
CREATE (dbt)-[:REQUIRES]->(sql);

MATCH (data_modeling:Skill {id: 'skill-data-modeling'}), (sql:Skill {id: 'skill-sql'})
CREATE (data_modeling)-[:REQUIRES]->(sql);

MATCH (apache_spark:Skill {id: 'skill-apache-spark'}), (sql:Skill {id: 'skill-sql'})
CREATE (apache_spark)-[:REQUIRES]->(sql);

// Python prerequisites
MATCH (apache_spark:Skill {id: 'skill-apache-spark'}), (python:Skill {id: 'skill-python'})
CREATE (apache_spark)-[:REQUIRES]->(python);

MATCH (airflow:Skill {id: 'skill-airflow'}), (python:Skill {id: 'skill-python'})
CREATE (airflow)-[:REQUIRES]->(python);

MATCH (dagster:Skill {id: 'skill-dagster'}), (python:Skill {id: 'skill-python'})
CREATE (dagster)-[:REQUIRES]->(python);

MATCH (prefect:Skill {id: 'skill-prefect'}), (python:Skill {id: 'skill-python'})
CREATE (prefect)-[:REQUIRES]->(python);

// Data pipeline prerequisites
MATCH (spark_streaming:Skill {id: 'skill-spark-streaming'}), (apache_spark:Skill {id: 'skill-apache-spark'})
CREATE (spark_streaming)-[:REQUIRES]->(apache_spark);

MATCH (data_integration:Skill {id: 'skill-data-integration'}), (etl_concepts:Skill {id: 'skill-etl-concepts'})
CREATE (data_integration)-[:REQUIRES]->(etl_concepts);

// Warehousing prerequisites
MATCH (delta_lake:Skill {id: 'skill-delta-lake'}), (apache_spark:Skill {id: 'skill-apache-spark'})
CREATE (delta_lake)-[:REQUIRES]->(apache_spark);

MATCH (databricks:Skill {id: 'skill-databricks'}), (apache_spark:Skill {id: 'skill-apache-spark'})
CREATE (databricks)-[:REQUIRES]->(apache_spark);

// Analytics Engineering prerequisites
MATCH (dbt:Skill {id: 'skill-dbt'}), (data_modeling:Skill {id: 'skill-data-modeling'})
CREATE (dbt)-[:REQUIRES]->(data_modeling);

MATCH (looker:Skill {id: 'skill-looker'}), (sql:Skill {id: 'skill-sql'})
CREATE (looker)-[:REQUIRES]->(sql);

MATCH (tableau:Skill {id: 'skill-tableau'}), (sql:Skill {id: 'skill-sql'})
CREATE (tableau)-[:REQUIRES]->(sql);

MATCH (power_bi:Skill {id: 'skill-power-bi'}), (sql:Skill {id: 'skill-sql'})
CREATE (power_bi)-[:REQUIRES]->(sql);

// Data Governance prerequisites
MATCH (data_quality:Skill {id: 'skill-data-quality'}), (python:Skill {id: 'skill-python'})
CREATE (data_quality)-[:REQUIRES]->(python);

MATCH (data_lineage:Skill {id: 'skill-data-lineage'}), (data_modeling:Skill {id: 'skill-data-modeling'})
CREATE (data_lineage)-[:REQUIRES]->(data_modeling);

// ========================================
// 9. CREATE SKILL PROGRESSIONS
// ========================================

MATCH (sql:Skill {id: 'skill-sql'}), (data_modeling:Skill {id: 'skill-data-modeling'})
CREATE (sql)-[:LEADS_TO]->(data_modeling);

MATCH (data_modeling:Skill {id: 'skill-data-modeling'}), (dbt:Skill {id: 'skill-dbt'})
CREATE (data_modeling)-[:LEADS_TO]->(dbt);

MATCH (etl_concepts:Skill {id: 'skill-etl-concepts'}), (airflow:Skill {id: 'skill-airflow'})
CREATE (etl_concepts)-[:LEADS_TO]->(airflow);

MATCH (apache_spark:Skill {id: 'skill-apache-spark'}), (databricks:Skill {id: 'skill-databricks'})
CREATE (apache_spark)-[:LEADS_TO]->(databricks);

MATCH (apache_spark:Skill {id: 'skill-apache-spark'}), (spark_streaming:Skill {id: 'skill-spark-streaming'})
CREATE (apache_spark)-[:LEADS_TO]->(spark_streaming);

MATCH (kafka:Skill {id: 'skill-kafka'}), (spark_streaming:Skill {id: 'skill-spark-streaming'})
CREATE (kafka)-[:LEADS_TO]->(spark_streaming);

MATCH (snowflake:Skill {id: 'skill-snowflake'}), (dbt:Skill {id: 'skill-dbt'})
CREATE (snowflake)-[:LEADS_TO]->(dbt);

MATCH (dbt:Skill {id: 'skill-dbt'}), (data_quality:Skill {id: 'skill-data-quality'})
CREATE (dbt)-[:LEADS_TO]->(data_quality);

// ========================================
// 10. CREATE CERTIFICATIONS
// ========================================

CREATE (gcp_pde:Certification {
    id: 'cert-gcp-pde',
    name: 'Google Cloud Professional Data Engineer',
    provider: 'Google',
    level: 'professional',
    cost: 200,
    validity_period: '2 years',
    estimated_prep_hours: 80,
    difficulty_rating: 7,
    market_value: 'very-high',
    url: 'https://cloud.google.com/certification/data-engineer',
    exam_format: 'Multiple choice, 120 minutes'
});

CREATE (aws_data_analytics:Certification {
    id: 'cert-aws-data-analytics',
    name: 'AWS Data Analytics Specialty',
    provider: 'AWS',
    level: 'specialty',
    cost: 300,
    validity_period: '3 years',
    estimated_prep_hours: 80,
    difficulty_rating: 7,
    market_value: 'high',
    url: 'https://aws.amazon.com/certification/certified-data-analytics-specialty/',
    exam_format: 'Multiple choice, 180 minutes'
});

CREATE (az_dp_203:Certification {
    id: 'cert-az-dp-203',
    name: 'Azure Data Engineer Associate',
    provider: 'Microsoft',
    level: 'associate',
    cost: 165,
    validity_period: '1 year',
    estimated_prep_hours: 60,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://learn.microsoft.com/certifications/azure-data-engineer/',
    exam_format: 'Multiple choice, 150 minutes'
});

CREATE (az_dp_700:Certification {
    id: 'cert-az-dp-700',
    name: 'Microsoft Fabric Analytics Engineer',
    provider: 'Microsoft',
    level: 'associate',
    cost: 165,
    validity_period: '1 year',
    estimated_prep_hours: 50,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://learn.microsoft.com/certifications/fabric-analytics-engineer-associate/',
    exam_format: 'Multiple choice, 120 minutes'
});

CREATE (snowflake_core:Certification {
    id: 'cert-snowflake-core',
    name: 'SnowPro Core',
    provider: 'Snowflake',
    level: 'associate',
    cost: 175,
    validity_period: '2 years',
    estimated_prep_hours: 40,
    difficulty_rating: 5,
    market_value: 'high',
    url: 'https://www.snowflake.com/certifications/',
    exam_format: 'Multiple choice, 115 minutes'
});

CREATE (snowflake_architect:Certification {
    id: 'cert-snowflake-architect',
    name: 'SnowPro Advanced Architect',
    provider: 'Snowflake',
    level: 'advanced',
    cost: 375,
    validity_period: '2 years',
    estimated_prep_hours: 80,
    difficulty_rating: 8,
    market_value: 'very-high',
    url: 'https://www.snowflake.com/certifications/',
    exam_format: 'Multiple choice, 120 minutes'
});

CREATE (databricks_engineer:Certification {
    id: 'cert-databricks-engineer',
    name: 'Databricks Data Engineer Associate',
    provider: 'Databricks',
    level: 'associate',
    cost: 200,
    validity_period: '2 years',
    estimated_prep_hours: 50,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://www.databricks.com/learn/certification/data-engineer-associate',
    exam_format: 'Multiple choice, 90 minutes'
});

CREATE (dbt_analytics:Certification {
    id: 'cert-dbt-analytics',
    name: 'dbt Analytics Engineering',
    provider: 'dbt Labs',
    level: 'professional',
    cost: 150,
    validity_period: '2 years',
    estimated_prep_hours: 30,
    difficulty_rating: 5,
    market_value: 'medium',
    url: 'https://www.getdbt.com/product/dbt-certification/',
    exam_format: 'Multiple choice, 90 minutes'
});

CREATE (tableau_desktop:Certification {
    id: 'cert-tableau-desktop',
    name: 'Tableau Desktop Specialist',
    provider: 'Tableau',
    level: 'specialist',
    cost: 100,
    validity_period: 'lifetime',
    estimated_prep_hours: 30,
    difficulty_rating: 4,
    market_value: 'medium',
    url: 'https://www.tableau.com/learn/certification',
    exam_format: 'Multiple choice, 60 minutes'
});

// Connect certifications to skills
MATCH (gcp_pde:Certification {id: 'cert-gcp-pde'}), (bigquery:Skill {id: 'skill-bigquery-data'})
CREATE (gcp_pde)-[:REQUIRES]->(bigquery);

MATCH (gcp_pde:Certification {id: 'cert-gcp-pde'}), (data_modeling:Skill {id: 'skill-data-modeling'})
CREATE (gcp_pde)-[:REQUIRES]->(data_modeling);

MATCH (aws_data_analytics:Certification {id: 'cert-aws-data-analytics'}), (redshift:Skill {id: 'skill-redshift'})
CREATE (aws_data_analytics)-[:REQUIRES]->(redshift);

MATCH (aws_data_analytics:Certification {id: 'cert-aws-data-analytics'}), (kinesis:Skill {id: 'skill-kinesis'})
CREATE (aws_data_analytics)-[:REQUIRES]->(kinesis);

MATCH (az_dp_203:Certification {id: 'cert-az-dp-203'}), (azure_fundamentals:Skill {id: 'skill-azure-fundamentals'})
WHERE exists((azure_fundamentals))
CREATE (az_dp_203)-[:REQUIRES]->(azure_fundamentals);

MATCH (snowflake_core:Certification {id: 'cert-snowflake-core'}), (snowflake:Skill {id: 'skill-snowflake'})
CREATE (snowflake_core)-[:REQUIRES]->(snowflake);

MATCH (snowflake_architect:Certification {id: 'cert-snowflake-architect'}), (snowflake:Skill {id: 'skill-snowflake'})
CREATE (snowflake_architect)-[:REQUIRES]->(snowflake);

MATCH (databricks_engineer:Certification {id: 'cert-databricks-engineer'}), (databricks:Skill {id: 'skill-databricks'})
CREATE (databricks_engineer)-[:REQUIRES]->(databricks);

MATCH (dbt_analytics:Certification {id: 'cert-dbt-analytics'}), (dbt:Skill {id: 'skill-dbt'})
CREATE (dbt_analytics)-[:REQUIRES]->(dbt);

MATCH (tableau_desktop:Certification {id: 'cert-tableau-desktop'}), (tableau:Skill {id: 'skill-tableau'})
CREATE (tableau_desktop)-[:REQUIRES]->(tableau);

// Certification progressions
MATCH (snowflake_core:Certification {id: 'cert-snowflake-core'}), (snowflake_architect:Certification {id: 'cert-snowflake-architect'})
CREATE (snowflake_core)-[:LEADS_TO]->(snowflake_architect);

// Connect certifications to domain
MATCH (gcp_pde:Certification {id: 'cert-gcp-pde'}), (data:Domain {id: 'domain-data'})
CREATE (gcp_pde)-[:RECOMMENDED_FOR]->(data);

MATCH (snowflake_architect:Certification {id: 'cert-snowflake-architect'}), (data:Domain {id: 'domain-data'})
CREATE (snowflake_architect)-[:RECOMMENDED_FOR]->(data);

MATCH (databricks_engineer:Certification {id: 'cert-databricks-engineer'}), (data:Domain {id: 'domain-data'})
CREATE (databricks_engineer)-[:RECOMMENDED_FOR]->(data);

// ========================================
// 11. CREATE RESOURCES
// ========================================

// Data Engineering Books
CREATE (data_eng_book:Resource {
    id: 'res-data-eng-book',
    title: 'Fundamentals of Data Engineering',
    url: 'https://www.oreilly.com/library/view/fundamentals-of-data/9781098108298/',
    type: 'book',
    platform: 'OReilly',
    duration: '30 hours',
    rating: 4.8,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (designing_data:Resource {
    id: 'res-designing-data',
    title: 'Designing Data-Intensive Applications',
    url: 'https://dataintensive.net/',
    type: 'book',
    platform: 'OReilly',
    duration: '40 hours',
    rating: 4.9,
    price: 'paid',
    difficulty_level: 'advanced',
    learning_style: 'reading'
});

// Spark Resources
CREATE (spark_definitive:Resource {
    id: 'res-spark-definitive',
    title: 'Spark: The Definitive Guide',
    url: 'https://www.oreilly.com/library/view/spark-the-definitive/9781491912201/',
    type: 'book',
    platform: 'OReilly',
    duration: '35 hours',
    rating: 4.7,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (spark_coursera:Resource {
    id: 'res-spark-coursera',
    title: 'Big Data with Apache Spark',
    url: 'https://www.coursera.org/learn/apache-spark',
    type: 'video',
    platform: 'Coursera',
    duration: '40 hours',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'visual'
});

// Airflow Resources
CREATE (airflow_docs:Resource {
    id: 'res-airflow-docs',
    title: 'Apache Airflow Documentation',
    url: 'https://airflow.apache.org/docs/',
    type: 'doc',
    platform: 'Apache',
    duration: 'self-paced',
    rating: 4.4,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (airflow_astronomer:Resource {
    id: 'res-airflow-astronomer',
    title: 'Astronomer Airflow Guides',
    url: 'https://www.astronomer.io/guides/',
    type: 'guide',
    platform: 'Astronomer',
    duration: 'self-paced',
    rating: 4.6,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// Snowflake Resources
CREATE (snowflake_docs:Resource {
    id: 'res-snowflake-docs',
    title: 'Snowflake Documentation',
    url: 'https://docs.snowflake.com/',
    type: 'doc',
    platform: 'Snowflake',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (snowflake_course:Resource {
    id: 'res-snowflake-course',
    title: 'Snowflake: The Complete Masterclass',
    url: 'https://www.udemy.com/course/snowflake-masterclass/',
    type: 'video',
    platform: 'Udemy',
    duration: '15 hours',
    rating: 4.6,
    price: 'paid',
    difficulty_level: 'beginner',
    learning_style: 'visual'
});

// dbt Resources
CREATE (dbt_docs:Resource {
    id: 'res-dbt-docs',
    title: 'dbt Documentation',
    url: 'https://docs.getdbt.com/',
    type: 'doc',
    platform: 'dbt Labs',
    duration: 'self-paced',
    rating: 4.7,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (dbt_course:Resource {
    id: 'res-dbt-course',
    title: 'dbt Fundamentals',
    url: 'https://courses.getdbt.com/courses/fundamentals',
    type: 'course',
    platform: 'dbt Labs',
    duration: '8 hours',
    rating: 4.8,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'mixed'
});

// Kafka Resources
CREATE (kafka_definitive:Resource {
    id: 'res-kafka-definitive',
    title: 'Kafka: The Definitive Guide',
    url: 'https://www.oreilly.com/library/view/kafka-the-definitive/9781491936153/',
    type: 'book',
    platform: 'OReilly',
    duration: '25 hours',
    rating: 4.6,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// Connect resources to skills
MATCH (etl_concepts:Skill {id: 'skill-etl-concepts'}), (data_eng_book:Resource {id: 'res-data-eng-book'})
CREATE (etl_concepts)-[:HAS_RESOURCE]->(data_eng_book);

MATCH (apache_spark:Skill {id: 'skill-apache-spark'}), (spark_definitive:Resource {id: 'res-spark-definitive'})
CREATE (apache_spark)-[:HAS_RESOURCE]->(spark_definitive);

MATCH (apache_spark:Skill {id: 'skill-apache-spark'}), (spark_coursera:Resource {id: 'res-spark-coursera'})
CREATE (apache_spark)-[:HAS_RESOURCE]->(spark_coursera);

MATCH (airflow:Skill {id: 'skill-airflow'}), (airflow_docs:Resource {id: 'res-airflow-docs'})
CREATE (airflow)-[:HAS_RESOURCE]->(airflow_docs);

MATCH (airflow:Skill {id: 'skill-airflow'}), (airflow_astronomer:Resource {id: 'res-airflow-astronomer'})
CREATE (airflow)-[:HAS_RESOURCE]->(airflow_astronomer);

MATCH (snowflake:Skill {id: 'skill-snowflake'}), (snowflake_docs:Resource {id: 'res-snowflake-docs'})
CREATE (snowflake)-[:HAS_RESOURCE]->(snowflake_docs);

MATCH (snowflake:Skill {id: 'skill-snowflake'}), (snowflake_course:Resource {id: 'res-snowflake-course'})
CREATE (snowflake)-[:HAS_RESOURCE]->(snowflake_course);

MATCH (dbt:Skill {id: 'skill-dbt'}), (dbt_docs:Resource {id: 'res-dbt-docs'})
CREATE (dbt)-[:HAS_RESOURCE]->(dbt_docs);

MATCH (dbt:Skill {id: 'skill-dbt'}), (dbt_course:Resource {id: 'res-dbt-course'})
CREATE (dbt)-[:HAS_RESOURCE]->(dbt_course);

MATCH (kafka:Skill {id: 'skill-kafka'}), (kafka_definitive:Resource {id: 'res-kafka-definitive'})
CREATE (kafka)-[:HAS_RESOURCE]->(kafka_definitive);

MATCH (databricks:Skill {id: 'skill-databricks'}), (spark_definitive:Resource {id: 'res-spark-definitive'})
CREATE (databricks)-[:HAS_RESOURCE]->(spark_definitive);

// ========================================
// CROSS-DOMAIN RELATIONSHIPS
// ========================================

// Data Engineering bridges to AI/ML
MATCH (databricks:Skill {id: 'skill-databricks'}), (ai:Domain {id: 'domain-ai-ml'})
CREATE (databricks)-[:APPLIES_IN]->(ai);

MATCH (bigquery:Skill {id: 'skill-bigquery-data'}), (ai:Domain {id: 'domain-ai-ml'})
CREATE (bigquery)-[:APPLIES_IN]->(ai);

// Analytics Engineering bridges to Software Engineering
MATCH (looker:Skill {id: 'skill-looker'}), (software:Domain {id: 'domain-software'})
CREATE (looker)-[:APPLIES_IN]->(software);

// Data Quality bridges to SRE
MATCH (data_quality:Skill {id: 'skill-data-quality'}), (sre:Domain {id: 'domain-sre'})
CREATE (data_quality)-[:APPLIES_IN]->(sre);

// Data Privacy bridges to Security
MATCH (data_privacy:Skill {id: 'skill-data-privacy'}), (security:Domain {id: 'domain-security'})
CREATE (data_privacy)-[:APPLIES_IN]->(security);

// ========================================
// VERIFICATION QUERY
// ========================================
// Run to verify Data Engineering domain is loaded:
// MATCH (d:Domain {id: 'domain-data'})-[:CONTAINS]->(sd:SubDomain)-[:CONTAINS]->(s:Skill) 
// RETURN d.name, sd.name, count(s) as skill_count;
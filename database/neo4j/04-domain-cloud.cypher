// ========================================
// SKILL PATH NAVIGATOR - CLOUD & INFRASTRUCTURE DOMAIN
// ========================================
// Run AFTER base domains script
// Creates complete Cloud skill tree with AWS, Azure, GCP, and Cloud Native

// ========================================
// 1. CREATE SUBDOMAINS
// ========================================

CREATE (aws_cloud:SubDomain {
    id: 'sub-aws',
    name: 'AWS',
    description: 'Amazon Web Services - Market leader with 31% share',
    order: 1
});

CREATE (azure_cloud:SubDomain {
    id: 'sub-azure',
    name: 'Microsoft Azure',
    description: 'Microsoft Azure - Enterprise favorite with 22% share',
    order: 2
});

CREATE (gcp_cloud:SubDomain {
    id: 'sub-gcp',
    name: 'Google Cloud Platform',
    description: 'Google Cloud - Growing fast, strong in AI/ML and analytics',
    order: 3
});

CREATE (cloud_native:SubDomain {
    id: 'sub-cloud-native',
    name: 'Cloud Native',
    description: 'Kubernetes, Serverless, Service Mesh - Platform agnostic',
    order: 4
});

CREATE (multi_cloud:SubDomain {
    id: 'sub-multi-cloud',
    name: 'Multi-Cloud Architecture',
    description: 'Cross-cloud strategies, FinOps, cloud governance',
    order: 5
});

// Connect to domain
MATCH (cloud:Domain {id: 'domain-cloud'}), (aws_cloud:SubDomain {id: 'sub-aws'})
CREATE (cloud)-[:CONTAINS]->(aws_cloud);

MATCH (cloud:Domain {id: 'domain-cloud'}), (azure_cloud:SubDomain {id: 'sub-azure'})
CREATE (cloud)-[:CONTAINS]->(azure_cloud);

MATCH (cloud:Domain {id: 'domain-cloud'}), (gcp_cloud:SubDomain {id: 'sub-gcp'})
CREATE (cloud)-[:CONTAINS]->(gcp_cloud);

MATCH (cloud:Domain {id: 'domain-cloud'}), (cloud_native:SubDomain {id: 'sub-cloud-native'})
CREATE (cloud)-[:CONTAINS]->(cloud_native);

MATCH (cloud:Domain {id: 'domain-cloud'}), (multi_cloud:SubDomain {id: 'sub-multi-cloud'})
CREATE (cloud)-[:CONTAINS]->(multi_cloud);

// ========================================
// 2. CREATE AWS SKILLS
// ========================================

CREATE (aws_fundamentals:Skill {
    id: 'skill-aws-fundamentals',
    name: 'AWS Fundamentals',
    description: 'EC2, S3, VPC, IAM - Core AWS services',
    difficulty_level: 'beginner',
    estimated_hours: 40,
    demand_score: 9,
    category: 'cloud-aws',
    market_insights: 'Essential for any AWS role',
    last_updated: date('2025-01-15')
});

CREATE (aws_architect:Skill {
    id: 'skill-aws-architect',
    name: 'AWS Solutions Architecture',
    description: 'Designing scalable, resilient AWS architectures',
    difficulty_level: 'intermediate',
    estimated_hours: 100,
    demand_score: 10,
    category: 'cloud-aws',
    market_insights: 'Most sought-after AWS skill',
    last_updated: date('2025-01-15')
});

CREATE (aws_lambda:Skill {
    id: 'skill-aws-lambda',
    name: 'AWS Lambda & Serverless',
    description: 'Serverless computing, API Gateway, Step Functions',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'cloud-aws',
    last_updated: date('2025-01-15')
});

CREATE (aws_rds:Skill {
    id: 'skill-aws-rds',
    name: 'AWS Databases',
    description: 'RDS, DynamoDB, Aurora, ElastiCache',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 8,
    category: 'cloud-aws',
    last_updated: date('2025-01-15')
});

CREATE (aws_eks:Skill {
    id: 'skill-aws-eks',
    name: 'AWS EKS',
    description: 'Elastic Kubernetes Service - managed K8s on AWS',
    difficulty_level: 'advanced',
    estimated_hours: 60,
    demand_score: 8,
    category: 'cloud-aws',
    last_updated: date('2025-01-15')
});

CREATE (aws_security:Skill {
    id: 'skill-aws-security',
    name: 'AWS Security',
    description: 'IAM, KMS, Security Hub, GuardDuty, WAF',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 9,
    category: 'cloud-aws',
    last_updated: date('2025-01-15')
});

// ========================================
// 3. CREATE AZURE SKILLS
// ========================================

CREATE (azure_fundamentals:Skill {
    id: 'skill-azure-fundamentals',
    name: 'Azure Fundamentals',
    description: 'VMs, Storage, VNets, Azure AD - Core Azure services',
    difficulty_level: 'beginner',
    estimated_hours: 40,
    demand_score: 8,
    category: 'cloud-azure',
    market_insights: 'Growing demand in enterprises',
    last_updated: date('2025-01-15')
});

CREATE (azure_admin:Skill {
    id: 'skill-azure-admin',
    name: 'Azure Administration',
    description: 'Resource management, networking, monitoring',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 8,
    category: 'cloud-azure',
    last_updated: date('2025-01-15')
});

CREATE (azure_architect:Skill {
    id: 'skill-azure-architect',
    name: 'Azure Solutions Architecture',
    description: 'Designing enterprise Azure solutions',
    difficulty_level: 'advanced',
    estimated_hours: 100,
    demand_score: 9,
    category: 'cloud-azure',
    last_updated: date('2025-01-15')
});

CREATE (azure_devops_skill:Skill {
    id: 'skill-azure-devops',
    name: 'Azure DevOps',
    description: 'Pipelines, Repos, Boards, Artifacts',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 8,
    category: 'cloud-azure',
    last_updated: date('2025-01-15')
});

CREATE (azure_aks:Skill {
    id: 'skill-azure-aks',
    name: 'Azure Kubernetes Service',
    description: 'Managed Kubernetes on Azure',
    difficulty_level: 'advanced',
    estimated_hours: 60,
    demand_score: 7,
    category: 'cloud-azure',
    last_updated: date('2025-01-15')
});

// ========================================
// 4. CREATE GCP SKILLS
// ========================================

CREATE (gcp_fundamentals:Skill {
    id: 'skill-gcp-fundamentals',
    name: 'GCP Fundamentals',
    description: 'Compute Engine, Cloud Storage, VPC - Core GCP services',
    difficulty_level: 'beginner',
    estimated_hours: 40,
    demand_score: 7,
    category: 'cloud-gcp',
    market_insights: 'Fastest growing cloud platform',
    last_updated: date('2025-01-15')
});

CREATE (gcp_architect:Skill {
    id: 'skill-gcp-architect',
    name: 'GCP Architecture',
    description: 'Designing solutions on Google Cloud',
    difficulty_level: 'advanced',
    estimated_hours: 100,
    demand_score: 7,
    category: 'cloud-gcp',
    last_updated: date('2025-01-15')
});

CREATE (bigquery:Skill {
    id: 'skill-bigquery',
    name: 'BigQuery',
    description: 'Google\'s serverless data warehouse',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'cloud-gcp',
    market_insights: 'Best-in-class for analytics',
    last_updated: date('2025-01-15')
});

CREATE (gke:Skill {
    id: 'skill-gke',
    name: 'Google Kubernetes Engine',
    description: 'Managed Kubernetes on GCP',
    difficulty_level: 'advanced',
    estimated_hours: 60,
    demand_score: 7,
    category: 'cloud-gcp',
    last_updated: date('2025-01-15')
});

CREATE (cloud_run:Skill {
    id: 'skill-cloud-run',
    name: 'Cloud Run',
    description: 'Serverless containers on GCP',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 6,
    category: 'cloud-gcp',
    last_updated: date('2025-01-15')
});

// ========================================
// 5. CREATE CLOUD NATIVE SKILLS
// ========================================

CREATE (helm:Skill {
    id: 'skill-helm',
    name: 'Helm',
    description: 'Kubernetes package manager',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'cloud-native',
    last_updated: date('2025-01-15')
});

CREATE (istio:Skill {
    id: 'skill-istio',
    name: 'Istio Service Mesh',
    description: 'Service mesh for microservices',
    difficulty_level: 'advanced',
    estimated_hours: 50,
    demand_score: 6,
    category: 'cloud-native',
    last_updated: date('2025-01-15')
});

CREATE (serverless:Skill {
    id: 'skill-serverless',
    name: 'Serverless Framework',
    description: 'Multi-cloud serverless deployment',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 7,
    category: 'cloud-native',
    last_updated: date('2025-01-15')
});

CREATE (cloud_networking:Skill {
    id: 'skill-cloud-networking',
    name: 'Cloud Networking',
    description: 'VPCs, Load Balancers, CDN, DNS',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 8,
    category: 'cloud-native',
    last_updated: date('2025-01-15')
});

// ========================================
// 6. CREATE MULTI-CLOUD & FINOPS SKILLS
// ========================================

CREATE (finops:Skill {
    id: 'skill-finops',
    name: 'FinOps',
    description: 'Cloud cost optimization and governance',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'multi-cloud',
    market_insights: 'Critical as cloud costs soar',
    last_updated: date('2025-01-15')
});

CREATE (cloud_governance:Skill {
    id: 'skill-cloud-governance',
    name: 'Cloud Governance',
    description: 'Policies, compliance, tagging strategies',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 7,
    category: 'multi-cloud',
    last_updated: date('2025-01-15')
});

// ========================================
// 7. CONNECT SKILLS TO SUBDOMAINS
// ========================================

// AWS connections
MATCH (aws_cloud:SubDomain {id: 'sub-aws'}), (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'})
CREATE (aws_cloud)-[:CONTAINS]->(aws_fundamentals);

MATCH (aws_cloud:SubDomain {id: 'sub-aws'}), (aws_architect:Skill {id: 'skill-aws-architect'})
CREATE (aws_cloud)-[:CONTAINS]->(aws_architect);

MATCH (aws_cloud:SubDomain {id: 'sub-aws'}), (aws_lambda:Skill {id: 'skill-aws-lambda'})
CREATE (aws_cloud)-[:CONTAINS]->(aws_lambda);

MATCH (aws_cloud:SubDomain {id: 'sub-aws'}), (aws_rds:Skill {id: 'skill-aws-rds'})
CREATE (aws_cloud)-[:CONTAINS]->(aws_rds);

MATCH (aws_cloud:SubDomain {id: 'sub-aws'}), (aws_eks:Skill {id: 'skill-aws-eks'})
CREATE (aws_cloud)-[:CONTAINS]->(aws_eks);

MATCH (aws_cloud:SubDomain {id: 'sub-aws'}), (aws_security:Skill {id: 'skill-aws-security'})
CREATE (aws_cloud)-[:CONTAINS]->(aws_security);

// Azure connections
MATCH (azure_cloud:SubDomain {id: 'sub-azure'}), (azure_fundamentals:Skill {id: 'skill-azure-fundamentals'})
CREATE (azure_cloud)-[:CONTAINS]->(azure_fundamentals);

MATCH (azure_cloud:SubDomain {id: 'sub-azure'}), (azure_admin:Skill {id: 'skill-azure-admin'})
CREATE (azure_cloud)-[:CONTAINS]->(azure_admin);

MATCH (azure_cloud:SubDomain {id: 'sub-azure'}), (azure_architect:Skill {id: 'skill-azure-architect'})
CREATE (azure_cloud)-[:CONTAINS]->(azure_architect);

MATCH (azure_cloud:SubDomain {id: 'sub-azure'}), (azure_devops_skill:Skill {id: 'skill-azure-devops'})
CREATE (azure_cloud)-[:CONTAINS]->(azure_devops_skill);

MATCH (azure_cloud:SubDomain {id: 'sub-azure'}), (azure_aks:Skill {id: 'skill-azure-aks'})
CREATE (azure_cloud)-[:CONTAINS]->(azure_aks);

// GCP connections
MATCH (gcp_cloud:SubDomain {id: 'sub-gcp'}), (gcp_fundamentals:Skill {id: 'skill-gcp-fundamentals'})
CREATE (gcp_cloud)-[:CONTAINS]->(gcp_fundamentals);

MATCH (gcp_cloud:SubDomain {id: 'sub-gcp'}), (gcp_architect:Skill {id: 'skill-gcp-architect'})
CREATE (gcp_cloud)-[:CONTAINS]->(gcp_architect);

MATCH (gcp_cloud:SubDomain {id: 'sub-gcp'}), (bigquery:Skill {id: 'skill-bigquery'})
CREATE (gcp_cloud)-[:CONTAINS]->(bigquery);

MATCH (gcp_cloud:SubDomain {id: 'sub-gcp'}), (gke:Skill {id: 'skill-gke'})
CREATE (gcp_cloud)-[:CONTAINS]->(gke);

MATCH (gcp_cloud:SubDomain {id: 'sub-gcp'}), (cloud_run:Skill {id: 'skill-cloud-run'})
CREATE (gcp_cloud)-[:CONTAINS]->(cloud_run);

// Cloud Native connections
MATCH (cloud_native:SubDomain {id: 'sub-cloud-native'}), (helm:Skill {id: 'skill-helm'})
CREATE (cloud_native)-[:CONTAINS]->(helm);

MATCH (cloud_native:SubDomain {id: 'sub-cloud-native'}), (istio:Skill {id: 'skill-istio'})
CREATE (cloud_native)-[:CONTAINS]->(istio);

MATCH (cloud_native:SubDomain {id: 'sub-cloud-native'}), (serverless:Skill {id: 'skill-serverless'})
CREATE (cloud_native)-[:CONTAINS]->(serverless);

MATCH (cloud_native:SubDomain {id: 'sub-cloud-native'}), (cloud_networking:Skill {id: 'skill-cloud-networking'})
CREATE (cloud_native)-[:CONTAINS]->(cloud_networking);

// Multi-cloud connections
MATCH (multi_cloud:SubDomain {id: 'sub-multi-cloud'}), (finops:Skill {id: 'skill-finops'})
CREATE (multi_cloud)-[:CONTAINS]->(finops);

MATCH (multi_cloud:SubDomain {id: 'sub-multi-cloud'}), (cloud_governance:Skill {id: 'skill-cloud-governance'})
CREATE (multi_cloud)-[:CONTAINS]->(cloud_governance);

// ========================================
// 8. CREATE SKILL PREREQUISITES
// ========================================

// AWS prerequisites
MATCH (aws_architect:Skill {id: 'skill-aws-architect'}), (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'})
CREATE (aws_architect)-[:REQUIRES]->(aws_fundamentals);

MATCH (aws_lambda:Skill {id: 'skill-aws-lambda'}), (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'})
CREATE (aws_lambda)-[:REQUIRES]->(aws_fundamentals);

MATCH (aws_eks:Skill {id: 'skill-aws-eks'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (aws_eks)-[:REQUIRES]->(kubernetes);

MATCH (aws_eks:Skill {id: 'skill-aws-eks'}), (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'})
CREATE (aws_eks)-[:REQUIRES]->(aws_fundamentals);

MATCH (aws_security:Skill {id: 'skill-aws-security'}), (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'})
CREATE (aws_security)-[:REQUIRES]->(aws_fundamentals);

// Azure prerequisites
MATCH (azure_admin:Skill {id: 'skill-azure-admin'}), (azure_fundamentals:Skill {id: 'skill-azure-fundamentals'})
CREATE (azure_admin)-[:REQUIRES]->(azure_fundamentals);

MATCH (azure_architect:Skill {id: 'skill-azure-architect'}), (azure_admin:Skill {id: 'skill-azure-admin'})
CREATE (azure_architect)-[:REQUIRES]->(azure_admin);

MATCH (azure_aks:Skill {id: 'skill-azure-aks'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (azure_aks)-[:REQUIRES]->(kubernetes);

MATCH (azure_aks:Skill {id: 'skill-azure-aks'}), (azure_fundamentals:Skill {id: 'skill-azure-fundamentals'})
CREATE (azure_aks)-[:REQUIRES]->(azure_fundamentals);

// GCP prerequisites
MATCH (gcp_architect:Skill {id: 'skill-gcp-architect'}), (gcp_fundamentals:Skill {id: 'skill-gcp-fundamentals'})
CREATE (gcp_architect)-[:REQUIRES]->(gcp_fundamentals);

MATCH (gke:Skill {id: 'skill-gke'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (gke)-[:REQUIRES]->(kubernetes);

MATCH (gke:Skill {id: 'skill-gke'}), (gcp_fundamentals:Skill {id: 'skill-gcp-fundamentals'})
CREATE (gke)-[:REQUIRES]->(gcp_fundamentals);

MATCH (cloud_run:Skill {id: 'skill-cloud-run'}), (docker:Skill {id: 'skill-docker'})
CREATE (cloud_run)-[:REQUIRES]->(docker);

MATCH (bigquery:Skill {id: 'skill-bigquery'}), (sql:Skill {id: 'skill-sql'})
CREATE (bigquery)-[:REQUIRES]->(sql);

// Cloud Native prerequisites
MATCH (helm:Skill {id: 'skill-helm'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (helm)-[:REQUIRES]->(kubernetes);

MATCH (istio:Skill {id: 'skill-istio'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (istio)-[:REQUIRES]->(kubernetes);

MATCH (cloud_networking:Skill {id: 'skill-cloud-networking'}), (linux:Skill {id: 'skill-linux'})
CREATE (cloud_networking)-[:REQUIRES]->(linux);

// ========================================
// 9. CREATE SKILL PROGRESSIONS
// ========================================

MATCH (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'}), (aws_architect:Skill {id: 'skill-aws-architect'})
CREATE (aws_fundamentals)-[:LEADS_TO]->(aws_architect);

MATCH (aws_architect:Skill {id: 'skill-aws-architect'}), (aws_security:Skill {id: 'skill-aws-security'})
CREATE (aws_architect)-[:LEADS_TO]->(aws_security);

MATCH (azure_fundamentals:Skill {id: 'skill-azure-fundamentals'}), (azure_admin:Skill {id: 'skill-azure-admin'})
CREATE (azure_fundamentals)-[:LEADS_TO]->(azure_admin);

MATCH (azure_admin:Skill {id: 'skill-azure-admin'}), (azure_architect:Skill {id: 'skill-azure-architect'})
CREATE (azure_admin)-[:LEADS_TO]->(azure_architect);

MATCH (gcp_fundamentals:Skill {id: 'skill-gcp-fundamentals'}), (gcp_architect:Skill {id: 'skill-gcp-architect'})
CREATE (gcp_fundamentals)-[:LEADS_TO]->(gcp_architect);

MATCH (kubernetes:Skill {id: 'skill-kubernetes'}), (helm:Skill {id: 'skill-helm'})
CREATE (kubernetes)-[:LEADS_TO]->(helm);

MATCH (helm:Skill {id: 'skill-helm'}), (istio:Skill {id: 'skill-istio'})
CREATE (helm)-[:LEADS_TO]->(istio);

// ========================================
// 10. CREATE CERTIFICATIONS
// ========================================

// AWS Certifications
CREATE (aws_ccp:Certification {
    id: 'cert-aws-ccp',
    name: 'AWS Certified Cloud Practitioner',
    provider: 'AWS',
    level: 'foundational',
    cost: 100,
    validity_period: '3 years',
    estimated_prep_hours: 30,
    difficulty_rating: 3,
    market_value: 'medium',
    url: 'https://aws.amazon.com/certification/certified-cloud-practitioner/',
    exam_format: 'Multiple choice, 90 minutes'
});

CREATE (aws_saa:Certification {
    id: 'cert-aws-saa',
    name: 'AWS Solutions Architect Associate',
    provider: 'AWS',
    level: 'associate',
    cost: 150,
    validity_period: '3 years',
    estimated_prep_hours: 80,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://aws.amazon.com/certification/certified-solutions-architect-associate/',
    exam_format: 'Multiple choice, 130 minutes'
});

CREATE (aws_sap:Certification {
    id: 'cert-aws-sap',
    name: 'AWS Solutions Architect Professional',
    provider: 'AWS',
    level: 'professional',
    cost: 300,
    validity_period: '3 years',
    estimated_prep_hours: 150,
    difficulty_rating: 9,
    market_value: 'very-high',
    url: 'https://aws.amazon.com/certification/certified-solutions-architect-professional/',
    exam_format: 'Multiple choice, 180 minutes'
});

CREATE (aws_developer:Certification {
    id: 'cert-aws-developer',
    name: 'AWS Certified Developer Associate',
    provider: 'AWS',
    level: 'associate',
    cost: 150,
    validity_period: '3 years',
    estimated_prep_hours: 60,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://aws.amazon.com/certification/certified-developer-associate/',
    exam_format: 'Multiple choice, 130 minutes'
});

// Azure Certifications
CREATE (az_900:Certification {
    id: 'cert-az-900',
    name: 'Azure Fundamentals',
    provider: 'Microsoft',
    level: 'foundational',
    cost: 99,
    validity_period: 'lifetime',
    estimated_prep_hours: 30,
    difficulty_rating: 3,
    market_value: 'medium',
    url: 'https://learn.microsoft.com/certifications/azure-fundamentals/',
    exam_format: 'Multiple choice, 85 minutes'
});

CREATE (az_104:Certification {
    id: 'cert-az-104',
    name: 'Azure Administrator Associate',
    provider: 'Microsoft',
    level: 'associate',
    cost: 165,
    validity_period: '1 year',
    estimated_prep_hours: 60,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://learn.microsoft.com/certifications/azure-administrator/',
    exam_format: 'Multiple choice, 120 minutes'
});

CREATE (az_305:Certification {
    id: 'cert-az-305',
    name: 'Azure Solutions Architect Expert',
    provider: 'Microsoft',
    level: 'expert',
    cost: 165,
    validity_period: '1 year',
    estimated_prep_hours: 100,
    difficulty_rating: 8,
    market_value: 'very-high',
    url: 'https://learn.microsoft.com/certifications/azure-solutions-architect/',
    exam_format: 'Multiple choice, case studies, 120 minutes'
});

// GCP Certifications
CREATE (gcp_cda:Certification {
    id: 'cert-gcp-cda',
    name: 'Google Cloud Digital Leader',
    provider: 'Google',
    level: 'foundational',
    cost: 99,
    validity_period: '3 years',
    estimated_prep_hours: 30,
    difficulty_rating: 3,
    market_value: 'medium',
    url: 'https://cloud.google.com/certification/cloud-digital-leader',
    exam_format: 'Multiple choice, 90 minutes'
});

CREATE (gcp_ace:Certification {
    id: 'cert-gcp-ace',
    name: 'Google Cloud Associate Engineer',
    provider: 'Google',
    level: 'associate',
    cost: 125,
    validity_period: '3 years',
    estimated_prep_hours: 50,
    difficulty_rating: 5,
    market_value: 'high',
    url: 'https://cloud.google.com/certification/cloud-engineer',
    exam_format: 'Multiple choice, 120 minutes'
});

CREATE (gcp_pca:Certification {
    id: 'cert-gcp-pca',
    name: 'Google Cloud Professional Architect',
    provider: 'Google',
    level: 'professional',
    cost: 200,
    validity_period: '2 years',
    estimated_prep_hours: 100,
    difficulty_rating: 8,
    market_value: 'very-high',
    url: 'https://cloud.google.com/certification/cloud-architect',
    exam_format: 'Multiple choice, case studies, 120 minutes'
});

// Kubernetes Certifications
CREATE (cka:Certification {
    id: 'cert-cka',
    name: 'Certified Kubernetes Administrator',
    provider: 'CNCF',
    level: 'professional',
    cost: 395,
    validity_period: '3 years',
    estimated_prep_hours: 60,
    difficulty_rating: 7,
    market_value: 'very-high',
    url: 'https://www.cncf.io/certification/cka/',
    exam_format: 'Hands-on, 120 minutes'
});

CREATE (ckad:Certification {
    id: 'cert-ckad',
    name: 'Certified Kubernetes Application Developer',
    provider: 'CNCF',
    level: 'professional',
    cost: 395,
    validity_period: '3 years',
    estimated_prep_hours: 50,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://www.cncf.io/certification/ckad/',
    exam_format: 'Hands-on, 120 minutes'
});

// FinOps Certification
CREATE (finops_cert:Certification {
    id: 'cert-finops',
    name: 'FinOps Certified Practitioner',
    provider: 'FinOps Foundation',
    level: 'associate',
    cost: 300,
    validity_period: '2 years',
    estimated_prep_hours: 30,
    difficulty_rating: 5,
    market_value: 'high',
    url: 'https://www.finops.org/certification/',
    exam_format: 'Multiple choice, 60 minutes'
});

// Connect certifications to skills
MATCH (aws_ccp:Certification {id: 'cert-aws-ccp'}), (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'})
CREATE (aws_ccp)-[:REQUIRES]->(aws_fundamentals);

MATCH (aws_saa:Certification {id: 'cert-aws-saa'}), (aws_architect:Skill {id: 'skill-aws-architect'})
CREATE (aws_saa)-[:REQUIRES]->(aws_architect);

MATCH (aws_sap:Certification {id: 'cert-aws-sap'}), (aws_architect:Skill {id: 'skill-aws-architect'})
CREATE (aws_sap)-[:REQUIRES]->(aws_architect);

MATCH (az_900:Certification {id: 'cert-az-900'}), (azure_fundamentals:Skill {id: 'skill-azure-fundamentals'})
CREATE (az_900)-[:REQUIRES]->(azure_fundamentals);

MATCH (az_104:Certification {id: 'cert-az-104'}), (azure_admin:Skill {id: 'skill-azure-admin'})
CREATE (az_104)-[:REQUIRES]->(azure_admin);

MATCH (az_305:Certification {id: 'cert-az-305'}), (azure_architect:Skill {id: 'skill-azure-architect'})
CREATE (az_305)-[:REQUIRES]->(azure_architect);

MATCH (gcp_ace:Certification {id: 'cert-gcp-ace'}), (gcp_fundamentals:Skill {id: 'skill-gcp-fundamentals'})
CREATE (gcp_ace)-[:REQUIRES]->(gcp_fundamentals);

MATCH (gcp_pca:Certification {id: 'cert-gcp-pca'}), (gcp_architect:Skill {id: 'skill-gcp-architect'})
CREATE (gcp_pca)-[:REQUIRES]->(gcp_architect);

MATCH (cka:Certification {id: 'cert-cka'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (cka)-[:REQUIRES]->(kubernetes);

MATCH (ckad:Certification {id: 'cert-ckad'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (ckad)-[:REQUIRES]->(kubernetes);

MATCH (finops_cert:Certification {id: 'cert-finops'}), (finops:Skill {id: 'skill-finops'})
CREATE (finops_cert)-[:REQUIRES]->(finops);

// Certification progressions
MATCH (aws_ccp:Certification {id: 'cert-aws-ccp'}), (aws_saa:Certification {id: 'cert-aws-saa'})
CREATE (aws_ccp)-[:LEADS_TO]->(aws_saa);

MATCH (aws_saa:Certification {id: 'cert-aws-saa'}), (aws_sap:Certification {id: 'cert-aws-sap'})
CREATE (aws_saa)-[:LEADS_TO]->(aws_sap);

MATCH (az_900:Certification {id: 'cert-az-900'}), (az_104:Certification {id: 'cert-az-104'})
CREATE (az_900)-[:LEADS_TO]->(az_104);

MATCH (az_104:Certification {id: 'cert-az-104'}), (az_305:Certification {id: 'cert-az-305'})
CREATE (az_104)-[:LEADS_TO]->(az_305);

MATCH (gcp_cda:Certification {id: 'cert-gcp-cda'}), (gcp_ace:Certification {id: 'cert-gcp-ace'})
CREATE (gcp_cda)-[:LEADS_TO]->(gcp_ace);

MATCH (gcp_ace:Certification {id: 'cert-gcp-ace'}), (gcp_pca:Certification {id: 'cert-gcp-pca'})
CREATE (gcp_ace)-[:LEADS_TO]->(gcp_pca);

// Connect certifications to domain
MATCH (aws_saa:Certification {id: 'cert-aws-saa'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (aws_saa)-[:RECOMMENDED_FOR]->(cloud);

MATCH (az_305:Certification {id: 'cert-az-305'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (az_305)-[:RECOMMENDED_FOR]->(cloud);

MATCH (gcp_pca:Certification {id: 'cert-gcp-pca'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (gcp_pca)-[:RECOMMENDED_FOR]->(cloud);

MATCH (cka:Certification {id: 'cert-cka'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (cka)-[:RECOMMENDED_FOR]->(cloud);

// ========================================
// 11. CREATE RESOURCES
// ========================================

// AWS Resources
CREATE (aws_skillbuilder:Resource {
    id: 'res-aws-skillbuilder',
    title: 'AWS Skill Builder',
    url: 'https://skillbuilder.aws/',
    type: 'course',
    platform: 'AWS',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'mixed'
});

CREATE (aws_cantrill:Resource {
    id: 'res-aws-cantrill',
    title: 'Learn Cantrill - AWS Solutions Architect',
    url: 'https://learn.cantrill.io/',
    type: 'video',
    platform: 'Cantrill',
    duration: '40 hours',
    rating: 4.9,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'visual'
});

CREATE (acloudguru:Resource {
    id: 'res-acloudguru',
    title: 'A Cloud Guru - AWS Learning Paths',
    url: 'https://acloudguru.com/',
    type: 'course',
    platform: 'A Cloud Guru',
    duration: 'varies',
    rating: 4.6,
    price: 'paid',
    difficulty_level: 'all',
    learning_style: 'visual'
});

// Azure Resources
CREATE (azure_learn:Resource {
    id: 'res-azure-learn',
    title: 'Microsoft Learn',
    url: 'https://learn.microsoft.com/azure',
    type: 'course',
    platform: 'Microsoft',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'mixed'
});

CREATE (azure_104_guide:Resource {
    id: 'res-azure-104-guide',
    title: 'AZ-104 Study Guide',
    url: 'https://learn.microsoft.com/certifications/azure-administrator/',
    type: 'guide',
    platform: 'Microsoft',
    duration: '60 hours',
    rating: 4.4,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// GCP Resources
CREATE (gcp_skillboost:Resource {
    id: 'res-gcp-skillboost',
    title: 'Google Cloud Skills Boost',
    url: 'https://www.cloudskillsboost.google/',
    type: 'course',
    platform: 'Google',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'hands-on'
});

CREATE (gcp_coursera:Resource {
    id: 'res-gcp-coursera',
    title: 'Google Cloud Platform Fundamentals',
    url: 'https://www.coursera.org/learn/gcp-fundamentals',
    type: 'video',
    platform: 'Coursera',
    duration: '15 hours',
    rating: 4.6,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'visual'
});

// Kubernetes Resources (from base, but adding more)
CREATE (k8s_hardway:Resource {
    id: 'res-k8s-hardway',
    title: 'Kubernetes The Hard Way',
    url: 'https://github.com/kelseyhightower/kubernetes-the-hard-way',
    type: 'tutorial',
    platform: 'GitHub',
    duration: '8 hours',
    rating: 4.8,
    price: 'free',
    difficulty_level: 'advanced',
    learning_style: 'hands-on'
});

// FinOps Resources
CREATE (finops_book:Resource {
    id: 'res-finops-book',
    title: 'Cloud FinOps Book',
    url: 'https://www.oreilly.com/library/view/cloud-finops/9781492054610/',
    type: 'book',
    platform: 'OReilly',
    duration: '20 hours',
    rating: 4.7,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// Connect resources to skills
MATCH (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'}), (aws_skillbuilder:Resource {id: 'res-aws-skillbuilder'})
CREATE (aws_fundamentals)-[:HAS_RESOURCE]->(aws_skillbuilder);

MATCH (aws_architect:Skill {id: 'skill-aws-architect'}), (aws_cantrill:Resource {id: 'res-aws-cantrill'})
CREATE (aws_architect)-[:HAS_RESOURCE]->(aws_cantrill);

MATCH (aws_architect:Skill {id: 'skill-aws-architect'}), (acloudguru:Resource {id: 'res-acloudguru'})
CREATE (aws_architect)-[:HAS_RESOURCE]->(acloudguru);

MATCH (azure_fundamentals:Skill {id: 'skill-azure-fundamentals'}), (azure_learn:Resource {id: 'res-azure-learn'})
CREATE (azure_fundamentals)-[:HAS_RESOURCE]->(azure_learn);

MATCH (azure_admin:Skill {id: 'skill-azure-admin'}), (azure_104_guide:Resource {id: 'res-azure-104-guide'})
CREATE (azure_admin)-[:HAS_RESOURCE]->(azure_104_guide);

MATCH (gcp_fundamentals:Skill {id: 'skill-gcp-fundamentals'}), (gcp_skillboost:Resource {id: 'res-gcp-skillboost'})
CREATE (gcp_fundamentals)-[:HAS_RESOURCE]->(gcp_skillboost);

MATCH (gcp_fundamentals:Skill {id: 'skill-gcp-fundamentals'}), (gcp_coursera:Resource {id: 'res-gcp-coursera'})
CREATE (gcp_fundamentals)-[:HAS_RESOURCE]->(gcp_coursera);

MATCH (kubernetes:Skill {id: 'skill-kubernetes'}), (k8s_hardway:Resource {id: 'res-k8s-hardway'})
CREATE (kubernetes)-[:HAS_RESOURCE]->(k8s_hardway);

MATCH (finops:Skill {id: 'skill-finops'}), (finops_book:Resource {id: 'res-finops-book'})
CREATE (finops)-[:HAS_RESOURCE]->(finops_book);

// ========================================
// VERIFICATION QUERY
// ========================================
// Run to verify Cloud domain is loaded:
// MATCH (d:Domain {id: 'domain-cloud'})-[:CONTAINS]->(sd:SubDomain)-[:CONTAINS]->(s:Skill) 
// RETURN d.name, sd.name, count(s) as skill_count;
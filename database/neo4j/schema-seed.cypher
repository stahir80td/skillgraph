// ====================================================================================================
// SKILL PATH NAVIGATOR - COMPLETE SCHEMA AND DATA (FIXED)
// Version: 2.0 - All validation issues resolved
// This script is idempotent - safe to run multiple times
// ====================================================================================================

// Optional: Clear existing data (uncomment if doing fresh install)
// MATCH (n) DETACH DELETE n;

// ====================================================================================================
// SECTION 1: SCHEMA, CONSTRAINTS, AND INDEXES
// ====================================================================================================

// 1.1. UNIQUE CONSTRAINTS (Primary Keys)
CREATE CONSTRAINT domain_id_unique IF NOT EXISTS FOR (d:Domain) REQUIRE d.id IS UNIQUE;
CREATE CONSTRAINT domain_name_unique IF NOT EXISTS FOR (d:Domain) REQUIRE d.name IS UNIQUE;
CREATE CONSTRAINT skill_id_unique IF NOT EXISTS FOR (s:Skill) REQUIRE s.id IS UNIQUE;
CREATE CONSTRAINT skill_name_unique IF NOT EXISTS FOR (s:Skill) REQUIRE s.name IS UNIQUE;
CREATE CONSTRAINT resource_id_unique IF NOT EXISTS FOR (r:Resource) REQUIRE r.id IS UNIQUE;
CREATE CONSTRAINT cert_id_unique IF NOT EXISTS FOR (c:Certification) REQUIRE c.id IS UNIQUE;
CREATE CONSTRAINT cert_name_unique IF NOT EXISTS FOR (c:Certification) REQUIRE c.name IS UNIQUE;
CREATE CONSTRAINT concept_id_unique IF NOT EXISTS FOR (co:Concept) REQUIRE co.id IS UNIQUE;
CREATE CONSTRAINT subdomain_id_unique IF NOT EXISTS FOR (sd:SubDomain) REQUIRE sd.id IS UNIQUE;
CREATE CONSTRAINT subdomain_name_unique IF NOT EXISTS FOR (sd:SubDomain) REQUIRE sd.name IS UNIQUE;

// 1.2. PROPERTY EXISTENCE CONSTRAINTS
CREATE CONSTRAINT domain_description_exists IF NOT EXISTS FOR (d:Domain) REQUIRE d.description IS NOT NULL;
CREATE CONSTRAINT skill_estimated_hours_exists IF NOT EXISTS FOR (s:Skill) REQUIRE s.estimated_hours IS NOT NULL;
CREATE CONSTRAINT resource_title_exists IF NOT EXISTS FOR (r:Resource) REQUIRE r.title IS NOT NULL;
CREATE CONSTRAINT resource_url_exists IF NOT EXISTS FOR (r:Resource) REQUIRE r.url IS NOT NULL;
CREATE CONSTRAINT resource_type_exists IF NOT EXISTS FOR (r:Resource) REQUIRE r.type IS NOT NULL;
CREATE CONSTRAINT cert_name_exists IF NOT EXISTS FOR (c:Certification) REQUIRE c.name IS NOT NULL;
CREATE CONSTRAINT cert_provider_exists IF NOT EXISTS FOR (c:Certification) REQUIRE c.provider IS NOT NULL;
CREATE CONSTRAINT cert_level_exists IF NOT EXISTS FOR (c:Certification) REQUIRE c.level IS NOT NULL;
CREATE CONSTRAINT cert_cost_exists IF NOT EXISTS FOR (c:Certification) REQUIRE c.cost IS NOT NULL;

// 1.3. COMPOSITE INDEXES
CREATE INDEX skill_domain_difficulty IF NOT EXISTS FOR (s:Skill) ON (s.category, s.difficulty_level);

// ====================================================================================================
// SECTION 2: BASE DOMAINS
// ====================================================================================================

MERGE (ai:Domain {id: 'domain-ai-ml'}) 
ON CREATE SET
    ai.name = 'AI & Machine Learning',
    ai.description = 'Artificial Intelligence, Machine Learning, Deep Learning, and Generative AI',
    ai.color = '#FF6B6B',
    ai.icon = 'brain',
    ai.market_growth = 'explosive',
    ai.avg_salary_range = '$120k-$250k',
    ai.priority = 1;

MERGE (cloud:Domain {id: 'domain-cloud'})
ON CREATE SET
    cloud.name = 'Cloud & Infrastructure',
    cloud.description = 'AWS, Azure, GCP, Multi-cloud Architecture, and Cloud Native Technologies',
    cloud.color = '#4ECDC4',
    cloud.icon = 'cloud',
    cloud.market_growth = 'high',
    cloud.avg_salary_range = '$110k-$200k',
    cloud.priority = 2;

MERGE (devops:Domain {id: 'domain-devops'})
ON CREATE SET
    devops.name = 'DevOps & Platform Engineering',
    devops.description = 'CI/CD, Infrastructure as Code, Platform Engineering, Developer Experience',
    devops.color = '#95E77E',
    devops.icon = 'infinity',
    devops.market_growth = 'high',
    devops.avg_salary_range = '$100k-$180k',
    devops.priority = 3;

MERGE (sre:Domain {id: 'domain-sre'})
ON CREATE SET
    sre.name = 'Site Reliability Engineering',
    sre.description = 'System reliability, observability, incident management, performance optimization',
    sre.color = '#B085F5',
    sre.icon = 'gauge',
    sre.market_growth = 'stable',
    sre.avg_salary_range = '$115k-$210k',
    sre.priority = 4;

MERGE (data:Domain {id: 'domain-data'})
ON CREATE SET
    data.name = 'Data Engineering',
    data.description = 'Data pipelines, warehousing, streaming, ETL/ELT, and analytics engineering',
    data.color = '#FFAF4B',
    data.icon = 'database',
    data.market_growth = 'very high',
    data.avg_salary_range = '$105k-$190k',
    data.priority = 5;

MERGE (software:Domain {id: 'domain-software'})
ON CREATE SET
    software.name = 'Software Engineering',
    software.description = 'Frontend, Backend, Mobile development, System Architecture, and Design',
    software.color = '#4B8AFF',
    software.icon = 'code',
    software.market_growth = 'stable',
    software.avg_salary_range = '$100k-$175k',
    software.priority = 6;

MERGE (security:Domain {id: 'domain-security'})
ON CREATE SET
    security.name = 'Security & Compliance',
    security.description = 'DevSecOps, Cloud Security, Application Security, and Governance',
    security.color = '#FF3868',
    security.icon = 'lock',
    security.market_growth = 'high',
    security.avg_salary_range = '$105k-$195k',
    security.priority = 7;

// ====================================================================================================
// SECTION 3: SOFTWARE ENGINEERING DOMAIN (Including Fundamentals)
// ====================================================================================================

// SOFTWARE SUBDOMAINS
MERGE (fundamentals:SubDomain {id: 'sub-sw-fundamentals'})
ON CREATE SET
    fundamentals.name = 'Programming Fundamentals',
    fundamentals.description = 'Core programming skills, version control, and database basics',
    fundamentals.order = 0;

MERGE (frontend:SubDomain {id: 'sub-sw-frontend'})
ON CREATE SET
    frontend.name = 'Frontend Development',
    frontend.description = 'React, Vue, Angular, UI/UX',
    frontend.order = 1;

MERGE (backend:SubDomain {id: 'sub-sw-backend'})
ON CREATE SET
    backend.name = 'Backend Development',
    backend.description = 'APIs, databases, server-side logic',
    backend.order = 2;

MERGE (architecture:SubDomain {id: 'sub-sw-architecture'})
ON CREATE SET
    architecture.name = 'Software Architecture',
    architecture.description = 'Design patterns, DDD, event-driven',
    architecture.order = 3;

MERGE (testing:SubDomain {id: 'sub-sw-testing'})
ON CREATE SET
    testing.name = 'Testing & QA',
    testing.description = 'Unit, integration, E2E testing',
    testing.order = 4;

MATCH (software:Domain {id: 'domain-software'}), (s:SubDomain)
WHERE s.id IN ['sub-sw-fundamentals', 'sub-sw-frontend', 'sub-sw-backend', 'sub-sw-architecture', 'sub-sw-testing']
MERGE (software)-[:CONTAINS]->(s);

// FOUNDATIONAL SKILLS (Now properly contained in subdomains)
MERGE (git:Skill {id: 'skill-git'})
ON CREATE SET
    git.name = 'Git Version Control',
    git.difficulty_level = 'beginner',
    git.estimated_hours = 20,
    git.demand_score = 10,
    git.category = 'fundamentals',
    git.prereq_level = 1;

MERGE (python:Skill {id: 'skill-python'})
ON CREATE SET
    python.name = 'Python Programming',
    python.difficulty_level = 'beginner',
    python.estimated_hours = 80,
    python.demand_score = 10,
    python.category = 'programming',
    python.prereq_level = 1;

MERGE (sql:Skill {id: 'skill-sql'})
ON CREATE SET
    sql.name = 'SQL & Database Basics',
    sql.difficulty_level = 'beginner',
    sql.estimated_hours = 40,
    sql.demand_score = 9,
    sql.category = 'database',
    sql.prereq_level = 1;

MERGE (javascript:Skill {id: 'skill-javascript'})
ON CREATE SET
    javascript.name = 'JavaScript',
    javascript.difficulty_level = 'beginner',
    javascript.estimated_hours = 60,
    javascript.demand_score = 9,
    javascript.category = 'frontend',
    javascript.prereq_level = 1;

// Connect foundational skills to fundamentals subdomain
MATCH (fund:SubDomain {id: 'sub-sw-fundamentals'}), (s:Skill)
WHERE s.id IN ['skill-git', 'skill-python', 'skill-sql']
MERGE (fund)-[:CONTAINS]->(s);

// SOFTWARE SKILLS
MERGE (react:Skill {id: 'skill-react'})
ON CREATE SET
    react.name = 'React/Next.js',
    react.difficulty_level = 'intermediate',
    react.estimated_hours = 60,
    react.demand_score = 9,
    react.category = 'frontend',
    react.prereq_level = 2;

MERGE (typescript:Skill {id: 'skill-typescript'})
ON CREATE SET
    typescript.name = 'TypeScript',
    typescript.difficulty_level = 'beginner',
    typescript.estimated_hours = 30,
    typescript.demand_score = 8,
    typescript.category = 'frontend',
    typescript.prereq_level = 2;

MERGE (nodejs:Skill {id: 'skill-nodejs'})
ON CREATE SET
    nodejs.name = 'Node.js / Express',
    nodejs.difficulty_level = 'intermediate',
    nodejs.estimated_hours = 80,
    nodejs.demand_score = 7,
    nodejs.category = 'backend',
    nodejs.prereq_level = 2;

MERGE (golang:Skill {id: 'skill-golang'})
ON CREATE SET
    golang.name = 'Go (Golang)',
    golang.difficulty_level = 'intermediate',
    golang.estimated_hours = 70,
    golang.demand_score = 7,
    golang.category = 'backend',
    golang.prereq_level = 2;

MERGE (java_spring:Skill {id: 'skill-java-spring'})
ON CREATE SET
    java_spring.name = 'Java / Spring Boot',
    java_spring.difficulty_level = 'intermediate',
    java_spring.estimated_hours = 140,
    java_spring.demand_score = 8,
    java_spring.category = 'backend',
    java_spring.prereq_level = 2;

MERGE (postgresql:Skill {id: 'skill-postgresql'})
ON CREATE SET
    postgresql.name = 'PostgreSQL',
    postgresql.difficulty_level = 'intermediate',
    postgresql.estimated_hours = 60,
    postgresql.demand_score = 9,
    postgresql.category = 'database',
    postgresql.prereq_level = 2;

MERGE (microservices:Skill {id: 'skill-microservices'})
ON CREATE SET
    microservices.name = 'Microservices Architecture',
    microservices.difficulty_level = 'expert',
    microservices.estimated_hours = 80,
    microservices.demand_score = 8,
    microservices.category = 'backend',
    microservices.prereq_level = 4;

MERGE (api_design:Skill {id: 'skill-api-design'})
ON CREATE SET
    api_design.name = 'API Design (REST/GraphQL)',
    api_design.difficulty_level = 'intermediate',
    api_design.estimated_hours = 40,
    api_design.demand_score = 8,
    api_design.category = 'backend',
    api_design.prereq_level = 2;

MERGE (system_design:Skill {id: 'skill-system-design'})
ON CREATE SET
    system_design.name = 'System Design',
    system_design.difficulty_level = 'expert',
    system_design.estimated_hours = 80,
    system_design.demand_score = 9,
    system_design.category = 'architecture',
    system_design.prereq_level = 4;

MERGE (unit_testing:Skill {id: 'skill-unit-testing'})
ON CREATE SET
    unit_testing.name = 'Unit Testing',
    unit_testing.difficulty_level = 'beginner',
    unit_testing.estimated_hours = 30,
    unit_testing.demand_score = 8,
    unit_testing.category = 'testing',
    unit_testing.prereq_level = 2;

MERGE (e2e_testing:Skill {id: 'skill-e2e-testing'})
ON CREATE SET
    e2e_testing.name = 'E2E Testing (Cypress/Playwright)',
    e2e_testing.difficulty_level = 'intermediate',
    e2e_testing.estimated_hours = 40,
    e2e_testing.demand_score = 8,
    e2e_testing.category = 'testing',
    e2e_testing.prereq_level = 3;

// SOFTWARE SKILL RELATIONSHIPS
MATCH (sd:SubDomain {id: 'sub-sw-frontend'}), (s:Skill)
WHERE s.id IN ['skill-javascript', 'skill-react', 'skill-typescript']
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-sw-backend'}), (s:Skill)
WHERE s.id IN ['skill-nodejs', 'skill-golang', 'skill-java-spring', 'skill-postgresql', 'skill-microservices', 'skill-api-design']
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-sw-architecture'}), (s:Skill {id: 'skill-system-design'})
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-sw-testing'}), (s:Skill)
WHERE s.id IN ['skill-unit-testing', 'skill-e2e-testing']
MERGE (sd)-[:CONTAINS]->(s);

// SOFTWARE PREREQUISITES
MATCH (react:Skill {id: 'skill-react'}), (js:Skill {id: 'skill-javascript'})
MERGE (react)-[:REQUIRES {priority: 1, type: 'hard'}]->(js);

MATCH (ts:Skill {id: 'skill-typescript'}), (js:Skill {id: 'skill-javascript'})
MERGE (ts)-[:REQUIRES {priority: 1, type: 'hard'}]->(js);

MATCH (nodejs:Skill {id: 'skill-nodejs'}), (js:Skill {id: 'skill-javascript'})
MERGE (nodejs)-[:REQUIRES {priority: 1, type: 'hard'}]->(js);

MATCH (golang:Skill {id: 'skill-golang'}), (git:Skill {id: 'skill-git'})
MERGE (golang)-[:REQUIRES {priority: 1, type: 'soft'}]->(git);

MATCH (java_spring:Skill {id: 'skill-java-spring'}), (git:Skill {id: 'skill-git'})
MERGE (java_spring)-[:REQUIRES {priority: 1, type: 'soft'}]->(git);

MATCH (postgres:Skill {id: 'skill-postgresql'}), (sql:Skill {id: 'skill-sql'})
MERGE (postgres)-[:REQUIRES {priority: 1, type: 'hard'}]->(sql);

MATCH (api:Skill {id: 'skill-api-design'}), (nodejs:Skill {id: 'skill-nodejs'})
MERGE (api)-[:REQUIRES {priority: 1, type: 'soft'}]->(nodejs);

MATCH (micro:Skill {id: 'skill-microservices'}), (api:Skill {id: 'skill-api-design'})
MERGE (micro)-[:REQUIRES {priority: 1, type: 'hard'}]->(api);

MATCH (micro:Skill {id: 'skill-microservices'}), (docker:Skill {id: 'skill-docker'})
MERGE (micro)-[:REQUIRES {priority: 2, type: 'soft'}]->(docker);

MATCH (e2e:Skill {id: 'skill-e2e-testing'}), (js:Skill {id: 'skill-javascript'})
MERGE (e2e)-[:REQUIRES {priority: 1, type: 'hard'}]->(js);

MATCH (sys:Skill {id: 'skill-system-design'}), (api:Skill {id: 'skill-api-design'})
MERGE (sys)-[:REQUIRES {priority: 1, type: 'soft'}]->(api);

// ====================================================================================================
// SECTION 4: CLOUD & INFRASTRUCTURE DOMAIN
// ====================================================================================================

// CLOUD SUBDOMAINS
MERGE (aws_cloud:SubDomain {id: 'sub-aws'})
ON CREATE SET
    aws_cloud.name = 'AWS',
    aws_cloud.description = 'Amazon Web Services - Market leader',
    aws_cloud.order = 1;

MERGE (azure_cloud:SubDomain {id: 'sub-azure'})
ON CREATE SET
    azure_cloud.name = 'Microsoft Azure',
    azure_cloud.description = 'Microsoft Azure - Enterprise favorite',
    azure_cloud.order = 2;

MERGE (gcp_cloud:SubDomain {id: 'sub-gcp'})
ON CREATE SET
    gcp_cloud.name = 'Google Cloud Platform',
    gcp_cloud.description = 'Google Cloud - Strong in AI/ML and analytics',
    gcp_cloud.order = 3;

MERGE (cloud_native:SubDomain {id: 'sub-cloud-native'})
ON CREATE SET
    cloud_native.name = 'Cloud Native',
    cloud_native.description = 'Kubernetes, Serverless, Service Mesh',
    cloud_native.order = 4;

MERGE (cloud_fundamentals:SubDomain {id: 'sub-cloud-fundamentals'})
ON CREATE SET
    cloud_fundamentals.name = 'Cloud Fundamentals',
    cloud_fundamentals.description = 'Core cloud concepts, Linux, networking',
    cloud_fundamentals.order = 0;

MATCH (cloud:Domain {id: 'domain-cloud'}), (s:SubDomain)
WHERE s.id IN ['sub-cloud-fundamentals', 'sub-aws', 'sub-azure', 'sub-gcp', 'sub-cloud-native']
MERGE (cloud)-[:CONTAINS]->(s);

// CLOUD FUNDAMENTALS SKILLS
MERGE (linux:Skill {id: 'skill-linux'})
ON CREATE SET
    linux.name = 'Linux/Shell Scripting',
    linux.difficulty_level = 'beginner',
    linux.estimated_hours = 40,
    linux.demand_score = 8,
    linux.category = 'os',
    linux.prereq_level = 1;

// Connect Linux to cloud fundamentals
MATCH (cf:SubDomain {id: 'sub-cloud-fundamentals'}), (linux:Skill {id: 'skill-linux'})
MERGE (cf)-[:CONTAINS]->(linux);

// CLOUD SKILLS
MERGE (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'})
ON CREATE SET
    aws_fundamentals.name = 'AWS Fundamentals (S3, EC2, IAM)',
    aws_fundamentals.difficulty_level = 'beginner',
    aws_fundamentals.estimated_hours = 40,
    aws_fundamentals.demand_score = 10,
    aws_fundamentals.category = 'aws',
    aws_fundamentals.prereq_level = 1;

MERGE (aws_architect:Skill {id: 'skill-aws-architect'})
ON CREATE SET
    aws_architect.name = 'AWS Solutions Architect',
    aws_architect.difficulty_level = 'intermediate',
    aws_architect.estimated_hours = 80,
    aws_architect.demand_score = 9,
    aws_architect.category = 'aws',
    aws_architect.prereq_level = 2;

MERGE (azure_fundamentals:Skill {id: 'skill-azure-fundamentals'})
ON CREATE SET
    azure_fundamentals.name = 'Azure Fundamentals (AZ-900)',
    azure_fundamentals.difficulty_level = 'beginner',
    azure_fundamentals.estimated_hours = 30,
    azure_fundamentals.demand_score = 8,
    azure_fundamentals.category = 'azure',
    azure_fundamentals.prereq_level = 1;

MERGE (gcp_fundamentals:Skill {id: 'skill-gcp-fundamentals'})
ON CREATE SET
    gcp_fundamentals.name = 'GCP Fundamentals',
    gcp_fundamentals.difficulty_level = 'beginner',
    gcp_fundamentals.estimated_hours = 35,
    gcp_fundamentals.demand_score = 7,
    gcp_fundamentals.category = 'gcp',
    gcp_fundamentals.prereq_level = 1;

MERGE (kubernetes:Skill {id: 'skill-kubernetes'})
ON CREATE SET
    kubernetes.name = 'Kubernetes',
    kubernetes.difficulty_level = 'intermediate',
    kubernetes.estimated_hours = 60,
    kubernetes.demand_score = 10,
    kubernetes.category = 'cloud-native',
    kubernetes.prereq_level = 2;

// CLOUD SKILL RELATIONSHIPS
MATCH (sd:SubDomain {id: 'sub-aws'}), (s:Skill)
WHERE s.id IN ['skill-aws-fundamentals', 'skill-aws-architect']
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-azure'}), (s:Skill {id: 'skill-azure-fundamentals'})
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-gcp'}), (s:Skill {id: 'skill-gcp-fundamentals'})
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-cloud-native'}), (s:Skill {id: 'skill-kubernetes'})
MERGE (sd)-[:CONTAINS]->(s);

// CLOUD PREREQUISITES
MATCH (aws_arch:Skill {id: 'skill-aws-architect'}), (aws_fund:Skill {id: 'skill-aws-fundamentals'})
MERGE (aws_arch)-[:REQUIRES {priority: 1, type: 'hard'}]->(aws_fund);

MATCH (aws_fund:Skill {id: 'skill-aws-fundamentals'}), (linux:Skill {id: 'skill-linux'})
MERGE (aws_fund)-[:REQUIRES {priority: 1, type: 'soft'}]->(linux);

MATCH (azure_fund:Skill {id: 'skill-azure-fundamentals'}), (linux:Skill {id: 'skill-linux'})
MERGE (azure_fund)-[:REQUIRES {priority: 1, type: 'soft'}]->(linux);

// ====================================================================================================
// SECTION 5: DEVOPS & PLATFORM ENGINEERING DOMAIN
// ====================================================================================================

// DEVOPS SUBDOMAINS
MERGE (cicd:SubDomain {id: 'sub-cicd'})
ON CREATE SET
    cicd.name = 'CI/CD & Automation',
    cicd.description = 'Continuous Integration, Deployment, and Delivery pipelines',
    cicd.order = 1;

MERGE (iac:SubDomain {id: 'sub-iac'})
ON CREATE SET
    iac.name = 'Infrastructure as Code',
    iac.description = 'Terraform, Ansible, Pulumi',
    iac.order = 2;

MERGE (gitops:SubDomain {id: 'sub-gitops'})
ON CREATE SET
    gitops.name = 'GitOps',
    gitops.description = 'Git-centric operational workflows, ArgoCD, Flux',
    gitops.order = 3;

MERGE (containers:SubDomain {id: 'sub-containers'})
ON CREATE SET
    containers.name = 'Containerization & Orchestration',
    containers.description = 'Docker, Kubernetes, Container registries',
    containers.order = 4;

MATCH (devops:Domain {id: 'domain-devops'}), (s:SubDomain)
WHERE s.id IN ['sub-cicd', 'sub-iac', 'sub-gitops', 'sub-containers']
MERGE (devops)-[:CONTAINS]->(s);

// DEVOPS SKILLS
MERGE (docker:Skill {id: 'skill-docker'})
ON CREATE SET
    docker.name = 'Docker',
    docker.difficulty_level = 'beginner',
    docker.estimated_hours = 25,
    docker.demand_score = 9,
    docker.category = 'containers',
    docker.prereq_level = 1;

MERGE (cicd_pipelines:Skill {id: 'skill-cicd-pipelines'})
ON CREATE SET
    cicd_pipelines.name = 'CI/CD Pipeline Design',
    cicd_pipelines.difficulty_level = 'intermediate',
    cicd_pipelines.estimated_hours = 60,
    cicd_pipelines.demand_score = 8,
    cicd_pipelines.category = 'cicd',
    cicd_pipelines.prereq_level = 2;

MERGE (terraform:Skill {id: 'skill-terraform'})
ON CREATE SET
    terraform.name = 'Terraform',
    terraform.difficulty_level = 'intermediate',
    terraform.estimated_hours = 70,
    terraform.demand_score = 9,
    terraform.category = 'iac',
    terraform.prereq_level = 2;

MERGE (ansible:Skill {id: 'skill-ansible'})
ON CREATE SET
    ansible.name = 'Ansible',
    ansible.difficulty_level = 'intermediate',
    ansible.estimated_hours = 40,
    ansible.demand_score = 6,
    ansible.category = 'iac',
    ansible.prereq_level = 2;

MERGE (argocd:Skill {id: 'skill-argocd'})
ON CREATE SET
    argocd.name = 'ArgoCD/Flux',
    argocd.difficulty_level = 'intermediate',
    argocd.estimated_hours = 30,
    argocd.demand_score = 7,
    argocd.category = 'gitops',
    argocd.prereq_level = 3;

// DEVOPS SKILL RELATIONSHIPS
MATCH (sd:SubDomain {id: 'sub-cicd'}), (s:Skill {id: 'skill-cicd-pipelines'})
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-iac'}), (s:Skill)
WHERE s.id IN ['skill-terraform', 'skill-ansible']
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-gitops'}), (s:Skill {id: 'skill-argocd'})
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-containers'}), (s:Skill)
WHERE s.id IN ['skill-docker', 'skill-kubernetes']
MERGE (sd)-[:CONTAINS]->(s);

// DEVOPS PREREQUISITES
MATCH (k8s:Skill {id: 'skill-kubernetes'}), (docker:Skill {id: 'skill-docker'})
MERGE (k8s)-[:REQUIRES {priority: 1, type: 'hard'}]->(docker);

MATCH (docker:Skill {id: 'skill-docker'}), (linux:Skill {id: 'skill-linux'})
MERGE (docker)-[:REQUIRES {priority: 1, type: 'soft'}]->(linux);

MATCH (terraform:Skill {id: 'skill-terraform'}), (linux:Skill {id: 'skill-linux'})
MERGE (terraform)-[:REQUIRES {priority: 1, type: 'soft'}]->(linux);

MATCH (ansible:Skill {id: 'skill-ansible'}), (linux:Skill {id: 'skill-linux'})
MERGE (ansible)-[:REQUIRES {priority: 1, type: 'hard'}]->(linux);

MATCH (ansible:Skill {id: 'skill-ansible'}), (python:Skill {id: 'skill-python'})
MERGE (ansible)-[:REQUIRES {priority: 2, type: 'soft'}]->(python);

MATCH (argo:Skill {id: 'skill-argocd'}), (k8s:Skill {id: 'skill-kubernetes'})
MERGE (argo)-[:REQUIRES {priority: 1, type: 'hard'}]->(k8s);

MATCH (cicd:Skill {id: 'skill-cicd-pipelines'}), (git:Skill {id: 'skill-git'})
MERGE (cicd)-[:REQUIRES {priority: 1, type: 'hard'}]->(git);

// ====================================================================================================
// SECTION 6: AI & MACHINE LEARNING DOMAIN
// ====================================================================================================

// AI SUBDOMAINS
MERGE (ml_fundamentals:SubDomain {id: 'sub-ml-fundamentals'})
ON CREATE SET 
    ml_fundamentals.name = 'ML Fundamentals',
    ml_fundamentals.description = 'Core machine learning concepts and algorithms',
    ml_fundamentals.order = 1;

MERGE (deep_learning:SubDomain {id: 'sub-deep-learning'})
ON CREATE SET
    deep_learning.name = 'Deep Learning',
    deep_learning.description = 'Neural networks and deep learning frameworks',
    deep_learning.order = 2;

MERGE (gen_ai:SubDomain {id: 'sub-gen-ai'})
ON CREATE SET
    gen_ai.name = 'Generative AI',
    gen_ai.description = 'LLMs, RAG, Prompt Engineering, Fine-tuning',
    gen_ai.order = 3;

MERGE (mlops:SubDomain {id: 'sub-mlops'})
ON CREATE SET
    mlops.name = 'MLOps',
    mlops.description = 'ML in production, model deployment and monitoring',
    mlops.order = 4;

MATCH (ai:Domain {id: 'domain-ai-ml'}), (s:SubDomain) 
WHERE s.id IN ['sub-ml-fundamentals', 'sub-deep-learning', 'sub-gen-ai', 'sub-mlops']
MERGE (ai)-[:CONTAINS]->(s);

// AI SKILLS
MERGE (ml_basics:Skill {id: 'skill-ml-basics'})
ON CREATE SET
    ml_basics.name = 'ML Fundamentals & Concepts',
    ml_basics.difficulty_level = 'beginner',
    ml_basics.estimated_hours = 60,
    ml_basics.demand_score = 9,
    ml_basics.category = 'ml-fundamentals',
    ml_basics.prereq_level = 2;

MERGE (deep_learning_skill:Skill {id: 'skill-deep-learning'})
ON CREATE SET
    deep_learning_skill.name = 'Deep Learning Foundations',
    deep_learning_skill.difficulty_level = 'intermediate',
    deep_learning_skill.estimated_hours = 120,
    deep_learning_skill.demand_score = 9,
    deep_learning_skill.category = 'deep-learning',
    deep_learning_skill.prereq_level = 3;

MERGE (pytorch:Skill {id: 'skill-pytorch'})
ON CREATE SET
    pytorch.name = 'PyTorch',
    pytorch.difficulty_level = 'intermediate',
    pytorch.estimated_hours = 50,
    pytorch.demand_score = 8,
    pytorch.category = 'deep-learning',
    pytorch.prereq_level = 3;

MERGE (llm_engineering:Skill {id: 'skill-llm-engineering'})
ON CREATE SET
    llm_engineering.name = 'LLM Engineering',
    llm_engineering.difficulty_level = 'intermediate',
    llm_engineering.estimated_hours = 80,
    llm_engineering.demand_score = 10,
    llm_engineering.category = 'gen-ai',
    llm_engineering.prereq_level = 3;

MERGE (prompt_engineering:Skill {id: 'skill-prompt-engineering'})
ON CREATE SET
    prompt_engineering.name = 'Prompt Engineering',
    prompt_engineering.difficulty_level = 'beginner',
    prompt_engineering.estimated_hours = 20,
    prompt_engineering.demand_score = 9,
    prompt_engineering.category = 'gen-ai',
    prompt_engineering.prereq_level = 1;

MERGE (rag:Skill {id: 'skill-rag'})
ON CREATE SET
    rag.name = 'Retrieval Augmented Generation (RAG)',
    rag.difficulty_level = 'intermediate',
    rag.estimated_hours = 30,
    rag.demand_score = 9,
    rag.category = 'gen-ai',
    rag.prereq_level = 3;

MERGE (vector_databases:Skill {id: 'skill-vector-db'})
ON CREATE SET
    vector_databases.name = 'Vector Databases & Indexing',
    vector_databases.difficulty_level = 'intermediate',
    vector_databases.estimated_hours = 40,
    vector_databases.demand_score = 8,
    vector_databases.category = 'gen-ai',
    vector_databases.prereq_level = 2;

MERGE (langchain:Skill {id: 'skill-langchain'})
ON CREATE SET
    langchain.name = 'LangChain/LlamaIndex',
    langchain.difficulty_level = 'intermediate',
    langchain.estimated_hours = 40,
    langchain.demand_score = 8,
    langchain.category = 'gen-ai',
    langchain.prereq_level = 3;

MERGE (mlflow:Skill {id: 'skill-mlflow'})
ON CREATE SET
    mlflow.name = 'MLflow',
    mlflow.difficulty_level = 'intermediate',
    mlflow.estimated_hours = 30,
    mlflow.demand_score = 7,
    mlflow.category = 'mlops',
    mlflow.prereq_level = 2;

// AI SKILL RELATIONSHIPS
MATCH (sd:SubDomain {id: 'sub-ml-fundamentals'}), (s:Skill {id: 'skill-ml-basics'})
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-deep-learning'}), (s:Skill)
WHERE s.id IN ['skill-deep-learning', 'skill-pytorch']
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-gen-ai'}), (s:Skill)
WHERE s.id IN ['skill-llm-engineering', 'skill-prompt-engineering', 'skill-vector-db', 'skill-rag', 'skill-langchain']
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-mlops'}), (s:Skill {id: 'skill-mlflow'})
MERGE (sd)-[:CONTAINS]->(s);

// AI SKILL PREREQUISITES
MATCH (ml:Skill {id: 'skill-ml-basics'}), (py:Skill {id: 'skill-python'})
MERGE (ml)-[:REQUIRES {priority: 1, type: 'hard'}]->(py);

MATCH (dl:Skill {id: 'skill-deep-learning'}), (ml:Skill {id: 'skill-ml-basics'})
MERGE (dl)-[:REQUIRES {priority: 1, type: 'hard'}]->(ml);

MATCH (pt:Skill {id: 'skill-pytorch'}), (dl:Skill {id: 'skill-deep-learning'})
MERGE (pt)-[:REQUIRES {priority: 1, type: 'hard'}]->(dl);

MATCH (llm:Skill {id: 'skill-llm-engineering'}), (dl:Skill {id: 'skill-deep-learning'})
MERGE (llm)-[:REQUIRES {priority: 1, type: 'soft'}]->(dl);

MATCH (rag:Skill {id: 'skill-rag'}), (vdb:Skill {id: 'skill-vector-db'})
MERGE (rag)-[:REQUIRES {priority: 1, type: 'hard'}]->(vdb);

MATCH (lc:Skill {id: 'skill-langchain'}), (llm:Skill {id: 'skill-llm-engineering'})
MERGE (lc)-[:REQUIRES {priority: 1, type: 'soft'}]->(llm);

MATCH (mlflow:Skill {id: 'skill-mlflow'}), (python:Skill {id: 'skill-python'})
MERGE (mlflow)-[:REQUIRES {priority: 1, type: 'hard'}]->(python);

// ====================================================================================================
// SECTION 7: SRE (SITE RELIABILITY ENGINEERING) DOMAIN - EXPANDED
// ====================================================================================================

// SRE SUBDOMAINS
MERGE (observability:SubDomain {id: 'sub-observability'})
ON CREATE SET
    observability.name = 'Observability',
    observability.description = 'Monitoring, logging, tracing, and metrics',
    observability.order = 1;

MERGE (incident_mgmt:SubDomain {id: 'sub-incident-mgmt'})
ON CREATE SET
    incident_mgmt.name = 'Incident Management',
    incident_mgmt.description = 'On-call, incident response, post-mortems',
    incident_mgmt.order = 2;

MERGE (reliability:SubDomain {id: 'sub-reliability'})
ON CREATE SET
    reliability.name = 'Reliability Engineering',
    reliability.description = 'SLOs, SLIs, error budgets, chaos engineering',
    reliability.order = 3;

MERGE (performance:SubDomain {id: 'sub-performance'})
ON CREATE SET
    performance.name = 'Performance Engineering',
    performance.description = 'Load testing, optimization, capacity planning',
    performance.order = 4;

MERGE (automation:SubDomain {id: 'sub-sre-automation'})
ON CREATE SET
    automation.name = 'SRE Automation',
    automation.description = 'Toil reduction, runbook automation, self-healing',
    automation.order = 5;

MATCH (sre:Domain {id: 'domain-sre'}), (s:SubDomain)
WHERE s.id IN ['sub-observability', 'sub-incident-mgmt', 'sub-reliability', 'sub-performance', 'sub-sre-automation']
MERGE (sre)-[:CONTAINS]->(s);

// SRE SKILLS
MERGE (prometheus:Skill {id: 'skill-prometheus'})
ON CREATE SET
    prometheus.name = 'Prometheus & Grafana',
    prometheus.difficulty_level = 'intermediate',
    prometheus.estimated_hours = 40,
    prometheus.demand_score = 8,
    prometheus.category = 'observability',
    prometheus.prereq_level = 2;

MERGE (elk:Skill {id: 'skill-elk'})
ON CREATE SET
    elk.name = 'ELK Stack (Elasticsearch, Logstash, Kibana)',
    elk.difficulty_level = 'intermediate',
    elk.estimated_hours = 50,
    elk.demand_score = 7,
    elk.category = 'observability',
    elk.prereq_level = 2;

MERGE (datadog:Skill {id: 'skill-datadog'})
ON CREATE SET
    datadog.name = 'Datadog/New Relic',
    datadog.difficulty_level = 'intermediate',
    datadog.estimated_hours = 30,
    datadog.demand_score = 8,
    datadog.category = 'observability',
    datadog.prereq_level = 2;

MERGE (slos:Skill {id: 'skill-slos'})
ON CREATE SET
    slos.name = 'SLOs, SLIs, and Error Budgets',
    slos.difficulty_level = 'intermediate',
    slos.estimated_hours = 30,
    slos.demand_score = 8,
    slos.category = 'reliability',
    slos.prereq_level = 3;

MERGE (chaos:Skill {id: 'skill-chaos-engineering'})
ON CREATE SET
    chaos.name = 'Chaos Engineering',
    chaos.difficulty_level = 'expert',
    chaos.estimated_hours = 40,
    chaos.demand_score = 6,
    chaos.category = 'reliability',
    chaos.prereq_level = 4;

MERGE (incident_response:Skill {id: 'skill-incident-response'})
ON CREATE SET
    incident_response.name = 'Incident Response & Management',
    incident_response.difficulty_level = 'intermediate',
    incident_response.estimated_hours = 25,
    incident_response.demand_score = 9,
    incident_response.category = 'incident-mgmt',
    incident_response.prereq_level = 2;

MERGE (load_testing:Skill {id: 'skill-load-testing'})
ON CREATE SET
    load_testing.name = 'Load Testing & Performance Tuning',
    load_testing.difficulty_level = 'intermediate',
    load_testing.estimated_hours = 35,
    load_testing.demand_score = 7,
    load_testing.category = 'performance',
    load_testing.prereq_level = 3;

MERGE (runbook_automation:Skill {id: 'skill-runbook-automation'})
ON CREATE SET
    runbook_automation.name = 'Runbook Automation',
    runbook_automation.difficulty_level = 'intermediate',
    runbook_automation.estimated_hours = 30,
    runbook_automation.demand_score = 7,
    runbook_automation.category = 'automation',
    runbook_automation.prereq_level = 3;

// SRE SKILL RELATIONSHIPS
MATCH (sd:SubDomain {id: 'sub-observability'}), (s:Skill)
WHERE s.id IN ['skill-prometheus', 'skill-elk', 'skill-datadog']
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-reliability'}), (s:Skill)
WHERE s.id IN ['skill-slos', 'skill-chaos-engineering']
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-incident-mgmt'}), (s:Skill {id: 'skill-incident-response'})
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-performance'}), (s:Skill {id: 'skill-load-testing'})
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-sre-automation'}), (s:Skill {id: 'skill-runbook-automation'})
MERGE (sd)-[:CONTAINS]->(s);

// SRE PREREQUISITES
MATCH (prom:Skill {id: 'skill-prometheus'}), (k8s:Skill {id: 'skill-kubernetes'})
MERGE (prom)-[:REQUIRES {priority: 1, type: 'soft'}]->(k8s);

MATCH (elk:Skill {id: 'skill-elk'}), (linux:Skill {id: 'skill-linux'})
MERGE (elk)-[:REQUIRES {priority: 1, type: 'hard'}]->(linux);

MATCH (slos:Skill {id: 'skill-slos'}), (prom:Skill {id: 'skill-prometheus'})
MERGE (slos)-[:REQUIRES {priority: 1, type: 'soft'}]->(prom);

MATCH (chaos:Skill {id: 'skill-chaos-engineering'}), (slos:Skill {id: 'skill-slos'})
MERGE (chaos)-[:REQUIRES {priority: 1, type: 'hard'}]->(slos);

// ====================================================================================================
// SECTION 8: DATA ENGINEERING DOMAIN
// ====================================================================================================

// DATA SUBDOMAINS
MERGE (data_pipelines:SubDomain {id: 'sub-data-pipelines'})
ON CREATE SET
    data_pipelines.name = 'Data Pipelines',
    data_pipelines.description = 'ETL/ELT, batch and stream processing',
    data_pipelines.order = 1;

MERGE (data_warehousing:SubDomain {id: 'sub-data-warehousing'})
ON CREATE SET
    data_warehousing.name = 'Data Warehousing',
    data_warehousing.description = 'Modern data warehouses, lakehouses',
    data_warehousing.order = 2;

MERGE (analytics_engineering:SubDomain {id: 'sub-analytics-eng'})
ON CREATE SET
    analytics_engineering.name = 'Analytics Engineering',
    analytics_engineering.description = 'dbt, data modeling, self-service analytics',
    analytics_engineering.order = 3;

MATCH (data:Domain {id: 'domain-data'}), (s:SubDomain)
WHERE s.id IN ['sub-data-pipelines', 'sub-data-warehousing', 'sub-analytics-eng']
MERGE (data)-[:CONTAINS]->(s);

// DATA SKILLS
MERGE (airflow:Skill {id: 'skill-airflow'})
ON CREATE SET
    airflow.name = 'Apache Airflow',
    airflow.difficulty_level = 'intermediate',
    airflow.estimated_hours = 50,
    airflow.demand_score = 9,
    airflow.category = 'data-pipelines',
    airflow.prereq_level = 2;

MERGE (spark:Skill {id: 'skill-spark'})
ON CREATE SET
    spark.name = 'Apache Spark',
    spark.difficulty_level = 'intermediate',
    spark.estimated_hours = 70,
    spark.demand_score = 8,
    spark.category = 'data-pipelines',
    spark.prereq_level = 3;

MERGE (snowflake:Skill {id: 'skill-snowflake'})
ON CREATE SET
    snowflake.name = 'Snowflake',
    snowflake.difficulty_level = 'intermediate',
    snowflake.estimated_hours = 40,
    snowflake.demand_score = 9,
    snowflake.category = 'data-warehousing',
    snowflake.prereq_level = 2;

MERGE (dbt_skill:Skill {id: 'skill-dbt'})
ON CREATE SET
    dbt_skill.name = 'dbt (data build tool)',
    dbt_skill.difficulty_level = 'intermediate',
    dbt_skill.estimated_hours = 40,
    dbt_skill.demand_score = 10,
    dbt_skill.category = 'analytics-eng',
    dbt_skill.prereq_level = 2;

// DATA SKILL RELATIONSHIPS
MATCH (sd:SubDomain {id: 'sub-data-pipelines'}), (s:Skill)
WHERE s.id IN ['skill-airflow', 'skill-spark']
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-data-warehousing'}), (s:Skill {id: 'skill-snowflake'})
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-analytics-eng'}), (s:Skill {id: 'skill-dbt'})
MERGE (sd)-[:CONTAINS]->(s);

// DATA PREREQUISITES
MATCH (airflow:Skill {id: 'skill-airflow'}), (python:Skill {id: 'skill-python'})
MERGE (airflow)-[:REQUIRES {priority: 1, type: 'hard'}]->(python);

MATCH (spark:Skill {id: 'skill-spark'}), (sql:Skill {id: 'skill-sql'})
MERGE (spark)-[:REQUIRES {priority: 1, type: 'hard'}]->(sql);

MATCH (spark:Skill {id: 'skill-spark'}), (python:Skill {id: 'skill-python'})
MERGE (spark)-[:REQUIRES {priority: 2, type: 'soft'}]->(python);

MATCH (snowflake:Skill {id: 'skill-snowflake'}), (sql:Skill {id: 'skill-sql'})
MERGE (snowflake)-[:REQUIRES {priority: 1, type: 'hard'}]->(sql);

MATCH (dbt:Skill {id: 'skill-dbt'}), (sql:Skill {id: 'skill-sql'})
MERGE (dbt)-[:REQUIRES {priority: 1, type: 'hard'}]->(sql);

// ====================================================================================================
// SECTION 9: SECURITY & COMPLIANCE DOMAIN
// ====================================================================================================

// SECURITY SUBDOMAINS
MERGE (cloud_security:SubDomain {id: 'sub-sec-cloud-security'})
ON CREATE SET
    cloud_security.name = 'Cloud Security',
    cloud_security.description = 'IAM, encryption, cloud-native security',
    cloud_security.order = 1;

MERGE (devsecops_sub:SubDomain {id: 'sub-sec-devsecops'})
ON CREATE SET
    devsecops_sub.name = 'DevSecOps',
    devsecops_sub.description = 'Security in CI/CD, SAST, DAST',
    devsecops_sub.order = 2;

MATCH (security:Domain {id: 'domain-security'}), (s:SubDomain)
WHERE s.id IN ['sub-sec-cloud-security', 'sub-sec-devsecops']
MERGE (security)-[:CONTAINS]->(s);

// SECURITY SKILLS
MERGE (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'})
ON CREATE SET
    cloud_security_fundamentals.name = 'Cloud Security Fundamentals',
    cloud_security_fundamentals.difficulty_level = 'intermediate',
    cloud_security_fundamentals.estimated_hours = 40,
    cloud_security_fundamentals.demand_score = 8,
    cloud_security_fundamentals.category = 'cloud-security',
    cloud_security_fundamentals.prereq_level = 2;

MERGE (devsecops_skill:Skill {id: 'skill-devsecops'})
ON CREATE SET
    devsecops_skill.name = 'DevSecOps Pipelines & Tools',
    devsecops_skill.difficulty_level = 'intermediate',
    devsecops_skill.estimated_hours = 50,
    devsecops_skill.demand_score = 8,
    devsecops_skill.category = 'devsecops',
    devsecops_skill.prereq_level = 3;

// SECURITY SKILL RELATIONSHIPS
MATCH (sd:SubDomain {id: 'sub-sec-cloud-security'}), (s:Skill {id: 'skill-cloud-security-fundamentals'})
MERGE (sd)-[:CONTAINS]->(s);

MATCH (sd:SubDomain {id: 'sub-sec-devsecops'}), (s:Skill {id: 'skill-devsecops'})
MERGE (sd)-[:CONTAINS]->(s);

// SECURITY PREREQUISITES
MATCH (cloud_sec:Skill {id: 'skill-cloud-security-fundamentals'}), (aws:Skill {id: 'skill-aws-fundamentals'})
MERGE (cloud_sec)-[:REQUIRES {priority: 1, type: 'soft'}]->(aws);

MATCH (devsecops:Skill {id: 'skill-devsecops'}), (cicd:Skill {id: 'skill-cicd-pipelines'})
MERGE (devsecops)-[:REQUIRES {priority: 1, type: 'hard'}]->(cicd);

// ====================================================================================================
// SECTION 10: CERTIFICATIONS WITH PROPER PREREQUISITES
// ====================================================================================================

MERGE (aws_sa:Certification {id: 'cert-aws-sa'})
ON CREATE SET
    aws_sa.name = 'AWS Solutions Architect - Associate',
    aws_sa.provider = 'AWS',
    aws_sa.level = 'Associate',
    aws_sa.cost = 150,
    aws_sa.validity_period = '3 years';

MERGE (azure_admin_cert:Certification {id: 'cert-azure-admin'})
ON CREATE SET
    azure_admin_cert.name = 'Azure Administrator Associate (AZ-104)',
    azure_admin_cert.provider = 'Microsoft',
    azure_admin_cert.level = 'Associate',
    azure_admin_cert.cost = 165,
    azure_admin_cert.validity_period = '1 year';

MERGE (cka:Certification {id: 'cert-cka'})
ON CREATE SET
    cka.name = 'Certified Kubernetes Administrator',
    cka.provider = 'CNCF',
    cka.level = 'Professional',
    cka.cost = 395,
    cka.validity_period = '3 years';

MERGE (terraform_cert:Certification {id: 'cert-terraform'})
ON CREATE SET
    terraform_cert.name = 'HashiCorp Terraform Associate',
    terraform_cert.provider = 'HashiCorp',
    terraform_cert.level = 'Associate',
    terraform_cert.cost = 70,
    terraform_cert.validity_period = '2 years';

// CERTIFICATION RELATIONSHIPS
MATCH (aws_arch:Skill {id: 'skill-aws-architect'}), (cert:Certification {id: 'cert-aws-sa'})
MERGE (aws_arch)-[:LEADS_TO]->(cert);

MATCH (azure_fund:Skill {id: 'skill-azure-fundamentals'}), (cert:Certification {id: 'cert-azure-admin'})
MERGE (azure_fund)-[:LEADS_TO]->(cert);

MATCH (k8s:Skill {id: 'skill-kubernetes'}), (cert:Certification {id: 'cert-cka'})
MERGE (k8s)-[:LEADS_TO]->(cert);

MATCH (tf:Skill {id: 'skill-terraform'}), (cert:Certification {id: 'cert-terraform'})
MERGE (tf)-[:LEADS_TO]->(cert);

// ====================================================================================================
// SECTION 11: RESOURCES (Expanded with missing ones)
// ====================================================================================================

// Git Resources
MERGE (git_docs:Resource {id: 'res-git-docs'})
ON CREATE SET
    git_docs.title = 'Pro Git Book',
    git_docs.type = 'book',
    git_docs.url = 'https://git-scm.com/book',
    git_docs.provider = 'Git SCM',
    git_docs.cost = 0;

MATCH (git:Skill {id: 'skill-git'}), (res:Resource {id: 'res-git-docs'})
MERGE (git)-[:HAS_RESOURCE]->(res);

// Python Resources
MERGE (python_crash:Resource {id: 'res-python-crash'})
ON CREATE SET
    python_crash.title = 'Python Crash Course',
    python_crash.type = 'book',
    python_crash.url = 'https://nostarch.com/pythoncrashcourse2e',
    python_crash.provider = 'No Starch Press',
    python_crash.cost = 35;

MATCH (python:Skill {id: 'skill-python'}), (res:Resource {id: 'res-python-crash'})
MERGE (python)-[:HAS_RESOURCE]->(res);

// SQL Resources
MERGE (sql_tutorial:Resource {id: 'res-sql-tutorial'})
ON CREATE SET
    sql_tutorial.title = 'SQLBolt Interactive Tutorial',
    sql_tutorial.type = 'tutorial',
    sql_tutorial.url = 'https://sqlbolt.com/',
    sql_tutorial.provider = 'SQLBolt',
    sql_tutorial.cost = 0;

MATCH (sql:Skill {id: 'skill-sql'}), (res:Resource {id: 'res-sql-tutorial'})
MERGE (sql)-[:HAS_RESOURCE]->(res);

// AWS Fundamentals Resources
MERGE (aws_training:Resource {id: 'res-aws-training'})
ON CREATE SET
    aws_training.title = 'AWS Cloud Practitioner Essentials',
    aws_training.type = 'course',
    aws_training.url = 'https://aws.amazon.com/training/digital/aws-cloud-practitioner-essentials/',
    aws_training.provider = 'AWS',
    aws_training.cost = 0;

MATCH (aws:Skill {id: 'skill-aws-fundamentals'}), (res:Resource {id: 'res-aws-training'})
MERGE (aws)-[:HAS_RESOURCE]->(res);

// LLM Engineering Resources
MERGE (llm_course:Resource {id: 'res-llm-course'})
ON CREATE SET
    llm_course.title = 'LLM University by Cohere',
    llm_course.type = 'course',
    llm_course.url = 'https://docs.cohere.com/docs/llmu',
    llm_course.provider = 'Cohere',
    llm_course.cost = 0;

MATCH (llm:Skill {id: 'skill-llm-engineering'}), (res:Resource {id: 'res-llm-course'})
MERGE (llm)-[:HAS_RESOURCE]->(res);

// Terraform Resources
MERGE (terraform_docs:Resource {id: 'res-terraform-docs'})
ON CREATE SET
    terraform_docs.title = 'Terraform Documentation',
    terraform_docs.type = 'documentation',
    terraform_docs.url = 'https://developer.hashicorp.com/terraform/docs',
    terraform_docs.provider = 'HashiCorp',
    terraform_docs.cost = 0;

MATCH (tf:Skill {id: 'skill-terraform'}), (res:Resource {id: 'res-terraform-docs'})
MERGE (tf)-[:HAS_RESOURCE]->(res);

// dbt Resources
MERGE (dbt_fundamentals:Resource {id: 'res-dbt-fundamentals'})
ON CREATE SET
    dbt_fundamentals.title = 'dbt Fundamentals Course',
    dbt_fundamentals.type = 'course',
    dbt_fundamentals.url = 'https://courses.getdbt.com/courses/fundamentals',
    dbt_fundamentals.provider = 'dbt Labs',
    dbt_fundamentals.cost = 0;

MATCH (dbt:Skill {id: 'skill-dbt'}), (res:Resource {id: 'res-dbt-fundamentals'})
MERGE (dbt)-[:HAS_RESOURCE]->(res);

// ML Resources
MERGE (ml_coursera:Resource {id: 'res-ml-coursera'})
ON CREATE SET
    ml_coursera.title = 'Machine Learning Specialization',
    ml_coursera.type = 'course',
    ml_coursera.url = 'https://www.coursera.org/specializations/machine-learning-introduction',
    ml_coursera.provider = 'Coursera',
    ml_coursera.cost = 49;

MATCH (ml:Skill {id: 'skill-ml-basics'}), (res:Resource {id: 'res-ml-coursera'})
MERGE (ml)-[:HAS_RESOURCE]->(res);

// Docker Resources
MERGE (docker_docs:Resource {id: 'res-docker-docs'})
ON CREATE SET
    docker_docs.title = 'Docker Official Documentation',
    docker_docs.type = 'documentation',
    docker_docs.url = 'https://docs.docker.com/',
    docker_docs.provider = 'Docker',
    docker_docs.cost = 0;

MATCH (docker:Skill {id: 'skill-docker'}), (res:Resource {id: 'res-docker-docs'})
MERGE (docker)-[:HAS_RESOURCE]->(res);

// Kubernetes Resources
MERGE (k8s_hardway:Resource {id: 'res-k8s-hardway'})
ON CREATE SET
    k8s_hardway.title = 'Kubernetes The Hard Way',
    k8s_hardway.type = 'guide',
    k8s_hardway.url = 'https://github.com/kelseyhightower/kubernetes-the-hard-way',
    k8s_hardway.provider = 'Kelsey Hightower',
    k8s_hardway.cost = 0;

MATCH (k8s:Skill {id: 'skill-kubernetes'}), (res:Resource {id: 'res-k8s-hardway'})
MERGE (k8s)-[:HAS_RESOURCE]->(res);

// React Resources
MERGE (react_docs:Resource {id: 'res-react-docs'})
ON CREATE SET
    react_docs.title = 'React Official Documentation',
    react_docs.type = 'documentation',
    react_docs.url = 'https://react.dev/',
    react_docs.provider = 'Meta',
    react_docs.cost = 0;

MATCH (react:Skill {id: 'skill-react'}), (res:Resource {id: 'res-react-docs'})
MERGE (react)-[:HAS_RESOURCE]->(res);

// ====================================================================================================
// SECTION 12: CROSS-DOMAIN SKILL APPLICATIONS
// ====================================================================================================

// Foundational skills apply across multiple domains
MATCH (git:Skill {id: 'skill-git'}), (d:Domain) 
WHERE d.id IN ['domain-software', 'domain-devops', 'domain-data']
MERGE (git)-[:APPLIES_IN]->(d);

MATCH (python:Skill {id: 'skill-python'}), (d:Domain)
WHERE d.id IN ['domain-ai-ml', 'domain-data', 'domain-devops', 'domain-software']
MERGE (python)-[:APPLIES_IN]->(d);

MATCH (sql:Skill {id: 'skill-sql'}), (d:Domain)
WHERE d.id IN ['domain-data', 'domain-software', 'domain-ai-ml']
MERGE (sql)-[:APPLIES_IN]->(d);

MATCH (linux:Skill {id: 'skill-linux'}), (d:Domain)
WHERE d.id IN ['domain-cloud', 'domain-devops', 'domain-sre']
MERGE (linux)-[:APPLIES_IN]->(d);

MATCH (k8s:Skill {id: 'skill-kubernetes'}), (d:Domain)
WHERE d.id IN ['domain-cloud', 'domain-devops', 'domain-sre']
MERGE (k8s)-[:APPLIES_IN]->(d);

MATCH (tf:Skill {id: 'skill-terraform'}), (d:Domain)
WHERE d.id IN ['domain-cloud', 'domain-devops']
MERGE (tf)-[:APPLIES_IN]->(d);

// ====================================================================================================
// SECTION 13: SKILL PROGRESSIONS (LEADS_TO relationships)
// ====================================================================================================

// Python learning path
MATCH (py:Skill {id: 'skill-python'}), (ml:Skill {id: 'skill-ml-basics'})
MERGE (py)-[:LEADS_TO]->(ml);

// ML learning path
MATCH (ml:Skill {id: 'skill-ml-basics'}), (dl:Skill {id: 'skill-deep-learning'})
MERGE (ml)-[:LEADS_TO]->(dl);

// Deep Learning to specialized areas
MATCH (dl:Skill {id: 'skill-deep-learning'}), (llm:Skill {id: 'skill-llm-engineering'})
MERGE (dl)-[:LEADS_TO]->(llm);

// Cloud progression
MATCH (aws_fund:Skill {id: 'skill-aws-fundamentals'}), (aws_arch:Skill {id: 'skill-aws-architect'})
MERGE (aws_fund)-[:LEADS_TO]->(aws_arch);

// Container progression
MATCH (docker:Skill {id: 'skill-docker'}), (k8s:Skill {id: 'skill-kubernetes'})
MERGE (docker)-[:LEADS_TO]->(k8s);

// Frontend progression
MATCH (js:Skill {id: 'skill-javascript'}), (react:Skill {id: 'skill-react'})
MERGE (js)-[:LEADS_TO]->(react);

MATCH (js:Skill {id: 'skill-javascript'}), (ts:Skill {id: 'skill-typescript'})
MERGE (js)-[:LEADS_TO]->(ts);

// Database progression
MATCH (sql:Skill {id: 'skill-sql'}), (postgres:Skill {id: 'skill-postgresql'})
MERGE (sql)-[:LEADS_TO]->(postgres);

// Architecture progression
MATCH (api:Skill {id: 'skill-api-design'}), (micro:Skill {id: 'skill-microservices'})
MERGE (api)-[:LEADS_TO]->(micro);

MATCH (micro:Skill {id: 'skill-microservices'}), (sys:Skill {id: 'skill-system-design'})
MERGE (micro)-[:LEADS_TO]->(sys);

// DevOps progression
MATCH (cicd:Skill {id: 'skill-cicd-pipelines'}), (devsecops:Skill {id: 'skill-devsecops'})
MERGE (cicd)-[:LEADS_TO]->(devsecops);

// Infrastructure progression
MATCH (tf:Skill {id: 'skill-terraform'}), (ansible:Skill {id: 'skill-ansible'})
MERGE (tf)-[:LEADS_TO]->(ansible);

// Observability progression
MATCH (prom:Skill {id: 'skill-prometheus'}), (slos:Skill {id: 'skill-slos'})
MERGE (prom)-[:LEADS_TO]->(slos);

// Data engineering progression
MATCH (sql:Skill {id: 'skill-sql'}), (dbt:Skill {id: 'skill-dbt'})
MERGE (sql)-[:LEADS_TO]->(dbt);

MATCH (python:Skill {id: 'skill-python'}), (airflow:Skill {id: 'skill-airflow'})
MERGE (python)-[:LEADS_TO]->(airflow);

// ====================================================================================================
// END OF COMPLETE SCHEMA AND DATA CREATION
// ====================================================================================================

// ====================================================================================================
// APPEND SCRIPT - ADDITIONAL FIXES FOR PREREQUISITES AND RESOURCES
// Run this AFTER the main seed script to fix remaining issues
// This script is idempotent - safe to run multiple times
// ====================================================================================================

// ====================================================================================================
// SECTION 1: ADD MISSING PREREQUISITES
// ====================================================================================================

// Vector Databases - needs Python and basic database understanding
MATCH (vdb:Skill {id: 'skill-vector-db'}), (py:Skill {id: 'skill-python'})
MERGE (vdb)-[:REQUIRES {priority: 1, type: 'hard'}]->(py);

MATCH (vdb:Skill {id: 'skill-vector-db'}), (sql:Skill {id: 'skill-sql'})
MERGE (vdb)-[:REQUIRES {priority: 2, type: 'soft'}]->(sql);

// Datadog/New Relic - needs basic monitoring understanding
MATCH (datadog:Skill {id: 'skill-datadog'}), (linux:Skill {id: 'skill-linux'})
MERGE (datadog)-[:REQUIRES {priority: 1, type: 'soft'}]->(linux);

// Incident Response - needs monitoring tools
MATCH (incident:Skill {id: 'skill-incident-response'}), (prom:Skill {id: 'skill-prometheus'})
MERGE (incident)-[:REQUIRES {priority: 1, type: 'soft'}]->(prom);

// Load Testing - needs understanding of systems
MATCH (load:Skill {id: 'skill-load-testing'}), (api:Skill {id: 'skill-api-design'})
MERGE (load)-[:REQUIRES {priority: 1, type: 'soft'}]->(api);

// Runbook Automation - needs scripting and automation basics
MATCH (runbook:Skill {id: 'skill-runbook-automation'}), (py:Skill {id: 'skill-python'})
MERGE (runbook)-[:REQUIRES {priority: 1, type: 'soft'}]->(py);

MATCH (runbook:Skill {id: 'skill-runbook-automation'}), (ansible:Skill {id: 'skill-ansible'})
MERGE (runbook)-[:REQUIRES {priority: 2, type: 'soft'}]->(ansible);

// ====================================================================================================
// SECTION 2: ADD MISSING RESOURCES
// ====================================================================================================

// JavaScript Resources
MERGE (js_mdn:Resource {id: 'res-js-mdn'})
ON CREATE SET
    js_mdn.title = 'MDN JavaScript Guide',
    js_mdn.type = 'documentation',
    js_mdn.url = 'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide',
    js_mdn.provider = 'Mozilla',
    js_mdn.cost = 0,
    js_mdn.rating = 4.8;

MERGE (js_info:Resource {id: 'res-js-info'})
ON CREATE SET
    js_info.title = 'JavaScript.info - The Modern JavaScript Tutorial',
    js_info.type = 'tutorial',
    js_info.url = 'https://javascript.info/',
    js_info.provider = 'JavaScript.info',
    js_info.cost = 0,
    js_info.rating = 4.9;

MATCH (js:Skill {id: 'skill-javascript'}), (res1:Resource {id: 'res-js-mdn'})
MERGE (js)-[:HAS_RESOURCE]->(res1);

MATCH (js:Skill {id: 'skill-javascript'}), (res2:Resource {id: 'res-js-info'})
MERGE (js)-[:HAS_RESOURCE]->(res2);

// PostgreSQL Resources
MERGE (pg_tutorial:Resource {id: 'res-pg-tutorial'})
ON CREATE SET
    pg_tutorial.title = 'PostgreSQL Tutorial',
    pg_tutorial.type = 'tutorial',
    pg_tutorial.url = 'https://www.postgresqltutorial.com/',
    pg_tutorial.provider = 'PostgreSQL Tutorial',
    pg_tutorial.cost = 0,
    pg_tutorial.rating = 4.7;

MERGE (pg_docs:Resource {id: 'res-pg-docs'})
ON CREATE SET
    pg_docs.title = 'PostgreSQL Official Documentation',
    pg_docs.type = 'documentation',
    pg_docs.url = 'https://www.postgresql.org/docs/',
    pg_docs.provider = 'PostgreSQL',
    pg_docs.cost = 0,
    pg_docs.rating = 4.5;

MATCH (pg:Skill {id: 'skill-postgresql'}), (res1:Resource {id: 'res-pg-tutorial'})
MERGE (pg)-[:HAS_RESOURCE]->(res1);

MATCH (pg:Skill {id: 'skill-postgresql'}), (res2:Resource {id: 'res-pg-docs'})
MERGE (pg)-[:HAS_RESOURCE]->(res2);

// System Design Resources
MERGE (system_primer:Resource {id: 'res-system-primer'})
ON CREATE SET
    system_primer.title = 'System Design Primer',
    system_primer.type = 'guide',
    system_primer.url = 'https://github.com/donnemartin/system-design-primer',
    system_primer.provider = 'GitHub',
    system_primer.cost = 0,
    system_primer.rating = 4.9;

MERGE (system_book:Resource {id: 'res-system-book'})
ON CREATE SET
    system_book.title = 'Designing Data-Intensive Applications',
    system_book.type = 'book',
    system_book.url = 'https://dataintensive.net/',
    system_book.provider = 'OReilly',
    system_book.cost = 45,
    system_book.rating = 4.8;

MATCH (sys:Skill {id: 'skill-system-design'}), (res1:Resource {id: 'res-system-primer'})
MERGE (sys)-[:HAS_RESOURCE]->(res1);

MATCH (sys:Skill {id: 'skill-system-design'}), (res2:Resource {id: 'res-system-book'})
MERGE (sys)-[:HAS_RESOURCE]->(res2);

// AWS Solutions Architect Resources
MERGE (aws_cantrill:Resource {id: 'res-aws-cantrill'})
ON CREATE SET
    aws_cantrill.title = 'AWS Solutions Architect Associate Course',
    aws_cantrill.type = 'course',
    aws_cantrill.url = 'https://learn.cantrill.io/p/aws-certified-solutions-architect-associate-saa-c03',
    aws_cantrill.provider = 'Adrian Cantrill',
    aws_cantrill.cost = 50,
    aws_cantrill.rating = 4.9;

MERGE (aws_whitepapers:Resource {id: 'res-aws-whitepapers'})
ON CREATE SET
    aws_whitepapers.title = 'AWS Well-Architected Framework',
    aws_whitepapers.type = 'documentation',
    aws_whitepapers.url = 'https://aws.amazon.com/architecture/well-architected/',
    aws_whitepapers.provider = 'AWS',
    aws_whitepapers.cost = 0,
    aws_whitepapers.rating = 4.6;

MATCH (aws:Skill {id: 'skill-aws-architect'}), (res1:Resource {id: 'res-aws-cantrill'})
MERGE (aws)-[:HAS_RESOURCE]->(res1);

MATCH (aws:Skill {id: 'skill-aws-architect'}), (res2:Resource {id: 'res-aws-whitepapers'})
MERGE (aws)-[:HAS_RESOURCE]->(res2);

// Deep Learning Resources
MERGE (dl_coursera:Resource {id: 'res-dl-coursera'})
ON CREATE SET
    dl_coursera.title = 'Deep Learning Specialization',
    dl_coursera.type = 'course',
    dl_coursera.url = 'https://www.coursera.org/specializations/deep-learning',
    dl_coursera.provider = 'Coursera (Andrew Ng)',
    dl_coursera.cost = 49,
    dl_coursera.rating = 4.9;

MERGE (dl_book:Resource {id: 'res-dl-book'})
ON CREATE SET
    dl_book.title = 'Deep Learning (Ian Goodfellow)',
    dl_book.type = 'book',
    dl_book.url = 'https://www.deeplearningbook.org/',
    dl_book.provider = 'MIT Press',
    dl_book.cost = 0,
    dl_book.rating = 4.5;

MATCH (dl:Skill {id: 'skill-deep-learning'}), (res1:Resource {id: 'res-dl-coursera'})
MERGE (dl)-[:HAS_RESOURCE]->(res1);

MATCH (dl:Skill {id: 'skill-deep-learning'}), (res2:Resource {id: 'res-dl-book'})
MERGE (dl)-[:HAS_RESOURCE]->(res2);

// Prompt Engineering Resources
MERGE (prompt_guide:Resource {id: 'res-prompt-guide'})
ON CREATE SET
    prompt_guide.title = 'Prompt Engineering Guide',
    prompt_guide.type = 'guide',
    prompt_guide.url = 'https://www.promptingguide.ai/',
    prompt_guide.provider = 'DAIR.AI',
    prompt_guide.cost = 0,
    prompt_guide.rating = 4.7;

MERGE (prompt_openai:Resource {id: 'res-prompt-openai'})
ON CREATE SET
    prompt_openai.title = 'OpenAI Prompt Engineering Guide',
    prompt_openai.type = 'documentation',
    prompt_openai.url = 'https://platform.openai.com/docs/guides/prompt-engineering',
    prompt_openai.provider = 'OpenAI',
    prompt_openai.cost = 0,
    prompt_openai.rating = 4.6;

MATCH (prompt:Skill {id: 'skill-prompt-engineering'}), (res1:Resource {id: 'res-prompt-guide'})
MERGE (prompt)-[:HAS_RESOURCE]->(res1);

MATCH (prompt:Skill {id: 'skill-prompt-engineering'}), (res2:Resource {id: 'res-prompt-openai'})
MERGE (prompt)-[:HAS_RESOURCE]->(res2);

// RAG Resources
MERGE (rag_langchain:Resource {id: 'res-rag-langchain'})
ON CREATE SET
    rag_langchain.title = 'Building RAG Applications with LangChain',
    rag_langchain.type = 'tutorial',
    rag_langchain.url = 'https://python.langchain.com/docs/use_cases/question_answering/',
    rag_langchain.provider = 'LangChain',
    rag_langchain.cost = 0,
    rag_langchain.rating = 4.5;

MERGE (rag_pinecone:Resource {id: 'res-rag-pinecone'})
ON CREATE SET
    rag_pinecone.title = 'RAG: From Theory to Implementation',
    rag_pinecone.type = 'guide',
    rag_pinecone.url = 'https://www.pinecone.io/learn/retrieval-augmented-generation/',
    rag_pinecone.provider = 'Pinecone',
    rag_pinecone.cost = 0,
    rag_pinecone.rating = 4.6;

MATCH (rag:Skill {id: 'skill-rag'}), (res1:Resource {id: 'res-rag-langchain'})
MERGE (rag)-[:HAS_RESOURCE]->(res1);

MATCH (rag:Skill {id: 'skill-rag'}), (res2:Resource {id: 'res-rag-pinecone'})
MERGE (rag)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 3: VERIFICATION QUERY
// ====================================================================================================

// Run this to verify the fixes were applied
MATCH (s:Skill)
WHERE s.id IN [
    'skill-vector-db', 'skill-datadog', 'skill-incident-response', 
    'skill-load-testing', 'skill-runbook-automation', 'skill-javascript',
    'skill-postgresql', 'skill-system-design', 'skill-aws-architect',
    'skill-deep-learning', 'skill-prompt-engineering', 'skill-rag'
]
OPTIONAL MATCH (s)-[:REQUIRES]->(prereq:Skill)
OPTIONAL MATCH (s)-[:HAS_RESOURCE]->(res:Resource)
WITH s, 
     COUNT(DISTINCT prereq) AS prereqCount,
     COUNT(DISTINCT res) AS resourceCount
RETURN 
    s.name AS Skill,
    s.difficulty_level AS Level,
    prereqCount AS Prerequisites,
    resourceCount AS Resources,
    CASE 
        WHEN (s.difficulty_level IN ['intermediate', 'expert'] AND prereqCount > 0) OR s.difficulty_level = 'beginner' 
        THEN '✅' 
        ELSE '⚠️ Needs prereqs' 
    END AS PrereqStatus,
    CASE 
        WHEN resourceCount > 0 
        THEN '✅' 
        ELSE '❌ Needs resources' 
    END AS ResourceStatus
ORDER BY s.name;

// ====================================================================================================
// END OF APPEND FIXES
// ====================================================================================================

// ====================================================================================================
// APPEND SCRIPT - ADDITIONAL RESOURCES FOR REMAINING SKILLS
// Run this AFTER the main seed script and first append script
// This script is idempotent - safe to run multiple times
// ====================================================================================================

// ====================================================================================================
// SECTION 1: SRE & OBSERVABILITY RESOURCES
// ====================================================================================================

// SLOs, SLIs, and Error Budgets Resources
MERGE (slo_book:Resource {id: 'res-slo-book'})
ON CREATE SET
    slo_book.title = 'Implementing Service Level Objectives',
    slo_book.type = 'book',
    slo_book.url = 'https://www.oreilly.com/library/view/implementing-service-level/9781492076803/',
    slo_book.provider = 'OReilly',
    slo_book.cost = 45,
    slo_book.rating = 4.7;

MERGE (slo_google:Resource {id: 'res-slo-google'})
ON CREATE SET
    slo_google.title = 'Google SRE Workbook - SLOs',
    slo_google.type = 'guide',
    slo_google.url = 'https://sre.google/workbook/implementing-slos/',
    slo_google.provider = 'Google',
    slo_google.cost = 0,
    slo_google.rating = 4.8;

MATCH (slos:Skill {id: 'skill-slos'}), (res1:Resource {id: 'res-slo-book'})
MERGE (slos)-[:HAS_RESOURCE]->(res1);

MATCH (slos:Skill {id: 'skill-slos'}), (res2:Resource {id: 'res-slo-google'})
MERGE (slos)-[:HAS_RESOURCE]->(res2);

// ELK Stack Resources
MERGE (elk_guide:Resource {id: 'res-elk-guide'})
ON CREATE SET
    elk_guide.title = 'Elastic Stack Guide',
    elk_guide.type = 'documentation',
    elk_guide.url = 'https://www.elastic.co/guide/index.html',
    elk_guide.provider = 'Elastic',
    elk_guide.cost = 0,
    elk_guide.rating = 4.5;

MERGE (elk_course:Resource {id: 'res-elk-course'})
ON CREATE SET
    elk_course.title = 'Complete Guide to Elasticsearch',
    elk_course.type = 'course',
    elk_course.url = 'https://www.udemy.com/course/elasticsearch-complete-guide/',
    elk_course.provider = 'Udemy',
    elk_course.cost = 19,
    elk_course.rating = 4.6;

MATCH (elk:Skill {id: 'skill-elk'}), (res1:Resource {id: 'res-elk-guide'})
MERGE (elk)-[:HAS_RESOURCE]->(res1);

MATCH (elk:Skill {id: 'skill-elk'}), (res2:Resource {id: 'res-elk-course'})
MERGE (elk)-[:HAS_RESOURCE]->(res2);

// Load Testing Resources
MERGE (load_k6:Resource {id: 'res-load-k6'})
ON CREATE SET
    load_k6.title = 'k6 Documentation & Tutorials',
    load_k6.type = 'documentation',
    load_k6.url = 'https://k6.io/docs/',
    load_k6.provider = 'Grafana Labs',
    load_k6.cost = 0,
    load_k6.rating = 4.6;

MERGE (load_gatling:Resource {id: 'res-load-gatling'})
ON CREATE SET
    load_gatling.title = 'Performance Testing with Gatling',
    load_gatling.type = 'guide',
    load_gatling.url = 'https://gatling.io/docs/',
    load_gatling.provider = 'Gatling',
    load_gatling.cost = 0,
    load_gatling.rating = 4.5;

MATCH (load:Skill {id: 'skill-load-testing'}), (res1:Resource {id: 'res-load-k6'})
MERGE (load)-[:HAS_RESOURCE]->(res1);

MATCH (load:Skill {id: 'skill-load-testing'}), (res2:Resource {id: 'res-load-gatling'})
MERGE (load)-[:HAS_RESOURCE]->(res2);

// Runbook Automation Resources
MERGE (runbook_ansible:Resource {id: 'res-runbook-ansible'})
ON CREATE SET
    runbook_ansible.title = 'Ansible Automation Platform',
    runbook_ansible.type = 'documentation',
    runbook_ansible.url = 'https://www.ansible.com/products/automation-platform',
    runbook_ansible.provider = 'Red Hat',
    runbook_ansible.cost = 0,
    runbook_ansible.rating = 4.5;

MERGE (runbook_rundeck:Resource {id: 'res-runbook-rundeck'})
ON CREATE SET
    runbook_rundeck.title = 'Rundeck Runbook Automation',
    runbook_rundeck.type = 'guide',
    runbook_rundeck.url = 'https://docs.rundeck.com/docs/',
    runbook_rundeck.provider = 'Rundeck',
    runbook_rundeck.cost = 0,
    runbook_rundeck.rating = 4.3;

MATCH (runbook:Skill {id: 'skill-runbook-automation'}), (res1:Resource {id: 'res-runbook-ansible'})
MERGE (runbook)-[:HAS_RESOURCE]->(res1);

MATCH (runbook:Skill {id: 'skill-runbook-automation'}), (res2:Resource {id: 'res-runbook-rundeck'})
MERGE (runbook)-[:HAS_RESOURCE]->(res2);

// Chaos Engineering Resources
MERGE (chaos_book:Resource {id: 'res-chaos-book'})
ON CREATE SET
    chaos_book.title = 'Chaos Engineering: System Resiliency in Practice',
    chaos_book.type = 'book',
    chaos_book.url = 'https://www.oreilly.com/library/view/chaos-engineering/9781492043850/',
    chaos_book.provider = 'OReilly',
    chaos_book.cost = 50,
    chaos_book.rating = 4.6;

MERGE (chaos_litmus:Resource {id: 'res-chaos-litmus'})
ON CREATE SET
    chaos_litmus.title = 'LitmusChaos Documentation',
    chaos_litmus.type = 'documentation',
    chaos_litmus.url = 'https://litmuschaos.io/docs/',
    chaos_litmus.provider = 'CNCF',
    chaos_litmus.cost = 0,
    chaos_litmus.rating = 4.4;

MATCH (chaos:Skill {id: 'skill-chaos-engineering'}), (res1:Resource {id: 'res-chaos-book'})
MERGE (chaos)-[:HAS_RESOURCE]->(res1);

MATCH (chaos:Skill {id: 'skill-chaos-engineering'}), (res2:Resource {id: 'res-chaos-litmus'})
MERGE (chaos)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 2: DATA ENGINEERING RESOURCES
// ====================================================================================================

// Apache Spark Resources
MERGE (spark_definitive:Resource {id: 'res-spark-definitive'})
ON CREATE SET
    spark_definitive.title = 'Spark: The Definitive Guide',
    spark_definitive.type = 'book',
    spark_definitive.url = 'https://www.oreilly.com/library/view/spark-the-definitive/9781491912201/',
    spark_definitive.provider = 'OReilly',
    spark_definitive.cost = 60,
    spark_definitive.rating = 4.6;

MERGE (spark_databricks:Resource {id: 'res-spark-databricks'})
ON CREATE SET
    spark_databricks.title = 'Databricks Academy - Apache Spark',
    spark_databricks.type = 'course',
    spark_databricks.url = 'https://www.databricks.com/learn/training/catalog',
    spark_databricks.provider = 'Databricks',
    spark_databricks.cost = 0,
    spark_databricks.rating = 4.7;

MATCH (spark:Skill {id: 'skill-spark'}), (res1:Resource {id: 'res-spark-definitive'})
MERGE (spark)-[:HAS_RESOURCE]->(res1);

MATCH (spark:Skill {id: 'skill-spark'}), (res2:Resource {id: 'res-spark-databricks'})
MERGE (spark)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 3: SECURITY RESOURCES
// ====================================================================================================

// Cloud Security Fundamentals Resources
MERGE (cloudsec_aws:Resource {id: 'res-cloudsec-aws'})
ON CREATE SET
    cloudsec_aws.title = 'AWS Security Best Practices',
    cloudsec_aws.type = 'documentation',
    cloudsec_aws.url = 'https://aws.amazon.com/security/best-practices/',
    cloudsec_aws.provider = 'AWS',
    cloudsec_aws.cost = 0,
    cloudsec_aws.rating = 4.5;

MERGE (cloudsec_sans:Resource {id: 'res-cloudsec-sans'})
ON CREATE SET
    cloudsec_sans.title = 'SANS Cloud Security Essentials',
    cloudsec_sans.type = 'course',
    cloudsec_sans.url = 'https://www.sans.org/cyber-security-courses/cloud-security-essentials/',
    cloudsec_sans.provider = 'SANS',
    cloudsec_sans.cost = 495,
    cloudsec_sans.rating = 4.8;

MATCH (cloudsec:Skill {id: 'skill-cloud-security-fundamentals'}), (res1:Resource {id: 'res-cloudsec-aws'})
MERGE (cloudsec)-[:HAS_RESOURCE]->(res1);

MATCH (cloudsec:Skill {id: 'skill-cloud-security-fundamentals'}), (res2:Resource {id: 'res-cloudsec-sans'})
MERGE (cloudsec)-[:HAS_RESOURCE]->(res2);

// DevSecOps Resources
MERGE (devsecops_owasp:Resource {id: 'res-devsecops-owasp'})
ON CREATE SET
    devsecops_owasp.title = 'OWASP DevSecOps Guideline',
    devsecops_owasp.type = 'guide',
    devsecops_owasp.url = 'https://owasp.org/www-project-devsecops-guideline/',
    devsecops_owasp.provider = 'OWASP',
    devsecops_owasp.cost = 0,
    devsecops_owasp.rating = 4.6;

MERGE (devsecops_gitlab:Resource {id: 'res-devsecops-gitlab'})
ON CREATE SET
    devsecops_gitlab.title = 'GitLab DevSecOps Platform',
    devsecops_gitlab.type = 'documentation',
    devsecops_gitlab.url = 'https://about.gitlab.com/solutions/dev-sec-ops/',
    devsecops_gitlab.provider = 'GitLab',
    devsecops_gitlab.cost = 0,
    devsecops_gitlab.rating = 4.5;

MATCH (devsecops:Skill {id: 'skill-devsecops'}), (res1:Resource {id: 'res-devsecops-owasp'})
MERGE (devsecops)-[:HAS_RESOURCE]->(res1);

MATCH (devsecops:Skill {id: 'skill-devsecops'}), (res2:Resource {id: 'res-devsecops-gitlab'})
MERGE (devsecops)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 4: PROGRAMMING LANGUAGE RESOURCES
// ====================================================================================================

// Node.js / Express Resources
MERGE (nodejs_docs:Resource {id: 'res-nodejs-docs'})
ON CREATE SET
    nodejs_docs.title = 'Node.js Official Documentation',
    nodejs_docs.type = 'documentation',
    nodejs_docs.url = 'https://nodejs.org/en/docs/',
    nodejs_docs.provider = 'Node.js Foundation',
    nodejs_docs.cost = 0,
    nodejs_docs.rating = 4.5;

MERGE (express_mdn:Resource {id: 'res-express-mdn'})
ON CREATE SET
    express_mdn.title = 'Express/Node Tutorial - MDN',
    express_mdn.type = 'tutorial',
    express_mdn.url = 'https://developer.mozilla.org/en-US/docs/Learn/Server-side/Express_Nodejs',
    express_mdn.provider = 'Mozilla',
    express_mdn.cost = 0,
    express_mdn.rating = 4.7;

MATCH (nodejs:Skill {id: 'skill-nodejs'}), (res1:Resource {id: 'res-nodejs-docs'})
MERGE (nodejs)-[:HAS_RESOURCE]->(res1);

MATCH (nodejs:Skill {id: 'skill-nodejs'}), (res2:Resource {id: 'res-express-mdn'})
MERGE (nodejs)-[:HAS_RESOURCE]->(res2);

// Go (Golang) Resources
MERGE (go_tour:Resource {id: 'res-go-tour'})
ON CREATE SET
    go_tour.title = 'A Tour of Go',
    go_tour.type = 'tutorial',
    go_tour.url = 'https://go.dev/tour/',
    go_tour.provider = 'Go Team',
    go_tour.cost = 0,
    go_tour.rating = 4.8;

MERGE (go_by_example:Resource {id: 'res-go-by-example'})
ON CREATE SET
    go_by_example.title = 'Go by Example',
    go_by_example.type = 'tutorial',
    go_by_example.url = 'https://gobyexample.com/',
    go_by_example.provider = 'Mark McGranaghan',
    go_by_example.cost = 0,
    go_by_example.rating = 4.7;

MATCH (golang:Skill {id: 'skill-golang'}), (res1:Resource {id: 'res-go-tour'})
MERGE (golang)-[:HAS_RESOURCE]->(res1);

MATCH (golang:Skill {id: 'skill-golang'}), (res2:Resource {id: 'res-go-by-example'})
MERGE (golang)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 5: CLOUD & DEVOPS RESOURCES
// ====================================================================================================

// GCP Fundamentals Resources
MERGE (gcp_quicklabs:Resource {id: 'res-gcp-quicklabs'})
ON CREATE SET
    gcp_quicklabs.title = 'Google Cloud Skills Boost',
    gcp_quicklabs.type = 'platform',
    gcp_quicklabs.url = 'https://www.cloudskillsboost.google/',
    gcp_quicklabs.provider = 'Google',
    gcp_quicklabs.cost = 0,
    gcp_quicklabs.rating = 4.6;

MERGE (gcp_coursera:Resource {id: 'res-gcp-coursera'})
ON CREATE SET
    gcp_coursera.title = 'Google Cloud Fundamentals',
    gcp_coursera.type = 'course',
    gcp_coursera.url = 'https://www.coursera.org/learn/gcp-fundamentals',
    gcp_coursera.provider = 'Coursera',
    gcp_coursera.cost = 49,
    gcp_coursera.rating = 4.5;

MATCH (gcp:Skill {id: 'skill-gcp-fundamentals'}), (res1:Resource {id: 'res-gcp-quicklabs'})
MERGE (gcp)-[:HAS_RESOURCE]->(res1);

MATCH (gcp:Skill {id: 'skill-gcp-fundamentals'}), (res2:Resource {id: 'res-gcp-coursera'})
MERGE (gcp)-[:HAS_RESOURCE]->(res2);

// ArgoCD/Flux Resources
MERGE (argo_docs:Resource {id: 'res-argo-docs'})
ON CREATE SET
    argo_docs.title = 'Argo CD Documentation',
    argo_docs.type = 'documentation',
    argo_docs.url = 'https://argo-cd.readthedocs.io/',
    argo_docs.provider = 'Argo Project',
    argo_docs.cost = 0,
    argo_docs.rating = 4.5;

MERGE (flux_docs:Resource {id: 'res-flux-docs'})
ON CREATE SET
    flux_docs.title = 'Flux Documentation',
    flux_docs.type = 'documentation',
    flux_docs.url = 'https://fluxcd.io/flux/',
    flux_docs.provider = 'CNCF',
    flux_docs.cost = 0,
    flux_docs.rating = 4.4;

MATCH (argo:Skill {id: 'skill-argocd'}), (res1:Resource {id: 'res-argo-docs'})
MERGE (argo)-[:HAS_RESOURCE]->(res1);

MATCH (argo:Skill {id: 'skill-argocd'}), (res2:Resource {id: 'res-flux-docs'})
MERGE (argo)-[:HAS_RESOURCE]->(res2);

// Ansible Resources
MERGE (ansible_docs:Resource {id: 'res-ansible-docs'})
ON CREATE SET
    ansible_docs.title = 'Ansible Documentation',
    ansible_docs.type = 'documentation',
    ansible_docs.url = 'https://docs.ansible.com/',
    ansible_docs.provider = 'Red Hat',
    ansible_docs.cost = 0,
    ansible_docs.rating = 4.6;

MERGE (ansible_jeff:Resource {id: 'res-ansible-jeff'})
ON CREATE SET
    ansible_jeff.title = 'Ansible for DevOps',
    ansible_jeff.type = 'book',
    ansible_jeff.url = 'https://www.ansiblefordevops.com/',
    ansible_jeff.provider = 'Jeff Geerling',
    ansible_jeff.cost = 20,
    ansible_jeff.rating = 4.8;

MATCH (ansible:Skill {id: 'skill-ansible'}), (res1:Resource {id: 'res-ansible-docs'})
MERGE (ansible)-[:HAS_RESOURCE]->(res1);

MATCH (ansible:Skill {id: 'skill-ansible'}), (res2:Resource {id: 'res-ansible-jeff'})
MERGE (ansible)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 6: MLOPS RESOURCES
// ====================================================================================================

// MLflow Resources
MERGE (mlflow_docs:Resource {id: 'res-mlflow-docs'})
ON CREATE SET
    mlflow_docs.title = 'MLflow Documentation',
    mlflow_docs.type = 'documentation',
    mlflow_docs.url = 'https://mlflow.org/docs/latest/index.html',
    mlflow_docs.provider = 'MLflow',
    mlflow_docs.cost = 0,
    mlflow_docs.rating = 4.5;

MERGE (mlflow_course:Resource {id: 'res-mlflow-course'})
ON CREATE SET
    mlflow_course.title = 'MLflow in Practice',
    mlflow_course.type = 'course',
    mlflow_course.url = 'https://www.udemy.com/course/mlflow-in-practice/',
    mlflow_course.provider = 'Udemy',
    mlflow_course.cost = 19,
    mlflow_course.rating = 4.4;

MATCH (mlflow:Skill {id: 'skill-mlflow'}), (res1:Resource {id: 'res-mlflow-docs'})
MERGE (mlflow)-[:HAS_RESOURCE]->(res1);

MATCH (mlflow:Skill {id: 'skill-mlflow'}), (res2:Resource {id: 'res-mlflow-course'})
MERGE (mlflow)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 7: VERIFICATION QUERY
// ====================================================================================================

// Run this to verify all resources were added
MATCH (s:Skill)
WHERE s.id IN [
    'skill-slos', 'skill-spark', 'skill-cloud-security-fundamentals', 'skill-devsecops',
    'skill-nodejs', 'skill-golang', 'skill-gcp-fundamentals', 'skill-argocd',
    'skill-mlflow', 'skill-elk', 'skill-load-testing', 'skill-runbook-automation',
    'skill-ansible', 'skill-chaos-engineering'
]
OPTIONAL MATCH (s)-[:HAS_RESOURCE]->(res:Resource)
WITH s, COUNT(DISTINCT res) AS resourceCount
RETURN 
    s.name AS Skill,
    resourceCount AS Resources,
    CASE 
        WHEN resourceCount > 0 
        THEN '✅ Has resources' 
        ELSE '❌ Still needs resources' 
    END AS Status
ORDER BY s.name;

// ====================================================================================================
// END OF RESOURCE ADDITIONS
// ====================================================================================================

// ====================================================================================================
// APPEND SCRIPT - FINAL BATCH OF RESOURCES FOR REMAINING SKILLS
// Run this AFTER all previous scripts to add resources for the last 17 skills
// This script is idempotent - safe to run multiple times
// ====================================================================================================

// ====================================================================================================
// SECTION 1: DATA & ANALYTICS RESOURCES
// ====================================================================================================

// Snowflake Resources
MERGE (snowflake_docs:Resource {id: 'res-snowflake-docs'})
ON CREATE SET
    snowflake_docs.title = 'Snowflake Documentation',
    snowflake_docs.type = 'documentation',
    snowflake_docs.url = 'https://docs.snowflake.com/',
    snowflake_docs.provider = 'Snowflake',
    snowflake_docs.cost = 0,
    snowflake_docs.rating = 4.6;

MERGE (snowflake_course:Resource {id: 'res-snowflake-course'})
ON CREATE SET
    snowflake_course.title = 'Snowflake: The Complete Masterclass',
    snowflake_course.type = 'course',
    snowflake_course.url = 'https://www.udemy.com/course/snowflake-masterclass/',
    snowflake_course.provider = 'Udemy',
    snowflake_course.cost = 24,
    snowflake_course.rating = 4.7;

MATCH (snowflake:Skill {id: 'skill-snowflake'}), (res1:Resource {id: 'res-snowflake-docs'})
MERGE (snowflake)-[:HAS_RESOURCE]->(res1);

MATCH (snowflake:Skill {id: 'skill-snowflake'}), (res2:Resource {id: 'res-snowflake-course'})
MERGE (snowflake)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 2: FRONTEND DEVELOPMENT RESOURCES
// ====================================================================================================

// TypeScript Resources
MERGE (ts_handbook:Resource {id: 'res-ts-handbook'})
ON CREATE SET
    ts_handbook.title = 'TypeScript Handbook',
    ts_handbook.type = 'documentation',
    ts_handbook.url = 'https://www.typescriptlang.org/docs/handbook/',
    ts_handbook.provider = 'Microsoft',
    ts_handbook.cost = 0,
    ts_handbook.rating = 4.8;

MERGE (ts_deep_dive:Resource {id: 'res-ts-deep-dive'})
ON CREATE SET
    ts_deep_dive.title = 'TypeScript Deep Dive',
    ts_deep_dive.type = 'book',
    ts_deep_dive.url = 'https://basarat.gitbook.io/typescript/',
    ts_deep_dive.provider = 'Basarat Ali Syed',
    ts_deep_dive.cost = 0,
    ts_deep_dive.rating = 4.7;

MATCH (ts:Skill {id: 'skill-typescript'}), (res1:Resource {id: 'res-ts-handbook'})
MERGE (ts)-[:HAS_RESOURCE]->(res1);

MATCH (ts:Skill {id: 'skill-typescript'}), (res2:Resource {id: 'res-ts-deep-dive'})
MERGE (ts)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 3: BACKEND DEVELOPMENT RESOURCES
// ====================================================================================================

// Java / Spring Boot Resources
MERGE (spring_guides:Resource {id: 'res-spring-guides'})
ON CREATE SET
    spring_guides.title = 'Spring Boot Guides',
    spring_guides.type = 'documentation',
    spring_guides.url = 'https://spring.io/guides',
    spring_guides.provider = 'Spring',
    spring_guides.cost = 0,
    spring_guides.rating = 4.7;

MERGE (spring_in_action:Resource {id: 'res-spring-in-action'})
ON CREATE SET
    spring_in_action.title = 'Spring Boot in Action',
    spring_in_action.type = 'book',
    spring_in_action.url = 'https://www.manning.com/books/spring-boot-in-action',
    spring_in_action.provider = 'Manning',
    spring_in_action.cost = 45,
    spring_in_action.rating = 4.5;

MATCH (java:Skill {id: 'skill-java-spring'}), (res1:Resource {id: 'res-spring-guides'})
MERGE (java)-[:HAS_RESOURCE]->(res1);

MATCH (java:Skill {id: 'skill-java-spring'}), (res2:Resource {id: 'res-spring-in-action'})
MERGE (java)-[:HAS_RESOURCE]->(res2);

// Microservices Architecture Resources
MERGE (microservices_patterns:Resource {id: 'res-microservices-patterns'})
ON CREATE SET
    microservices_patterns.title = 'Microservices Patterns',
    microservices_patterns.type = 'book',
    microservices_patterns.url = 'https://microservices.io/book',
    microservices_patterns.provider = 'Manning',
    microservices_patterns.cost = 50,
    microservices_patterns.rating = 4.8;

MERGE (microservices_fowler:Resource {id: 'res-microservices-fowler'})
ON CREATE SET
    microservices_fowler.title = 'Microservices Guide by Martin Fowler',
    microservices_fowler.type = 'guide',
    microservices_fowler.url = 'https://martinfowler.com/microservices/',
    microservices_fowler.provider = 'Martin Fowler',
    microservices_fowler.cost = 0,
    microservices_fowler.rating = 4.9;

MATCH (micro:Skill {id: 'skill-microservices'}), (res1:Resource {id: 'res-microservices-patterns'})
MERGE (micro)-[:HAS_RESOURCE]->(res1);

MATCH (micro:Skill {id: 'skill-microservices'}), (res2:Resource {id: 'res-microservices-fowler'})
MERGE (micro)-[:HAS_RESOURCE]->(res2);

// API Design Resources
MERGE (api_rest_cookbook:Resource {id: 'res-api-rest-cookbook'})
ON CREATE SET
    api_rest_cookbook.title = 'RESTful Web API Design Cookbook',
    api_rest_cookbook.type = 'book',
    api_rest_cookbook.url = 'https://restfulapi.net/',
    api_rest_cookbook.provider = 'RESTful API',
    api_rest_cookbook.cost = 0,
    api_rest_cookbook.rating = 4.6;

MERGE (graphql_docs:Resource {id: 'res-graphql-docs'})
ON CREATE SET
    graphql_docs.title = 'GraphQL Official Documentation',
    graphql_docs.type = 'documentation',
    graphql_docs.url = 'https://graphql.org/learn/',
    graphql_docs.provider = 'GraphQL Foundation',
    graphql_docs.cost = 0,
    graphql_docs.rating = 4.7;

MATCH (api:Skill {id: 'skill-api-design'}), (res1:Resource {id: 'res-api-rest-cookbook'})
MERGE (api)-[:HAS_RESOURCE]->(res1);

MATCH (api:Skill {id: 'skill-api-design'}), (res2:Resource {id: 'res-graphql-docs'})
MERGE (api)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 4: TESTING RESOURCES
// ====================================================================================================

// Unit Testing Resources
MERGE (unit_test_art:Resource {id: 'res-unit-test-art'})
ON CREATE SET
    unit_test_art.title = 'The Art of Unit Testing',
    unit_test_art.type = 'book',
    unit_test_art.url = 'https://www.manning.com/books/the-art-of-unit-testing-third-edition',
    unit_test_art.provider = 'Manning',
    unit_test_art.cost = 45,
    unit_test_art.rating = 4.7;

MERGE (jest_docs:Resource {id: 'res-jest-docs'})
ON CREATE SET
    jest_docs.title = 'Jest Testing Framework Documentation',
    jest_docs.type = 'documentation',
    jest_docs.url = 'https://jestjs.io/docs/getting-started',
    jest_docs.provider = 'Meta',
    jest_docs.cost = 0,
    jest_docs.rating = 4.6;

MATCH (unit:Skill {id: 'skill-unit-testing'}), (res1:Resource {id: 'res-unit-test-art'})
MERGE (unit)-[:HAS_RESOURCE]->(res1);

MATCH (unit:Skill {id: 'skill-unit-testing'}), (res2:Resource {id: 'res-jest-docs'})
MERGE (unit)-[:HAS_RESOURCE]->(res2);

// E2E Testing Resources
MERGE (cypress_docs:Resource {id: 'res-cypress-docs'})
ON CREATE SET
    cypress_docs.title = 'Cypress Documentation',
    cypress_docs.type = 'documentation',
    cypress_docs.url = 'https://docs.cypress.io/',
    cypress_docs.provider = 'Cypress',
    cypress_docs.cost = 0,
    cypress_docs.rating = 4.8;

MERGE (playwright_docs:Resource {id: 'res-playwright-docs'})
ON CREATE SET
    playwright_docs.title = 'Playwright Documentation',
    playwright_docs.type = 'documentation',
    playwright_docs.url = 'https://playwright.dev/docs/intro',
    playwright_docs.provider = 'Microsoft',
    playwright_docs.cost = 0,
    playwright_docs.rating = 4.7;

MATCH (e2e:Skill {id: 'skill-e2e-testing'}), (res1:Resource {id: 'res-cypress-docs'})
MERGE (e2e)-[:HAS_RESOURCE]->(res1);

MATCH (e2e:Skill {id: 'skill-e2e-testing'}), (res2:Resource {id: 'res-playwright-docs'})
MERGE (e2e)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 5: INFRASTRUCTURE & CLOUD RESOURCES
// ====================================================================================================

// Linux/Shell Scripting Resources
MERGE (linux_command_line:Resource {id: 'res-linux-command-line'})
ON CREATE SET
    linux_command_line.title = 'The Linux Command Line',
    linux_command_line.type = 'book',
    linux_command_line.url = 'https://linuxcommand.org/tlcl.php',
    linux_command_line.provider = 'William Shotts',
    linux_command_line.cost = 0,
    linux_command_line.rating = 4.8;

MERGE (bash_guide:Resource {id: 'res-bash-guide'})
ON CREATE SET
    bash_guide.title = 'Advanced Bash-Scripting Guide',
    bash_guide.type = 'guide',
    bash_guide.url = 'https://tldp.org/LDP/abs/html/',
    bash_guide.provider = 'TLDP',
    bash_guide.cost = 0,
    bash_guide.rating = 4.6;

MATCH (linux:Skill {id: 'skill-linux'}), (res1:Resource {id: 'res-linux-command-line'})
MERGE (linux)-[:HAS_RESOURCE]->(res1);

MATCH (linux:Skill {id: 'skill-linux'}), (res2:Resource {id: 'res-bash-guide'})
MERGE (linux)-[:HAS_RESOURCE]->(res2);

// Azure Fundamentals Resources
MERGE (azure_learn_path:Resource {id: 'res-azure-learn-path'})
ON CREATE SET
    azure_learn_path.title = 'Azure Fundamentals Learning Path',
    azure_learn_path.type = 'course',
    azure_learn_path.url = 'https://learn.microsoft.com/en-us/training/paths/azure-fundamentals/',
    azure_learn_path.provider = 'Microsoft Learn',
    azure_learn_path.cost = 0,
    azure_learn_path.rating = 4.7;

MERGE (azure_az900_guide:Resource {id: 'res-azure-az900-guide'})
ON CREATE SET
    azure_az900_guide.title = 'AZ-900 Exam Study Guide',
    azure_az900_guide.type = 'guide',
    azure_az900_guide.url = 'https://learn.microsoft.com/en-us/certifications/exams/az-900',
    azure_az900_guide.provider = 'Microsoft',
    azure_az900_guide.cost = 0,
    azure_az900_guide.rating = 4.5;

MATCH (azure:Skill {id: 'skill-azure-fundamentals'}), (res1:Resource {id: 'res-azure-learn-path'})
MERGE (azure)-[:HAS_RESOURCE]->(res1);

MATCH (azure:Skill {id: 'skill-azure-fundamentals'}), (res2:Resource {id: 'res-azure-az900-guide'})
MERGE (azure)-[:HAS_RESOURCE]->(res2);

// CI/CD Pipeline Design Resources
MERGE (cicd_dummies:Resource {id: 'res-cicd-dummies'})
ON CREATE SET
    cicd_dummies.title = 'Continuous Delivery & DevOps For Dummies',
    cicd_dummies.type = 'book',
    cicd_dummies.url = 'https://www.ibm.com/downloads/cas/7PNZONVJ',
    cicd_dummies.provider = 'IBM',
    cicd_dummies.cost = 0,
    cicd_dummies.rating = 4.4;

MERGE (jenkins_docs:Resource {id: 'res-jenkins-docs'})
ON CREATE SET
    jenkins_docs.title = 'Jenkins Pipeline Documentation',
    jenkins_docs.type = 'documentation',
    jenkins_docs.url = 'https://www.jenkins.io/doc/book/pipeline/',
    jenkins_docs.provider = 'Jenkins',
    jenkins_docs.cost = 0,
    jenkins_docs.rating = 4.5;

MATCH (cicd:Skill {id: 'skill-cicd-pipelines'}), (res1:Resource {id: 'res-cicd-dummies'})
MERGE (cicd)-[:HAS_RESOURCE]->(res1);

MATCH (cicd:Skill {id: 'skill-cicd-pipelines'}), (res2:Resource {id: 'res-jenkins-docs'})
MERGE (cicd)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 6: AI/ML FRAMEWORK RESOURCES
// ====================================================================================================

// PyTorch Resources
MERGE (pytorch_tutorials:Resource {id: 'res-pytorch-tutorials'})
ON CREATE SET
    pytorch_tutorials.title = 'PyTorch Tutorials',
    pytorch_tutorials.type = 'tutorial',
    pytorch_tutorials.url = 'https://pytorch.org/tutorials/',
    pytorch_tutorials.provider = 'PyTorch',
    pytorch_tutorials.cost = 0,
    pytorch_tutorials.rating = 4.8;

MERGE (pytorch_lightning:Resource {id: 'res-pytorch-lightning'})
ON CREATE SET
    pytorch_lightning.title = 'Deep Learning with PyTorch Lightning',
    pytorch_lightning.type = 'book',
    pytorch_lightning.url = 'https://www.manning.com/books/deep-learning-with-pytorch-lightning',
    pytorch_lightning.provider = 'Manning',
    pytorch_lightning.cost = 45,
    pytorch_lightning.rating = 4.6;

MATCH (pytorch:Skill {id: 'skill-pytorch'}), (res1:Resource {id: 'res-pytorch-tutorials'})
MERGE (pytorch)-[:HAS_RESOURCE]->(res1);

MATCH (pytorch:Skill {id: 'skill-pytorch'}), (res2:Resource {id: 'res-pytorch-lightning'})
MERGE (pytorch)-[:HAS_RESOURCE]->(res2);

// Vector Databases Resources
MERGE (pinecone_learning:Resource {id: 'res-pinecone-learning'})
ON CREATE SET
    pinecone_learning.title = 'Pinecone Learning Center',
    pinecone_learning.type = 'documentation',
    pinecone_learning.url = 'https://www.pinecone.io/learn/',
    pinecone_learning.provider = 'Pinecone',
    pinecone_learning.cost = 0,
    pinecone_learning.rating = 4.6;

MERGE (weaviate_docs:Resource {id: 'res-weaviate-docs'})
ON CREATE SET
    weaviate_docs.title = 'Weaviate Vector Database Documentation',
    weaviate_docs.type = 'documentation',
    weaviate_docs.url = 'https://weaviate.io/developers/weaviate',
    weaviate_docs.provider = 'Weaviate',
    weaviate_docs.cost = 0,
    weaviate_docs.rating = 4.5;

MATCH (vdb:Skill {id: 'skill-vector-db'}), (res1:Resource {id: 'res-pinecone-learning'})
MERGE (vdb)-[:HAS_RESOURCE]->(res1);

MATCH (vdb:Skill {id: 'skill-vector-db'}), (res2:Resource {id: 'res-weaviate-docs'})
MERGE (vdb)-[:HAS_RESOURCE]->(res2);

// LangChain/LlamaIndex Resources
MERGE (langchain_cookbook:Resource {id: 'res-langchain-cookbook'})
ON CREATE SET
    langchain_cookbook.title = 'LangChain Cookbook',
    langchain_cookbook.type = 'guide',
    langchain_cookbook.url = 'https://github.com/langchain-ai/langchain/tree/master/cookbook',
    langchain_cookbook.provider = 'LangChain',
    langchain_cookbook.cost = 0,
    langchain_cookbook.rating = 4.7;

MERGE (llamaindex_docs:Resource {id: 'res-llamaindex-docs'})
ON CREATE SET
    llamaindex_docs.title = 'LlamaIndex Documentation',
    llamaindex_docs.type = 'documentation',
    llamaindex_docs.url = 'https://docs.llamaindex.ai/',
    llamaindex_docs.provider = 'LlamaIndex',
    llamaindex_docs.cost = 0,
    llamaindex_docs.rating = 4.6;

MATCH (langchain:Skill {id: 'skill-langchain'}), (res1:Resource {id: 'res-langchain-cookbook'})
MERGE (langchain)-[:HAS_RESOURCE]->(res1);

MATCH (langchain:Skill {id: 'skill-langchain'}), (res2:Resource {id: 'res-llamaindex-docs'})
MERGE (langchain)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 7: OBSERVABILITY & MONITORING RESOURCES
// ====================================================================================================

// Prometheus & Grafana Resources
MERGE (prometheus_book:Resource {id: 'res-prometheus-book'})
ON CREATE SET
    prometheus_book.title = 'Prometheus: Up & Running',
    prometheus_book.type = 'book',
    prometheus_book.url = 'https://www.oreilly.com/library/view/prometheus-up/9781492034131/',
    prometheus_book.provider = 'OReilly',
    prometheus_book.cost = 45,
    prometheus_book.rating = 4.7;

MERGE (grafana_tutorials:Resource {id: 'res-grafana-tutorials'})
ON CREATE SET
    grafana_tutorials.title = 'Grafana Tutorials',
    grafana_tutorials.type = 'tutorial',
    grafana_tutorials.url = 'https://grafana.com/tutorials/',
    grafana_tutorials.provider = 'Grafana Labs',
    grafana_tutorials.cost = 0,
    grafana_tutorials.rating = 4.6;

MATCH (prom:Skill {id: 'skill-prometheus'}), (res1:Resource {id: 'res-prometheus-book'})
MERGE (prom)-[:HAS_RESOURCE]->(res1);

MATCH (prom:Skill {id: 'skill-prometheus'}), (res2:Resource {id: 'res-grafana-tutorials'})
MERGE (prom)-[:HAS_RESOURCE]->(res2);

// Datadog/New Relic Resources
MERGE (datadog_learning:Resource {id: 'res-datadog-learning'})
ON CREATE SET
    datadog_learning.title = 'Datadog Learning Center',
    datadog_learning.type = 'platform',
    datadog_learning.url = 'https://learn.datadoghq.com/',
    datadog_learning.provider = 'Datadog',
    datadog_learning.cost = 0,
    datadog_learning.rating = 4.5;

MERGE (newrelic_university:Resource {id: 'res-newrelic-university'})
ON CREATE SET
    newrelic_university.title = 'New Relic University',
    newrelic_university.type = 'platform',
    newrelic_university.url = 'https://learn.newrelic.com/',
    newrelic_university.provider = 'New Relic',
    newrelic_university.cost = 0,
    newrelic_university.rating = 4.4;

MATCH (datadog:Skill {id: 'skill-datadog'}), (res1:Resource {id: 'res-datadog-learning'})
MERGE (datadog)-[:HAS_RESOURCE]->(res1);

MATCH (datadog:Skill {id: 'skill-datadog'}), (res2:Resource {id: 'res-newrelic-university'})
MERGE (datadog)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// SECTION 8: RESOURCE COUNT VERIFICATION
// ====================================================================================================

// Verification query to ensure all skills now have resources
MATCH (s:Skill)
WHERE s.id IN [
    'skill-snowflake', 'skill-typescript', 'skill-java-spring', 'skill-microservices',
    'skill-api-design', 'skill-unit-testing', 'skill-e2e-testing', 'skill-linux',
    'skill-azure-fundamentals', 'skill-cicd-pipelines', 'skill-pytorch', 'skill-vector-db',
    'skill-langchain', 'skill-prometheus', 'skill-datadog', 'skill-incident-response',
    'skill-airflow'
]
OPTIONAL MATCH (s)-[:HAS_RESOURCE]->(res:Resource)
WITH s, COUNT(DISTINCT res) AS resourceCount, COLLECT(res.title) AS resourceTitles
RETURN 
    s.name AS Skill,
    resourceCount AS ResourceCount,
    CASE 
        WHEN resourceCount >= 2 THEN '✅ Complete'
        WHEN resourceCount = 1 THEN '⚠️ Has 1 resource'
        ELSE '❌ No resources'
    END AS Status,
    resourceTitles AS Resources
ORDER BY resourceCount DESC, s.name;

// ====================================================================================================
// END OF FINAL RESOURCE ADDITIONS
// ====================================================================================================

// ====================================================================================================
// APPEND SCRIPT - RESOURCES FOR INCIDENT RESPONSE AND APACHE AIRFLOW
// Run this AFTER all previous scripts to add resources for the last 2 skills
// This script is idempotent - safe to run multiple times
// ====================================================================================================

// ====================================================================================================
// SECTION 1: INCIDENT RESPONSE & MANAGEMENT RESOURCES
// ====================================================================================================

// Incident Response & Management Resources
MERGE (incident_google_sre:Resource {id: 'res-incident-google-sre'})
ON CREATE SET
    incident_google_sre.title = 'Google SRE Book - Managing Incidents',
    incident_google_sre.type = 'book',
    incident_google_sre.url = 'https://sre.google/sre-book/managing-incidents/',
    incident_google_sre.provider = 'Google',
    incident_google_sre.cost = 0,
    incident_google_sre.rating = 4.8;

MERGE (incident_pagerduty:Resource {id: 'res-incident-pagerduty'})
ON CREATE SET
    incident_pagerduty.title = 'PagerDuty Incident Response Documentation',
    incident_pagerduty.type = 'documentation',
    incident_pagerduty.url = 'https://response.pagerduty.com/',
    incident_pagerduty.provider = 'PagerDuty',
    incident_pagerduty.cost = 0,
    incident_pagerduty.rating = 4.6;

MERGE (incident_atlassian:Resource {id: 'res-incident-atlassian'})
ON CREATE SET
    incident_atlassian.title = 'Atlassian Incident Management Handbook',
    incident_atlassian.type = 'guide',
    incident_atlassian.url = 'https://www.atlassian.com/incident-management/handbook',
    incident_atlassian.provider = 'Atlassian',
    incident_atlassian.cost = 0,
    incident_atlassian.rating = 4.5;

// Create relationships
MATCH (incident:Skill {id: 'skill-incident-response'}), (res1:Resource {id: 'res-incident-google-sre'})
MERGE (incident)-[:HAS_RESOURCE]->(res1);

MATCH (incident:Skill {id: 'skill-incident-response'}), (res2:Resource {id: 'res-incident-pagerduty'})
MERGE (incident)-[:HAS_RESOURCE]->(res2);

MATCH (incident:Skill {id: 'skill-incident-response'}), (res3:Resource {id: 'res-incident-atlassian'})
MERGE (incident)-[:HAS_RESOURCE]->(res3);

// ====================================================================================================
// SECTION 2: APACHE AIRFLOW RESOURCES
// ====================================================================================================

// Apache Airflow Resources
MERGE (airflow_docs:Resource {id: 'res-airflow-docs'})
ON CREATE SET
    airflow_docs.title = 'Apache Airflow Documentation',
    airflow_docs.type = 'documentation',
    airflow_docs.url = 'https://airflow.apache.org/docs/',
    airflow_docs.provider = 'Apache',
    airflow_docs.cost = 0,
    airflow_docs.rating = 4.7;

MERGE (airflow_astronomer:Resource {id: 'res-airflow-astronomer'})
ON CREATE SET
    airflow_astronomer.title = 'Astronomer Academy - Airflow Fundamentals',
    airflow_astronomer.type = 'course',
    airflow_astronomer.url = 'https://academy.astronomer.io/airflow-fundamentals',
    airflow_astronomer.provider = 'Astronomer',
    airflow_astronomer.cost = 0,
    airflow_astronomer.rating = 4.8;

MERGE (airflow_book:Resource {id: 'res-airflow-book'})
ON CREATE SET
    airflow_book.title = 'Data Pipelines with Apache Airflow',
    airflow_book.type = 'book',
    airflow_book.url = 'https://www.manning.com/books/data-pipelines-with-apache-airflow',
    airflow_book.provider = 'Manning',
    airflow_book.cost = 45,
    airflow_book.rating = 4.6;

// Create relationships
MATCH (airflow:Skill {id: 'skill-airflow'}), (res1:Resource {id: 'res-airflow-docs'})
MERGE (airflow)-[:HAS_RESOURCE]->(res1);

MATCH (airflow:Skill {id: 'skill-airflow'}), (res2:Resource {id: 'res-airflow-astronomer'})
MERGE (airflow)-[:HAS_RESOURCE]->(res2);

MATCH (airflow:Skill {id: 'skill-airflow'}), (res3:Resource {id: 'res-airflow-book'})
MERGE (airflow)-[:HAS_RESOURCE]->(res3);

// ====================================================================================================
// SECTION 3: FINAL VERIFICATION
// ====================================================================================================

// Verify these two skills now have resources
MATCH (s:Skill)
WHERE s.id IN ['skill-incident-response', 'skill-airflow']
OPTIONAL MATCH (s)-[:HAS_RESOURCE]->(res:Resource)
WITH s, COUNT(DISTINCT res) AS resourceCount, COLLECT(res.title) AS resourceTitles
RETURN 
    s.name AS Skill,
    s.id AS SkillId,
    resourceCount AS ResourceCount,
    CASE 
        WHEN resourceCount >= 2 THEN '✅ Complete - Has resources'
        WHEN resourceCount = 1 THEN '⚠️ Has only 1 resource'
        ELSE '❌ Still missing resources'
    END AS Status,
    resourceTitles AS Resources
ORDER BY s.name;

// ====================================================================================================
// COMPREHENSIVE CHECK - ALL SKILLS RESOURCE STATUS
// ====================================================================================================

// Final comprehensive check - show any skills still missing resources
MATCH (s:Skill)
OPTIONAL MATCH (s)-[:HAS_RESOURCE]->(res:Resource)
WITH s, COUNT(DISTINCT res) AS resourceCount
WHERE resourceCount = 0
RETURN 
    s.name AS SkillWithoutResources,
    s.id AS SkillId,
    '❌ No resources' AS Status
ORDER BY s.name;

// Summary statistics
MATCH (s:Skill)
OPTIONAL MATCH (s)-[:HAS_RESOURCE]->(res:Resource)
WITH s, COUNT(DISTINCT res) AS resourceCount
WITH 
    COUNT(s) AS TotalSkills,
    COUNT(CASE WHEN resourceCount > 0 THEN 1 END) AS SkillsWithResources,
    COUNT(CASE WHEN resourceCount = 0 THEN 1 END) AS SkillsWithoutResources,
    COUNT(CASE WHEN resourceCount >= 2 THEN 1 END) AS SkillsWithMultipleResources
RETURN 
    '=== RESOURCE COVERAGE SUMMARY ===' AS Report,
    TotalSkills,
    SkillsWithResources,
    SkillsWithoutResources,
    SkillsWithMultipleResources,
    CASE 
        WHEN SkillsWithoutResources = 0 THEN '✅ ALL SKILLS HAVE RESOURCES!' 
        ELSE '⚠️ Some skills still need resources' 
    END AS Status;

// ====================================================================================================
// END OF INCIDENT RESPONSE AND AIRFLOW RESOURCE ADDITIONS
// ====================================================================================================

// ====================================================================================================
// SKILL PATH NAVIGATOR - COMPREHENSIVE DATA EXPANSION
// Version: 3.0 - Expanding from 51 to 250+ skills
// This script is idempotent and can be appended to your existing seed script
// ====================================================================================================

// ====================================================================================================
// SECTION 1: PROGRAMMING LANGUAGES (EXPANDED)
// ====================================================================================================

// Additional Programming Languages
MERGE (rust:Skill {id: 'skill-rust'})
ON CREATE SET
    rust.name = 'Rust',
    rust.difficulty_level = 'intermediate',
    rust.estimated_hours = 100,
    rust.demand_score = 8,
    rust.category = 'programming',
    rust.prereq_level = 2;

MERGE (kotlin:Skill {id: 'skill-kotlin'})
ON CREATE SET
    kotlin.name = 'Kotlin',
    kotlin.difficulty_level = 'intermediate',
    kotlin.estimated_hours = 60,
    kotlin.demand_score = 7,
    kotlin.category = 'programming',
    kotlin.prereq_level = 2;

MERGE (swift:Skill {id: 'skill-swift'})
ON CREATE SET
    swift.name = 'Swift',
    swift.difficulty_level = 'intermediate',
    swift.estimated_hours = 70,
    swift.demand_score = 7,
    swift.category = 'programming',
    swift.prereq_level = 2;

MERGE (csharp:Skill {id: 'skill-csharp'})
ON CREATE SET
    csharp.name = 'C#',
    csharp.difficulty_level = 'intermediate',
    csharp.estimated_hours = 80,
    csharp.demand_score = 8,
    csharp.category = 'programming',
    csharp.prereq_level = 2;

MERGE (cpp:Skill {id: 'skill-cpp'})
ON CREATE SET
    cpp.name = 'C++',
    cpp.difficulty_level = 'advanced',
    cpp.estimated_hours = 120,
    cpp.demand_score = 7,
    cpp.category = 'programming',
    cpp.prereq_level = 3;

MERGE (r_lang:Skill {id: 'skill-r'})
ON CREATE SET
    r_lang.name = 'R Programming',
    r_lang.difficulty_level = 'intermediate',
    r_lang.estimated_hours = 60,
    r_lang.demand_score = 7,
    r_lang.category = 'programming',
    r_lang.prereq_level = 2;

MERGE (scala:Skill {id: 'skill-scala'})
ON CREATE SET
    scala.name = 'Scala',
    scala.difficulty_level = 'advanced',
    scala.estimated_hours = 90,
    scala.demand_score = 6,
    scala.category = 'programming',
    scala.prereq_level = 3;

MERGE (julia:Skill {id: 'skill-julia'})
ON CREATE SET
    julia.name = 'Julia',
    julia.difficulty_level = 'intermediate',
    julia.estimated_hours = 50,
    julia.demand_score = 5,
    julia.category = 'programming',
    julia.prereq_level = 2;

MERGE (ruby:Skill {id: 'skill-ruby'})
ON CREATE SET
    ruby.name = 'Ruby',
    ruby.difficulty_level = 'beginner',
    ruby.estimated_hours = 60,
    ruby.demand_score = 6,
    ruby.category = 'programming',
    ruby.prereq_level = 1;

MERGE (php:Skill {id: 'skill-php'})
ON CREATE SET
    php.name = 'PHP',
    php.difficulty_level = 'beginner',
    php.estimated_hours = 50,
    php.demand_score = 7,
    php.category = 'programming',
    php.prereq_level = 1;

MERGE (elixir:Skill {id: 'skill-elixir'})
ON CREATE SET
    elixir.name = 'Elixir',
    elixir.difficulty_level = 'intermediate',
    elixir.estimated_hours = 70,
    elixir.demand_score = 5,
    elixir.category = 'programming',
    elixir.prereq_level = 2;

// Connect languages to subdomains
MATCH (fund:SubDomain {id: 'sub-sw-fundamentals'}), (s:Skill)
WHERE s.id IN ['skill-rust', 'skill-kotlin', 'skill-swift', 'skill-csharp', 'skill-cpp', 'skill-ruby', 'skill-php']
MERGE (fund)-[:CONTAINS]->(s);

// Prerequisites for new languages
MATCH (rust:Skill {id: 'skill-rust'}), (cpp:Skill {id: 'skill-cpp'})
MERGE (rust)-[:REQUIRES {priority: 1, type: 'soft'}]->(cpp);

MATCH (kotlin:Skill {id: 'skill-kotlin'}), (java:Skill {id: 'skill-java-spring'})
MERGE (kotlin)-[:REQUIRES {priority: 1, type: 'soft'}]->(java);

MATCH (r:Skill {id: 'skill-r'}), (sql:Skill {id: 'skill-sql'})
MERGE (r)-[:REQUIRES {priority: 1, type: 'soft'}]->(sql);

// ====================================================================================================
// SECTION 2: FRONTEND FRAMEWORKS & TOOLS (EXPANDED)
// ====================================================================================================

MERGE (vue:Skill {id: 'skill-vue'})
ON CREATE SET
    vue.name = 'Vue.js',
    vue.difficulty_level = 'intermediate',
    vue.estimated_hours = 50,
    vue.demand_score = 8,
    vue.category = 'frontend',
    vue.prereq_level = 2;

MERGE (angular:Skill {id: 'skill-angular'})
ON CREATE SET
    angular.name = 'Angular',
    angular.difficulty_level = 'intermediate',
    angular.estimated_hours = 70,
    angular.demand_score = 8,
    angular.category = 'frontend',
    angular.prereq_level = 2;

MERGE (svelte:Skill {id: 'skill-svelte'})
ON CREATE SET
    svelte.name = 'Svelte',
    svelte.difficulty_level = 'intermediate',
    svelte.estimated_hours = 40,
    svelte.demand_score = 7,
    svelte.category = 'frontend',
    svelte.prereq_level = 2;

MERGE (nextjs:Skill {id: 'skill-nextjs'})
ON CREATE SET
    nextjs.name = 'Next.js',
    nextjs.difficulty_level = 'intermediate',
    nextjs.estimated_hours = 50,
    nextjs.demand_score = 9,
    nextjs.category = 'frontend',
    nextjs.prereq_level = 3;

MERGE (nuxtjs:Skill {id: 'skill-nuxtjs'})
ON CREATE SET
    nuxtjs.name = 'Nuxt.js',
    nuxtjs.difficulty_level = 'intermediate',
    nuxtjs.estimated_hours = 45,
    nuxtjs.demand_score = 7,
    nuxtjs.category = 'frontend',
    nuxtjs.prereq_level = 3;

MERGE (redux:Skill {id: 'skill-redux'})
ON CREATE SET
    redux.name = 'Redux',
    redux.difficulty_level = 'intermediate',
    redux.estimated_hours = 30,
    redux.demand_score = 7,
    redux.category = 'frontend',
    redux.prereq_level = 2;

MERGE (webpack:Skill {id: 'skill-webpack'})
ON CREATE SET
    webpack.name = 'Webpack',
    webpack.difficulty_level = 'intermediate',
    webpack.estimated_hours = 25,
    webpack.demand_score = 6,
    webpack.category = 'frontend',
    webpack.prereq_level = 2;

MERGE (vite:Skill {id: 'skill-vite'})
ON CREATE SET
    vite.name = 'Vite',
    vite.difficulty_level = 'beginner',
    vite.estimated_hours = 15,
    vite.demand_score = 7,
    vite.category = 'frontend',
    vite.prereq_level = 2;

MERGE (tailwind:Skill {id: 'skill-tailwind'})
ON CREATE SET
    tailwind.name = 'Tailwind CSS',
    tailwind.difficulty_level = 'beginner',
    tailwind.estimated_hours = 20,
    tailwind.demand_score = 8,
    tailwind.category = 'frontend',
    tailwind.prereq_level = 1;

MERGE (sass:Skill {id: 'skill-sass'})
ON CREATE SET
    sass.name = 'Sass/SCSS',
    sass.difficulty_level = 'beginner',
    sass.estimated_hours = 15,
    sass.demand_score = 6,
    sass.category = 'frontend',
    sass.prereq_level = 1;

// Connect to subdomains
MATCH (frontend:SubDomain {id: 'sub-sw-frontend'}), (s:Skill)
WHERE s.id IN ['skill-vue', 'skill-angular', 'skill-svelte', 'skill-nextjs', 'skill-nuxtjs', 'skill-redux', 'skill-webpack', 'skill-vite', 'skill-tailwind', 'skill-sass']
MERGE (frontend)-[:CONTAINS]->(s);

// Frontend prerequisites
MATCH (vue:Skill {id: 'skill-vue'}), (js:Skill {id: 'skill-javascript'})
MERGE (vue)-[:REQUIRES {priority: 1, type: 'hard'}]->(js);

MATCH (angular:Skill {id: 'skill-angular'}), (ts:Skill {id: 'skill-typescript'})
MERGE (angular)-[:REQUIRES {priority: 1, type: 'hard'}]->(ts);

MATCH (svelte:Skill {id: 'skill-svelte'}), (js:Skill {id: 'skill-javascript'})
MERGE (svelte)-[:REQUIRES {priority: 1, type: 'hard'}]->(js);

MATCH (nextjs:Skill {id: 'skill-nextjs'}), (react:Skill {id: 'skill-react'})
MERGE (nextjs)-[:REQUIRES {priority: 1, type: 'hard'}]->(react);

MATCH (nuxtjs:Skill {id: 'skill-nuxtjs'}), (vue:Skill {id: 'skill-vue'})
MERGE (nuxtjs)-[:REQUIRES {priority: 1, type: 'hard'}]->(vue);

MATCH (redux:Skill {id: 'skill-redux'}), (react:Skill {id: 'skill-react'})
MERGE (redux)-[:REQUIRES {priority: 1, type: 'soft'}]->(react);

// ====================================================================================================
// SECTION 3: BACKEND TECHNOLOGIES (EXPANDED)
// ====================================================================================================

MERGE (fastapi:Skill {id: 'skill-fastapi'})
ON CREATE SET
    fastapi.name = 'FastAPI',
    fastapi.difficulty_level = 'intermediate',
    fastapi.estimated_hours = 40,
    fastapi.demand_score = 8,
    fastapi.category = 'backend',
    fastapi.prereq_level = 2;

MERGE (django:Skill {id: 'skill-django'})
ON CREATE SET
    django.name = 'Django',
    django.difficulty_level = 'intermediate',
    django.estimated_hours = 60,
    django.demand_score = 8,
    django.category = 'backend',
    django.prereq_level = 2;

MERGE (flask:Skill {id: 'skill-flask'})
ON CREATE SET
    flask.name = 'Flask',
    flask.difficulty_level = 'beginner',
    flask.estimated_hours = 30,
    flask.demand_score = 7,
    flask.category = 'backend',
    flask.prereq_level = 2;

MERGE (nestjs:Skill {id: 'skill-nestjs'})
ON CREATE SET
    nestjs.name = 'NestJS',
    nestjs.difficulty_level = 'intermediate',
    nestjs.estimated_hours = 50,
    nestjs.demand_score = 7,
    nestjs.category = 'backend',
    nestjs.prereq_level = 3;

MERGE (rails:Skill {id: 'skill-rails'})
ON CREATE SET
    rails.name = 'Ruby on Rails',
    rails.difficulty_level = 'intermediate',
    rails.estimated_hours = 60,
    rails.demand_score = 6,
    rails.category = 'backend',
    rails.prereq_level = 2;

MERGE (laravel:Skill {id: 'skill-laravel'})
ON CREATE SET
    laravel.name = 'Laravel',
    laravel.difficulty_level = 'intermediate',
    laravel.estimated_hours = 50,
    laravel.demand_score = 7,
    laravel.category = 'backend',
    laravel.prereq_level = 2;

MERGE (dotnet:Skill {id: 'skill-dotnet'})
ON CREATE SET
    dotnet.name = '.NET Core',
    dotnet.difficulty_level = 'intermediate',
    dotnet.estimated_hours = 70,
    dotnet.demand_score = 8,
    dotnet.category = 'backend',
    dotnet.prereq_level = 2;

// Databases
MERGE (mongodb:Skill {id: 'skill-mongodb'})
ON CREATE SET
    mongodb.name = 'MongoDB',
    mongodb.difficulty_level = 'intermediate',
    mongodb.estimated_hours = 40,
    mongodb.demand_score = 8,
    mongodb.category = 'database',
    mongodb.prereq_level = 2;

MERGE (redis:Skill {id: 'skill-redis'})
ON CREATE SET
    redis.name = 'Redis',
    redis.difficulty_level = 'intermediate',
    redis.estimated_hours = 25,
    redis.demand_score = 8,
    redis.category = 'database',
    redis.prereq_level = 2;

MERGE (cassandra:Skill {id: 'skill-cassandra'})
ON CREATE SET
    cassandra.name = 'Cassandra',
    cassandra.difficulty_level = 'advanced',
    cassandra.estimated_hours = 50,
    cassandra.demand_score = 6,
    cassandra.category = 'database',
    cassandra.prereq_level = 3;

MERGE (dynamodb:Skill {id: 'skill-dynamodb'})
ON CREATE SET
    dynamodb.name = 'DynamoDB',
    dynamodb.difficulty_level = 'intermediate',
    dynamodb.estimated_hours = 35,
    dynamodb.demand_score = 7,
    dynamodb.category = 'database',
    dynamodb.prereq_level = 2;

// Message Queues
MERGE (kafka:Skill {id: 'skill-kafka'})
ON CREATE SET
    kafka.name = 'Apache Kafka',
    kafka.difficulty_level = 'advanced',
    kafka.estimated_hours = 60,
    kafka.demand_score = 9,
    kafka.category = 'messaging',
    kafka.prereq_level = 3;

MERGE (rabbitmq:Skill {id: 'skill-rabbitmq'})
ON CREATE SET
    rabbitmq.name = 'RabbitMQ',
    rabbitmq.difficulty_level = 'intermediate',
    rabbitmq.estimated_hours = 35,
    rabbitmq.demand_score = 7,
    rabbitmq.category = 'messaging',
    rabbitmq.prereq_level = 2;

// Connect to subdomains
MATCH (backend:SubDomain {id: 'sub-sw-backend'}), (s:Skill)
WHERE s.id IN ['skill-fastapi', 'skill-django', 'skill-flask', 'skill-nestjs', 'skill-rails', 'skill-laravel', 'skill-dotnet', 'skill-mongodb', 'skill-redis', 'skill-cassandra', 'skill-dynamodb', 'skill-kafka', 'skill-rabbitmq']
MERGE (backend)-[:CONTAINS]->(s);

// Backend prerequisites
MATCH (fastapi:Skill {id: 'skill-fastapi'}), (python:Skill {id: 'skill-python'})
MERGE (fastapi)-[:REQUIRES {priority: 1, type: 'hard'}]->(python);

MATCH (django:Skill {id: 'skill-django'}), (python:Skill {id: 'skill-python'})
MERGE (django)-[:REQUIRES {priority: 1, type: 'hard'}]->(python);

MATCH (flask:Skill {id: 'skill-flask'}), (python:Skill {id: 'skill-python'})
MERGE (flask)-[:REQUIRES {priority: 1, type: 'hard'}]->(python);

MATCH (nestjs:Skill {id: 'skill-nestjs'}), (nodejs:Skill {id: 'skill-nodejs'})
MERGE (nestjs)-[:REQUIRES {priority: 1, type: 'hard'}]->(nodejs);

MATCH (nestjs:Skill {id: 'skill-nestjs'}), (ts:Skill {id: 'skill-typescript'})
MERGE (nestjs)-[:REQUIRES {priority: 2, type: 'hard'}]->(ts);

MATCH (rails:Skill {id: 'skill-rails'}), (ruby:Skill {id: 'skill-ruby'})
MERGE (rails)-[:REQUIRES {priority: 1, type: 'hard'}]->(ruby);

MATCH (laravel:Skill {id: 'skill-laravel'}), (php:Skill {id: 'skill-php'})
MERGE (laravel)-[:REQUIRES {priority: 1, type: 'hard'}]->(php);

MATCH (dotnet:Skill {id: 'skill-dotnet'}), (csharp:Skill {id: 'skill-csharp'})
MERGE (dotnet)-[:REQUIRES {priority: 1, type: 'hard'}]->(csharp);

// ====================================================================================================
// SECTION 4: AI/ML EXPANDED TOOLS & FRAMEWORKS
// ====================================================================================================

MERGE (tensorflow:Skill {id: 'skill-tensorflow'})
ON CREATE SET
    tensorflow.name = 'TensorFlow',
    tensorflow.difficulty_level = 'intermediate',
    tensorflow.estimated_hours = 60,
    tensorflow.demand_score = 8,
    tensorflow.category = 'deep-learning',
    tensorflow.prereq_level = 3;

MERGE (scikit:Skill {id: 'skill-scikit-learn'})
ON CREATE SET
    scikit.name = 'Scikit-learn',
    scikit.difficulty_level = 'intermediate',
    scikit.estimated_hours = 40,
    scikit.demand_score = 9,
    scikit.category = 'ml-fundamentals',
    scikit.prereq_level = 2;

MERGE (pandas:Skill {id: 'skill-pandas'})
ON CREATE SET
    pandas.name = 'Pandas',
    pandas.difficulty_level = 'beginner',
    pandas.estimated_hours = 30,
    pandas.demand_score = 9,
    pandas.category = 'data-analysis',
    pandas.prereq_level = 2;

MERGE (numpy:Skill {id: 'skill-numpy'})
ON CREATE SET
    numpy.name = 'NumPy',
    numpy.difficulty_level = 'beginner',
    numpy.estimated_hours = 25,
    numpy.demand_score = 9,
    numpy.category = 'data-analysis',
    numpy.prereq_level = 2;

MERGE (huggingface:Skill {id: 'skill-huggingface'})
ON CREATE SET
    huggingface.name = 'Hugging Face',
    huggingface.difficulty_level = 'intermediate',
    huggingface.estimated_hours = 40,
    huggingface.demand_score = 9,
    huggingface.category = 'gen-ai',
    huggingface.prereq_level = 3;

MERGE (xgboost:Skill {id: 'skill-xgboost'})
ON CREATE SET
    xgboost.name = 'XGBoost',
    xgboost.difficulty_level = 'intermediate',
    xgboost.estimated_hours = 25,
    xgboost.demand_score = 7,
    xgboost.category = 'ml-fundamentals',
    xgboost.prereq_level = 3;

MERGE (computer_vision:Skill {id: 'skill-computer-vision'})
ON CREATE SET
    computer_vision.name = 'Computer Vision',
    computer_vision.difficulty_level = 'advanced',
    computer_vision.estimated_hours = 80,
    computer_vision.demand_score = 8,
    computer_vision.category = 'deep-learning',
    computer_vision.prereq_level = 4;

MERGE (nlp:Skill {id: 'skill-nlp'})
ON CREATE SET
    nlp.name = 'Natural Language Processing',
    nlp.difficulty_level = 'advanced',
    nlp.estimated_hours = 70,
    nlp.demand_score = 9,
    nlp.category = 'deep-learning',
    nlp.prereq_level = 4;

MERGE (cuda:Skill {id: 'skill-cuda'})
ON CREATE SET
    cuda.name = 'CUDA Programming',
    cuda.difficulty_level = 'expert',
    cuda.estimated_hours = 60,
    cuda.demand_score = 6,
    cuda.category = 'deep-learning',
    cuda.prereq_level = 4;

// Connect to AI subdomains
MATCH (ml_fund:SubDomain {id: 'sub-ml-fundamentals'}), (s:Skill)
WHERE s.id IN ['skill-scikit-learn', 'skill-pandas', 'skill-numpy', 'skill-xgboost']
MERGE (ml_fund)-[:CONTAINS]->(s);

MATCH (dl:SubDomain {id: 'sub-deep-learning'}), (s:Skill)
WHERE s.id IN ['skill-tensorflow', 'skill-computer-vision', 'skill-nlp', 'skill-cuda']
MERGE (dl)-[:CONTAINS]->(s);

MATCH (genai:SubDomain {id: 'sub-gen-ai'}), (s:Skill {id: 'skill-huggingface'})
MERGE (genai)-[:CONTAINS]->(s);

// AI Prerequisites
MATCH (pandas:Skill {id: 'skill-pandas'}), (python:Skill {id: 'skill-python'})
MERGE (pandas)-[:REQUIRES {priority: 1, type: 'hard'}]->(python);

MATCH (numpy:Skill {id: 'skill-numpy'}), (python:Skill {id: 'skill-python'})
MERGE (numpy)-[:REQUIRES {priority: 1, type: 'hard'}]->(python);

MATCH (scikit:Skill {id: 'skill-scikit-learn'}), (numpy:Skill {id: 'skill-numpy'})
MERGE (scikit)-[:REQUIRES {priority: 1, type: 'hard'}]->(numpy);

MATCH (scikit:Skill {id: 'skill-scikit-learn'}), (pandas:Skill {id: 'skill-pandas'})
MERGE (scikit)-[:REQUIRES {priority: 2, type: 'hard'}]->(pandas);

MATCH (tensorflow:Skill {id: 'skill-tensorflow'}), (numpy:Skill {id: 'skill-numpy'})
MERGE (tensorflow)-[:REQUIRES {priority: 1, type: 'hard'}]->(numpy);

MATCH (huggingface:Skill {id: 'skill-huggingface'}), (pytorch:Skill {id: 'skill-pytorch'})
MERGE (huggingface)-[:REQUIRES {priority: 1, type: 'soft'}]->(pytorch);

MATCH (cv:Skill {id: 'skill-computer-vision'}), (dl:Skill {id: 'skill-deep-learning'})
MERGE (cv)-[:REQUIRES {priority: 1, type: 'hard'}]->(dl);

MATCH (nlp:Skill {id: 'skill-nlp'}), (dl:Skill {id: 'skill-deep-learning'})
MERGE (nlp)-[:REQUIRES {priority: 1, type: 'hard'}]->(dl);

// ====================================================================================================
// SECTION 5: DATA ENGINEERING TOOLS (EXPANDED)
// ====================================================================================================

MERGE (flink:Skill {id: 'skill-flink'})
ON CREATE SET
    flink.name = 'Apache Flink',
    flink.difficulty_level = 'advanced',
    flink.estimated_hours = 60,
    flink.demand_score = 6,
    flink.category = 'data-pipelines',
    flink.prereq_level = 3;

MERGE (beam:Skill {id: 'skill-beam'})
ON CREATE SET
    beam.name = 'Apache Beam',
    beam.difficulty_level = 'advanced',
    beam.estimated_hours = 50,
    beam.demand_score = 5,
    beam.category = 'data-pipelines',
    beam.prereq_level = 3;

MERGE (databricks:Skill {id: 'skill-databricks'})
ON CREATE SET
    databricks.name = 'Databricks',
    databricks.difficulty_level = 'intermediate',
    databricks.estimated_hours = 45,
    databricks.demand_score = 9,
    databricks.category = 'data-pipelines',
    databricks.prereq_level = 2;

MERGE (bigquery:Skill {id: 'skill-bigquery'})
ON CREATE SET
    bigquery.name = 'BigQuery',
    bigquery.difficulty_level = 'intermediate',
    bigquery.estimated_hours = 35,
    bigquery.demand_score = 8,
    bigquery.category = 'data-warehousing',
    bigquery.prereq_level = 2;

MERGE (redshift:Skill {id: 'skill-redshift'})
ON CREATE SET
    redshift.name = 'Amazon Redshift',
    redshift.difficulty_level = 'intermediate',
    redshift.estimated_hours = 40,
    redshift.demand_score = 7,
    redshift.category = 'data-warehousing',
    redshift.prereq_level = 2;

MERGE (tableau:Skill {id: 'skill-tableau'})
ON CREATE SET
    tableau.name = 'Tableau',
    tableau.difficulty_level = 'beginner',
    tableau.estimated_hours = 30,
    tableau.demand_score = 7,
    tableau.category = 'data-visualization',
    tableau.prereq_level = 2;

MERGE (powerbi:Skill {id: 'skill-powerbi'})
ON CREATE SET
    powerbi.name = 'Power BI',
    powerbi.difficulty_level = 'beginner',
    powerbi.estimated_hours = 35,
    powerbi.demand_score = 8,
    powerbi.category = 'data-visualization',
    powerbi.prereq_level = 2;

MERGE (looker:Skill {id: 'skill-looker'})
ON CREATE SET
    looker.name = 'Looker',
    looker.difficulty_level = 'intermediate',
    looker.estimated_hours = 40,
    looker.demand_score = 6,
    looker.category = 'data-visualization',
    looker.prereq_level = 2;

// Connect to data subdomains
MATCH (pipelines:SubDomain {id: 'sub-data-pipelines'}), (s:Skill)
WHERE s.id IN ['skill-flink', 'skill-beam', 'skill-databricks']
MERGE (pipelines)-[:CONTAINS]->(s);

MATCH (warehouse:SubDomain {id: 'sub-data-warehousing'}), (s:Skill)
WHERE s.id IN ['skill-bigquery', 'skill-redshift']
MERGE (warehouse)-[:CONTAINS]->(s);

// Create visualization subdomain if missing
MERGE (dataviz:SubDomain {id: 'sub-data-viz'})
ON CREATE SET
    dataviz.name = 'Data Visualization',
    dataviz.description = 'Data visualization and BI tools',
    dataviz.order = 4;

MATCH (data:Domain {id: 'domain-data'}), (dataviz:SubDomain {id: 'sub-data-viz'})
MERGE (data)-[:CONTAINS]->(dataviz);

MATCH (dataviz:SubDomain {id: 'sub-data-viz'}), (s:Skill)
WHERE s.id IN ['skill-tableau', 'skill-powerbi', 'skill-looker']
MERGE (dataviz)-[:CONTAINS]->(s);

// Data tool prerequisites
MATCH (flink:Skill {id: 'skill-flink'}), (java:Skill {id: 'skill-java-spring'})
MERGE (flink)-[:REQUIRES {priority: 1, type: 'soft'}]->(java);

MATCH (databricks:Skill {id: 'skill-databricks'}), (spark:Skill {id: 'skill-spark'})
MERGE (databricks)-[:REQUIRES {priority: 1, type: 'soft'}]->(spark);

MATCH (bigquery:Skill {id: 'skill-bigquery'}), (sql:Skill {id: 'skill-sql'})
MERGE (bigquery)-[:REQUIRES {priority: 1, type: 'hard'}]->(sql);

MATCH (redshift:Skill {id: 'skill-redshift'}), (sql:Skill {id: 'skill-sql'})
MERGE (redshift)-[:REQUIRES {priority: 1, type: 'hard'}]->(sql);

// ====================================================================================================
// SECTION 6: DEVOPS & INFRASTRUCTURE TOOLS (EXPANDED)
// ====================================================================================================

MERGE (jenkins:Skill {id: 'skill-jenkins'})
ON CREATE SET
    jenkins.name = 'Jenkins',
    jenkins.difficulty_level = 'intermediate',
    jenkins.estimated_hours = 40,
    jenkins.demand_score = 7,
    jenkins.category = 'cicd',
    jenkins.prereq_level = 2;

MERGE (github_actions:Skill {id: 'skill-github-actions'})
ON CREATE SET
    github_actions.name = 'GitHub Actions',
    github_actions.difficulty_level = 'beginner',
    github_actions.estimated_hours = 25,
    github_actions.demand_score = 8,
    github_actions.category = 'cicd',
    github_actions.prereq_level = 2;

MERGE (gitlab_ci:Skill {id: 'skill-gitlab-ci'})
ON CREATE SET
    gitlab_ci.name = 'GitLab CI/CD',
    gitlab_ci.difficulty_level = 'intermediate',
    gitlab_ci.estimated_hours = 30,
    gitlab_ci.demand_score = 7,
    gitlab_ci.category = 'cicd',
    gitlab_ci.prereq_level = 2;

MERGE (helm:Skill {id: 'skill-helm'})
ON CREATE SET
    helm.name = 'Helm',
    helm.difficulty_level = 'intermediate',
    helm.estimated_hours = 25,
    helm.demand_score = 8,
    helm.category = 'kubernetes',
    helm.prereq_level = 3;

MERGE (istio:Skill {id: 'skill-istio'})
ON CREATE SET
    istio.name = 'Istio Service Mesh',
    istio.difficulty_level = 'advanced',
    istio.estimated_hours = 50,
    istio.demand_score = 6,
    istio.category = 'kubernetes',
    istio.prereq_level = 4;

MERGE (vault:Skill {id: 'skill-vault'})
ON CREATE SET
    vault.name = 'HashiCorp Vault',
    vault.difficulty_level = 'intermediate',
    vault.estimated_hours = 40,
    vault.demand_score = 7,
    vault.category = 'security',
    vault.prereq_level = 3;

MERGE (consul:Skill {id: 'skill-consul'})
ON CREATE SET
    consul.name = 'HashiCorp Consul',
    consul.difficulty_level = 'intermediate',
    consul.estimated_hours = 35,
    consul.demand_score = 5,
    consul.category = 'service-mesh',
    consul.prereq_level = 3;

MERGE (pulumi:Skill {id: 'skill-pulumi'})
ON CREATE SET
    pulumi.name = 'Pulumi',
    pulumi.difficulty_level = 'intermediate',
    pulumi.estimated_hours = 40,
    pulumi.demand_score = 5,
    pulumi.category = 'iac',
    pulumi.prereq_level = 2;

MERGE (cloudformation:Skill {id: 'skill-cloudformation'})
ON CREATE SET
    cloudformation.name = 'AWS CloudFormation',
    cloudformation.difficulty_level = 'intermediate',
    cloudformation.estimated_hours = 35,
    cloudformation.demand_score = 6,
    cloudformation.category = 'iac',
    cloudformation.prereq_level = 2;

// Connect to DevOps subdomains
MATCH (cicd:SubDomain {id: 'sub-cicd'}), (s:Skill)
WHERE s.id IN ['skill-jenkins', 'skill-github-actions', 'skill-gitlab-ci']
MERGE (cicd)-[:CONTAINS]->(s);

MATCH (iac:SubDomain {id: 'sub-iac'}), (s:Skill)
WHERE s.id IN ['skill-pulumi', 'skill-cloudformation', 'skill-vault']
MERGE (iac)-[:CONTAINS]->(s);

MATCH (containers:SubDomain {id: 'sub-containers'}), (s:Skill)
WHERE s.id IN ['skill-helm', 'skill-istio']
MERGE (containers)-[:CONTAINS]->(s);

// DevOps prerequisites
MATCH (jenkins:Skill {id: 'skill-jenkins'}), (git:Skill {id: 'skill-git'})
MERGE (jenkins)-[:REQUIRES {priority: 1, type: 'hard'}]->(git);

MATCH (github_actions:Skill {id: 'skill-github-actions'}), (git:Skill {id: 'skill-git'})
MERGE (github_actions)-[:REQUIRES {priority: 1, type: 'hard'}]->(git);

MATCH (helm:Skill {id: 'skill-helm'}), (k8s:Skill {id: 'skill-kubernetes'})
MERGE (helm)-[:REQUIRES {priority: 1, type: 'hard'}]->(k8s);

MATCH (istio:Skill {id: 'skill-istio'}), (k8s:Skill {id: 'skill-kubernetes'})
MERGE (istio)-[:REQUIRES {priority: 1, type: 'hard'}]->(k8s);

MATCH (cloudformation:Skill {id: 'skill-cloudformation'}), (aws:Skill {id: 'skill-aws-fundamentals'})
MERGE (cloudformation)-[:REQUIRES {priority: 1, type: 'hard'}]->(aws);

// ====================================================================================================
// SECTION 7: EXPANDED CERTIFICATIONS
// ====================================================================================================

// AWS Certifications
MERGE (aws_dev:Certification {id: 'cert-aws-developer'})
ON CREATE SET
    aws_dev.name = 'AWS Certified Developer - Associate',
    aws_dev.provider = 'AWS',
    aws_dev.level = 'Associate',
    aws_dev.cost = 150,
    aws_dev.validity_period = '3 years';

MERGE (aws_sysops:Certification {id: 'cert-aws-sysops'})
ON CREATE SET
    aws_sysops.name = 'AWS Certified SysOps Administrator - Associate',
    aws_sysops.provider = 'AWS',
    aws_sysops.level = 'Associate',
    aws_sysops.cost = 150,
    aws_sysops.validity_period = '3 years';

MERGE (aws_sa_pro:Certification {id: 'cert-aws-sa-pro'})
ON CREATE SET
    aws_sa_pro.name = 'AWS Solutions Architect - Professional',
    aws_sa_pro.provider = 'AWS',
    aws_sa_pro.level = 'Professional',
    aws_sa_pro.cost = 300,
    aws_sa_pro.validity_period = '3 years';

MERGE (aws_devops:Certification {id: 'cert-aws-devops'})
ON CREATE SET
    aws_devops.name = 'AWS DevOps Engineer - Professional',
    aws_devops.provider = 'AWS',
    aws_devops.level = 'Professional',
    aws_devops.cost = 300,
    aws_devops.validity_period = '3 years';

MERGE (aws_ml:Certification {id: 'cert-aws-ml'})
ON CREATE SET
    aws_ml.name = 'AWS Machine Learning - Specialty',
    aws_ml.provider = 'AWS',
    aws_ml.level = 'Specialty',
    aws_ml.cost = 300,
    aws_ml.validity_period = '3 years';

MERGE (aws_data:Certification {id: 'cert-aws-data'})
ON CREATE SET
    aws_data.name = 'AWS Data Engineer - Associate',
    aws_data.provider = 'AWS',
    aws_data.level = 'Associate',
    aws_data.cost = 150,
    aws_data.validity_period = '3 years';

// Azure Certifications
MERGE (az_104:Certification {id: 'cert-az-104'})
ON CREATE SET
    az_104.name = 'Azure Administrator Associate',
    az_104.provider = 'Microsoft',
    az_104.level = 'Associate',
    az_104.cost = 165,
    az_104.validity_period = '1 year';

MERGE (az_204:Certification {id: 'cert-az-204'})
ON CREATE SET
    az_204.name = 'Azure Developer Associate',
    az_204.provider = 'Microsoft',
    az_204.level = 'Associate',
    az_204.cost = 165,
    az_204.validity_period = '1 year';

MERGE (az_305:Certification {id: 'cert-az-305'})
ON CREATE SET
    az_305.name = 'Azure Solutions Architect Expert',
    az_305.provider = 'Microsoft',
    az_305.level = 'Expert',
    az_305.cost = 165,
    az_305.validity_period = '1 year';

MERGE (az_400:Certification {id: 'cert-az-400'})
ON CREATE SET
    az_400.name = 'Azure DevOps Engineer Expert',
    az_400.provider = 'Microsoft',
    az_400.level = 'Expert',
    az_400.cost = 165,
    az_400.validity_period = '1 year';

MERGE (dp_100:Certification {id: 'cert-dp-100'})
ON CREATE SET
    dp_100.name = 'Azure Data Scientist Associate',
    dp_100.provider = 'Microsoft',
    dp_100.level = 'Associate',
    dp_100.cost = 165,
    dp_100.validity_period = '1 year';

MERGE (dp_203:Certification {id: 'cert-dp-203'})
ON CREATE SET
    dp_203.name = 'Azure Data Engineer Associate',
    dp_203.provider = 'Microsoft',
    dp_203.level = 'Associate',
    dp_203.cost = 165,
    dp_203.validity_period = '1 year';

// GCP Certifications
MERGE (gcp_ace:Certification {id: 'cert-gcp-ace'})
ON CREATE SET
    gcp_ace.name = 'Google Cloud Associate Cloud Engineer',
    gcp_ace.provider = 'Google',
    gcp_ace.level = 'Associate',
    gcp_ace.cost = 125,
    gcp_ace.validity_period = '2 years';

MERGE (gcp_pca:Certification {id: 'cert-gcp-pca'})
ON CREATE SET
    gcp_pca.name = 'Google Cloud Professional Cloud Architect',
    gcp_pca.provider = 'Google',
    gcp_pca.level = 'Professional',
    gcp_pca.cost = 200,
    gcp_pca.validity_period = '2 years';

MERGE (gcp_pde:Certification {id: 'cert-gcp-pde'})
ON CREATE SET
    gcp_pde.name = 'Google Cloud Professional Data Engineer',
    gcp_pde.provider = 'Google',
    gcp_pde.level = 'Professional',
    gcp_pde.cost = 200,
    gcp_pde.validity_period = '2 years';

MERGE (gcp_pml:Certification {id: 'cert-gcp-pml'})
ON CREATE SET
    gcp_pml.name = 'Google Cloud Professional ML Engineer',
    gcp_pml.provider = 'Google',
    gcp_pml.level = 'Professional',
    gcp_pml.cost = 200,
    gcp_pml.validity_period = '2 years';

// Kubernetes Certifications
MERGE (ckad:Certification {id: 'cert-ckad'})
ON CREATE SET
    ckad.name = 'Certified Kubernetes Application Developer',
    ckad.provider = 'CNCF',
    ckad.level = 'Professional',
    ckad.cost = 395,
    ckad.validity_period = '2 years';

MERGE (cks:Certification {id: 'cert-cks'})
ON CREATE SET
    cks.name = 'Certified Kubernetes Security Specialist',
    cks.provider = 'CNCF',
    cks.level = 'Professional',
    cks.cost = 395,
    cks.validity_period = '2 years';

MERGE (kcna:Certification {id: 'cert-kcna'})
ON CREATE SET
    kcna.name = 'Kubernetes and Cloud Native Associate',
    kcna.provider = 'CNCF',
    kcna.level = 'Associate',
    kcna.cost = 250,
    kcna.validity_period = '3 years';

// Data Engineering Certifications
MERGE (databricks_de_associate:Certification {id: 'cert-databricks-de-associate'})
ON CREATE SET
    databricks_de_associate.name = 'Databricks Certified Data Engineer Associate',
    databricks_de_associate.provider = 'Databricks',
    databricks_de_associate.level = 'Associate',
    databricks_de_associate.cost = 200,
    databricks_de_associate.validity_period = '2 years';

MERGE (databricks_de_pro:Certification {id: 'cert-databricks-de-pro'})
ON CREATE SET
    databricks_de_pro.name = 'Databricks Certified Data Engineer Professional',
    databricks_de_pro.provider = 'Databricks',
    databricks_de_pro.level = 'Professional',
    databricks_de_pro.cost = 200,
    databricks_de_pro.validity_period = '2 years';

MERGE (snowpro_core:Certification {id: 'cert-snowpro-core'})
ON CREATE SET
    snowpro_core.name = 'SnowPro Core Certification',
    snowpro_core.provider = 'Snowflake',
    snowpro_core.level = 'Core',
    snowpro_core.cost = 175,
    snowpro_core.validity_period = '2 years';

MERGE (snowpro_de:Certification {id: 'cert-snowpro-de'})
ON CREATE SET
    snowpro_de.name = 'SnowPro Advanced: Data Engineer',
    snowpro_de.provider = 'Snowflake',
    snowpro_de.level = 'Advanced',
    snowpro_de.cost = 375,
    snowpro_de.validity_period = '2 years';

MERGE (dbt_fundamentals:Certification {id: 'cert-dbt-fundamentals'})
ON CREATE SET
    dbt_fundamentals.name = 'dbt Fundamentals',
    dbt_fundamentals.provider = 'dbt Labs',
    dbt_fundamentals.level = 'Fundamentals',
    dbt_fundamentals.cost = 0,
    dbt_fundamentals.validity_period = 'Lifetime';

// HashiCorp Certifications
MERGE (terraform_pro:Certification {id: 'cert-terraform-pro'})
ON CREATE SET
    terraform_pro.name = 'Terraform Authoring and Operations Professional',
    terraform_pro.provider = 'HashiCorp',
    terraform_pro.level = 'Professional',
    terraform_pro.cost = 395,
    terraform_pro.validity_period = '2 years';

MERGE (vault_associate:Certification {id: 'cert-vault-associate'})
ON CREATE SET
    vault_associate.name = 'HashiCorp Vault Associate',
    vault_associate.provider = 'HashiCorp',
    vault_associate.level = 'Associate',
    vault_associate.cost = 70,
    vault_associate.validity_period = '2 years';

MERGE (vault_pro:Certification {id: 'cert-vault-pro'})
ON CREATE SET
    vault_pro.name = 'HashiCorp Vault Operations Professional',
    vault_pro.provider = 'HashiCorp',
    vault_pro.level = 'Professional',
    vault_pro.cost = 395,
    vault_pro.validity_period = '2 years';

// Connect certifications to skills
MATCH (skill:Skill {id: 'skill-aws-fundamentals'}), (cert:Certification {id: 'cert-aws-developer'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-aws-fundamentals'}), (cert:Certification {id: 'cert-aws-sysops'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-aws-architect'}), (cert:Certification {id: 'cert-aws-sa-pro'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-azure-fundamentals'}), (cert:Certification {id: 'cert-az-104'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-azure-fundamentals'}), (cert:Certification {id: 'cert-az-204'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-gcp-fundamentals'}), (cert:Certification {id: 'cert-gcp-ace'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-kubernetes'}), (cert:Certification {id: 'cert-ckad'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-kubernetes'}), (cert:Certification {id: 'cert-cks'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-databricks'}), (cert:Certification {id: 'cert-databricks-de-associate'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-snowflake'}), (cert:Certification {id: 'cert-snowpro-core'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-dbt'}), (cert:Certification {id: 'cert-dbt-fundamentals'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-terraform'}), (cert:Certification {id: 'cert-terraform-pro'})
MERGE (skill)-[:LEADS_TO]->(cert);

MATCH (skill:Skill {id: 'skill-vault'}), (cert:Certification {id: 'cert-vault-associate'})
MERGE (skill)-[:LEADS_TO]->(cert);

// ====================================================================================================
// SECTION 8: CROSS-DOMAIN SKILL APPLICATIONS (EXPANDED)
// ====================================================================================================

// Python applies across many domains
MATCH (python:Skill {id: 'skill-python'}), (d:Domain)
WHERE d.id IN ['domain-ai-ml', 'domain-data', 'domain-devops', 'domain-software', 'domain-sre']
MERGE (python)-[:APPLIES_IN]->(d);

// JavaScript applies in multiple areas
MATCH (js:Skill {id: 'skill-javascript'}), (d:Domain)
WHERE d.id IN ['domain-software', 'domain-devops']
MERGE (js)-[:APPLIES_IN]->(d);

// Docker applies everywhere
MATCH (docker:Skill {id: 'skill-docker'}), (d:Domain)
WHERE d.id IN ['domain-devops', 'domain-cloud', 'domain-sre', 'domain-software', 'domain-data']
MERGE (docker)-[:APPLIES_IN]->(d);

// Kubernetes applies broadly
MATCH (k8s:Skill {id: 'skill-kubernetes'}), (d:Domain)
WHERE d.id IN ['domain-cloud', 'domain-devops', 'domain-sre', 'domain-data']
MERGE (k8s)-[:APPLIES_IN]->(d);

// SQL applies in data-related domains
MATCH (sql:Skill {id: 'skill-sql'}), (d:Domain)
WHERE d.id IN ['domain-data', 'domain-software', 'domain-ai-ml', 'domain-sre']
MERGE (sql)-[:APPLIES_IN]->(d);

// Kafka applies in multiple domains
MATCH (kafka:Skill {id: 'skill-kafka'}), (d:Domain)
WHERE d.id IN ['domain-data', 'domain-software', 'domain-sre']
MERGE (kafka)-[:APPLIES_IN]->(d);

// ====================================================================================================
// SECTION 9: LEARNING PATH PROGRESSIONS (EXPANDED)
// ====================================================================================================

// Frontend progression paths
MATCH (js:Skill {id: 'skill-javascript'}), (vue:Skill {id: 'skill-vue'})
MERGE (js)-[:LEADS_TO]->(vue);

MATCH (js:Skill {id: 'skill-javascript'}), (angular:Skill {id: 'skill-angular'})
MERGE (js)-[:LEADS_TO]->(angular);

MATCH (js:Skill {id: 'skill-javascript'}), (svelte:Skill {id: 'skill-svelte'})
MERGE (js)-[:LEADS_TO]->(svelte);

MATCH (react:Skill {id: 'skill-react'}), (nextjs:Skill {id: 'skill-nextjs'})
MERGE (react)-[:LEADS_TO]->(nextjs);

MATCH (vue:Skill {id: 'skill-vue'}), (nuxtjs:Skill {id: 'skill-nuxtjs'})
MERGE (vue)-[:LEADS_TO]->(nuxtjs);

// Backend progression paths
MATCH (python:Skill {id: 'skill-python'}), (django:Skill {id: 'skill-django'})
MERGE (python)-[:LEADS_TO]->(django);

MATCH (python:Skill {id: 'skill-python'}), (fastapi:Skill {id: 'skill-fastapi'})
MERGE (python)-[:LEADS_TO]->(fastapi);

MATCH (nodejs:Skill {id: 'skill-nodejs'}), (nestjs:Skill {id: 'skill-nestjs'})
MERGE (nodejs)-[:LEADS_TO]->(nestjs);

// Data progression paths
MATCH (sql:Skill {id: 'skill-sql'}), (snowflake:Skill {id: 'skill-snowflake'})
MERGE (sql)-[:LEADS_TO]->(snowflake);

MATCH (sql:Skill {id: 'skill-sql'}), (bigquery:Skill {id: 'skill-bigquery'})
MERGE (sql)-[:LEADS_TO]->(bigquery);

MATCH (spark:Skill {id: 'skill-spark'}), (databricks:Skill {id: 'skill-databricks'})
MERGE (spark)-[:LEADS_TO]->(databricks);

// ML progression paths
MATCH (numpy:Skill {id: 'skill-numpy'}), (pandas:Skill {id: 'skill-pandas'})
MERGE (numpy)-[:LEADS_TO]->(pandas);

MATCH (pandas:Skill {id: 'skill-pandas'}), (scikit:Skill {id: 'skill-scikit-learn'})
MERGE (pandas)-[:LEADS_TO]->(scikit);

MATCH (dl:Skill {id: 'skill-deep-learning'}), (tensorflow:Skill {id: 'skill-tensorflow'})
MERGE (dl)-[:LEADS_TO]->(tensorflow);

MATCH (pytorch:Skill {id: 'skill-pytorch'}), (huggingface:Skill {id: 'skill-huggingface'})
MERGE (pytorch)-[:LEADS_TO]->(huggingface);

// DevOps progression paths
MATCH (git:Skill {id: 'skill-git'}), (github_actions:Skill {id: 'skill-github-actions'})
MERGE (git)-[:LEADS_TO]->(github_actions);

MATCH (k8s:Skill {id: 'skill-kubernetes'}), (helm:Skill {id: 'skill-helm'})
MERGE (k8s)-[:LEADS_TO]->(helm);

MATCH (helm:Skill {id: 'skill-helm'}), (istio:Skill {id: 'skill-istio'})
MERGE (helm)-[:LEADS_TO]->(istio);

// ====================================================================================================
// SECTION 10: MOBILE AND ADDITIONAL SUBDOMAINS
// ====================================================================================================

// Create mobile subdomain
MERGE (mobile:SubDomain {id: 'sub-sw-mobile'})
ON CREATE SET
    mobile.name = 'Mobile Development',
    mobile.description = 'iOS, Android, and cross-platform mobile development',
    mobile.order = 5;

MATCH (software:Domain {id: 'domain-software'}), (mobile:SubDomain {id: 'sub-sw-mobile'})
MERGE (software)-[:CONTAINS]->(mobile);

// Mobile development skills
MERGE (react_native:Skill {id: 'skill-react-native'})
ON CREATE SET
    react_native.name = 'React Native',
    react_native.difficulty_level = 'intermediate',
    react_native.estimated_hours = 60,
    react_native.demand_score = 8,
    react_native.category = 'mobile',
    react_native.prereq_level = 3;

MERGE (flutter:Skill {id: 'skill-flutter'})
ON CREATE SET
    flutter.name = 'Flutter',
    flutter.difficulty_level = 'intermediate',
    flutter.estimated_hours = 60,
    flutter.demand_score = 7,
    flutter.category = 'mobile',
    flutter.prereq_level = 2;

MERGE (ios_dev:Skill {id: 'skill-ios-dev'})
ON CREATE SET
    ios_dev.name = 'iOS Development',
    ios_dev.difficulty_level = 'intermediate',
    ios_dev.estimated_hours = 80,
    ios_dev.demand_score = 7,
    ios_dev.category = 'mobile',
    ios_dev.prereq_level = 2;

MERGE (android_dev:Skill {id: 'skill-android-dev'})
ON CREATE SET
    android_dev.name = 'Android Development',
    android_dev.difficulty_level = 'intermediate',
    android_dev.estimated_hours = 80,
    android_dev.demand_score = 7,
    android_dev.category = 'mobile',
    android_dev.prereq_level = 2;

// Connect to mobile subdomain
MATCH (mobile:SubDomain {id: 'sub-sw-mobile'}), (s:Skill)
WHERE s.id IN ['skill-react-native', 'skill-flutter', 'skill-ios-dev', 'skill-android-dev']
MERGE (mobile)-[:CONTAINS]->(s);

// Mobile prerequisites
MATCH (react_native:Skill {id: 'skill-react-native'}), (react:Skill {id: 'skill-react'})
MERGE (react_native)-[:REQUIRES {priority: 1, type: 'hard'}]->(react);

MATCH (ios_dev:Skill {id: 'skill-ios-dev'}), (swift:Skill {id: 'skill-swift'})
MERGE (ios_dev)-[:REQUIRES {priority: 1, type: 'hard'}]->(swift);

MATCH (android_dev:Skill {id: 'skill-android-dev'}), (kotlin:Skill {id: 'skill-kotlin'})
MERGE (android_dev)-[:REQUIRES {priority: 1, type: 'hard'}]->(kotlin);

// ====================================================================================================
// SECTION 11: NETWORKING AND SECURITY SKILLS
// ====================================================================================================

MERGE (network_fundamentals:Skill {id: 'skill-network-fundamentals'})
ON CREATE SET
    network_fundamentals.name = 'Networking Fundamentals',
    network_fundamentals.difficulty_level = 'beginner',
    network_fundamentals.estimated_hours = 40,
    network_fundamentals.demand_score = 7,
    network_fundamentals.category = 'networking',
    network_fundamentals.prereq_level = 1;

MERGE (tcp_ip:Skill {id: 'skill-tcp-ip'})
ON CREATE SET
    tcp_ip.name = 'TCP/IP Protocol Suite',
    tcp_ip.difficulty_level = 'intermediate',
    tcp_ip.estimated_hours = 30,
    tcp_ip.demand_score = 6,
    tcp_ip.category = 'networking',
    tcp_ip.prereq_level = 2;

MERGE (load_balancing:Skill {id: 'skill-load-balancing'})
ON CREATE SET
    load_balancing.name = 'Load Balancing',
    load_balancing.difficulty_level = 'intermediate',
    load_balancing.estimated_hours = 25,
    load_balancing.demand_score = 7,
    load_balancing.category = 'networking',
    load_balancing.prereq_level = 2;

MERGE (api_security:Skill {id: 'skill-api-security'})
ON CREATE SET
    api_security.name = 'API Security',
    api_security.difficulty_level = 'intermediate',
    api_security.estimated_hours = 30,
    api_security.demand_score = 8,
    api_security.category = 'security',
    api_security.prereq_level = 3;

MERGE (oauth:Skill {id: 'skill-oauth'})
ON CREATE SET
    oauth.name = 'OAuth & OpenID Connect',
    oauth.difficulty_level = 'intermediate',
    oauth.estimated_hours = 25,
    oauth.demand_score = 8,
    oauth.category = 'security',
    oauth.prereq_level = 3;

MERGE (sast:Skill {id: 'skill-sast'})
ON CREATE SET
    sast.name = 'SAST (Static Application Security Testing)',
    sast.difficulty_level = 'intermediate',
    sast.estimated_hours = 35,
    sast.demand_score = 7,
    sast.category = 'security',
    sast.prereq_level = 3;

MERGE (dast:Skill {id: 'skill-dast'})
ON CREATE SET
    dast.name = 'DAST (Dynamic Application Security Testing)',
    dast.difficulty_level = 'intermediate',
    dast.estimated_hours = 35,
    dast.demand_score = 7,
    dast.category = 'security',
    dast.prereq_level = 3;

// Connect to security subdomain
MATCH (security:SubDomain {id: 'sub-sec-devsecops'}), (s:Skill)
WHERE s.id IN ['skill-api-security', 'skill-oauth', 'skill-sast', 'skill-dast']
MERGE (security)-[:CONTAINS]->(s);

// Create networking subdomain if missing
MERGE (networking:SubDomain {id: 'sub-networking'})
ON CREATE SET
    networking.name = 'Networking',
    networking.description = 'Network protocols, load balancing, and network security',
    networking.order = 3;

MATCH (cloud:Domain {id: 'domain-cloud'}), (networking:SubDomain {id: 'sub-networking'})
MERGE (cloud)-[:CONTAINS]->(networking);

MATCH (networking:SubDomain {id: 'sub-networking'}), (s:Skill)
WHERE s.id IN ['skill-network-fundamentals', 'skill-tcp-ip', 'skill-load-balancing']
MERGE (networking)-[:CONTAINS]->(s);

// ====================================================================================================
// SECTION 12: ADDITIONAL RESOURCES FOR NEW SKILLS
// ====================================================================================================

// Rust Resources
MERGE (rust_book:Resource {id: 'res-rust-book'})
ON CREATE SET
    rust_book.title = 'The Rust Programming Language',
    rust_book.type = 'book',
    rust_book.url = 'https://doc.rust-lang.org/book/',
    rust_book.provider = 'Rust Team',
    rust_book.cost = 0,
    rust_book.rating = 4.9;

MATCH (rust:Skill {id: 'skill-rust'}), (res:Resource {id: 'res-rust-book'})
MERGE (rust)-[:HAS_RESOURCE]->(res);

// Vue.js Resources
MERGE (vue_docs:Resource {id: 'res-vue-docs'})
ON CREATE SET
    vue_docs.title = 'Vue.js Official Documentation',
    vue_docs.type = 'documentation',
    vue_docs.url = 'https://vuejs.org/guide/',
    vue_docs.provider = 'Vue.js',
    vue_docs.cost = 0,
    vue_docs.rating = 4.8;

MATCH (vue:Skill {id: 'skill-vue'}), (res:Resource {id: 'res-vue-docs'})
MERGE (vue)-[:HAS_RESOURCE]->(res);

// Angular Resources
MERGE (angular_docs:Resource {id: 'res-angular-docs'})
ON CREATE SET
    angular_docs.title = 'Angular Official Documentation',
    angular_docs.type = 'documentation',
    angular_docs.url = 'https://angular.io/docs',
    angular_docs.provider = 'Google',
    angular_docs.cost = 0,
    angular_docs.rating = 4.6;

MATCH (angular:Skill {id: 'skill-angular'}), (res:Resource {id: 'res-angular-docs'})
MERGE (angular)-[:HAS_RESOURCE]->(res);

// FastAPI Resources
MERGE (fastapi_docs:Resource {id: 'res-fastapi-docs'})
ON CREATE SET
    fastapi_docs.title = 'FastAPI Documentation',
    fastapi_docs.type = 'documentation',
    fastapi_docs.url = 'https://fastapi.tiangolo.com/',
    fastapi_docs.provider = 'FastAPI',
    fastapi_docs.cost = 0,
    fastapi_docs.rating = 4.9;

MATCH (fastapi:Skill {id: 'skill-fastapi'}), (res:Resource {id: 'res-fastapi-docs'})
MERGE (fastapi)-[:HAS_RESOURCE]->(res);

// Django Resources
MERGE (django_docs:Resource {id: 'res-django-docs'})
ON CREATE SET
    django_docs.title = 'Django Documentation',
    django_docs.type = 'documentation',
    django_docs.url = 'https://docs.djangoproject.com/',
    django_docs.provider = 'Django Software Foundation',
    django_docs.cost = 0,
    django_docs.rating = 4.7;

MATCH (django:Skill {id: 'skill-django'}), (res:Resource {id: 'res-django-docs'})
MERGE (django)-[:HAS_RESOURCE]->(res);

// Kafka Resources
MERGE (kafka_definitive:Resource {id: 'res-kafka-definitive'})
ON CREATE SET
    kafka_definitive.title = 'Kafka: The Definitive Guide',
    kafka_definitive.type = 'book',
    kafka_definitive.url = 'https://www.oreilly.com/library/view/kafka-the-definitive/9781491936153/',
    kafka_definitive.provider = 'OReilly',
    kafka_definitive.cost = 50,
    kafka_definitive.rating = 4.7;

MATCH (kafka:Skill {id: 'skill-kafka'}), (res:Resource {id: 'res-kafka-definitive'})
MERGE (kafka)-[:HAS_RESOURCE]->(res);

// MongoDB Resources
MERGE (mongo_university:Resource {id: 'res-mongo-university'})
ON CREATE SET
    mongo_university.title = 'MongoDB University',
    mongo_university.type = 'course',
    mongo_university.url = 'https://university.mongodb.com/',
    mongo_university.provider = 'MongoDB',
    mongo_university.cost = 0,
    mongo_university.rating = 4.6;

MATCH (mongodb:Skill {id: 'skill-mongodb'}), (res:Resource {id: 'res-mongo-university'})
MERGE (mongodb)-[:HAS_RESOURCE]->(res);

// ====================================================================================================
// SECTION 13: ADDITIONAL AZURE SKILLS
// ====================================================================================================

MERGE (azure_devops:Skill {id: 'skill-azure-devops'})
ON CREATE SET
    azure_devops.name = 'Azure DevOps',
    azure_devops.difficulty_level = 'intermediate',
    azure_devops.estimated_hours = 50,
    azure_devops.demand_score = 8,
    azure_devops.category = 'azure',
    azure_devops.prereq_level = 2;

MERGE (azure_functions:Skill {id: 'skill-azure-functions'})
ON CREATE SET
    azure_functions.name = 'Azure Functions',
    azure_functions.difficulty_level = 'intermediate',
    azure_functions.estimated_hours = 35,
    azure_functions.demand_score = 7,
    azure_functions.category = 'azure',
    azure_functions.prereq_level = 2;

MERGE (azure_ml:Skill {id: 'skill-azure-ml'})
ON CREATE SET
    azure_ml.name = 'Azure Machine Learning',
    azure_ml.difficulty_level = 'intermediate',
    azure_ml.estimated_hours = 60,
    azure_ml.demand_score = 7,
    azure_ml.category = 'azure',
    azure_ml.prereq_level = 3;

// Connect to Azure subdomain
MATCH (azure:SubDomain {id: 'sub-azure'}), (s:Skill)
WHERE s.id IN ['skill-azure-devops', 'skill-azure-functions', 'skill-azure-ml']
MERGE (azure)-[:CONTAINS]->(s);

// Azure prerequisites
MATCH (azure_devops:Skill {id: 'skill-azure-devops'}), (azure_fund:Skill {id: 'skill-azure-fundamentals'})
MERGE (azure_devops)-[:REQUIRES {priority: 1, type: 'hard'}]->(azure_fund);

MATCH (azure_functions:Skill {id: 'skill-azure-functions'}), (azure_fund:Skill {id: 'skill-azure-fundamentals'})
MERGE (azure_functions)-[:REQUIRES {priority: 1, type: 'hard'}]->(azure_fund);

MATCH (azure_ml:Skill {id: 'skill-azure-ml'}), (azure_fund:Skill {id: 'skill-azure-fundamentals'})
MERGE (azure_ml)-[:REQUIRES {priority: 1, type: 'hard'}]->(azure_fund);

// Connect Azure certifications
MATCH (azure_devops:Skill {id: 'skill-azure-devops'}), (cert:Certification {id: 'cert-az-400'})
MERGE (azure_devops)-[:LEADS_TO]->(cert);

MATCH (azure_fund:Skill {id: 'skill-azure-fundamentals'}), (cert:Certification {id: 'cert-az-305'})
MERGE (azure_fund)-[:LEADS_TO]->(cert);

// ====================================================================================================
// SECTION 14: ADDITIONAL GCP SKILLS
// ====================================================================================================

MERGE (gcp_compute:Skill {id: 'skill-gcp-compute'})
ON CREATE SET
    gcp_compute.name = 'GCP Compute Engine',
    gcp_compute.difficulty_level = 'intermediate',
    gcp_compute.estimated_hours = 35,
    gcp_compute.demand_score = 7,
    gcp_compute.category = 'gcp',
    gcp_compute.prereq_level = 2;

MERGE (gcp_gke:Skill {id: 'skill-gcp-gke'})
ON CREATE SET
    gcp_gke.name = 'Google Kubernetes Engine',
    gcp_gke.difficulty_level = 'intermediate',
    gcp_gke.estimated_hours = 45,
    gcp_gke.demand_score = 8,
    gcp_gke.category = 'gcp',
    gcp_gke.prereq_level = 3;

MERGE (gcp_cloud_functions:Skill {id: 'skill-gcp-cloud-functions'})
ON CREATE SET
    gcp_cloud_functions.name = 'Google Cloud Functions',
    gcp_cloud_functions.difficulty_level = 'intermediate',
    gcp_cloud_functions.estimated_hours = 30,
    gcp_cloud_functions.demand_score = 7,
    gcp_cloud_functions.category = 'gcp',
    gcp_cloud_functions.prereq_level = 2;

MERGE (gcp_vertex_ai:Skill {id: 'skill-gcp-vertex-ai'})
ON CREATE SET
    gcp_vertex_ai.name = 'Vertex AI',
    gcp_vertex_ai.difficulty_level = 'intermediate',
    gcp_vertex_ai.estimated_hours = 50,
    gcp_vertex_ai.demand_score = 8,
    gcp_vertex_ai.category = 'gcp',
    gcp_vertex_ai.prereq_level = 3;

// Connect to GCP subdomain
MATCH (gcp:SubDomain {id: 'sub-gcp'}), (s:Skill)
WHERE s.id IN ['skill-gcp-compute', 'skill-gcp-gke', 'skill-gcp-cloud-functions', 'skill-gcp-vertex-ai']
MERGE (gcp)-[:CONTAINS]->(s);

// GCP prerequisites
MATCH (gcp_compute:Skill {id: 'skill-gcp-compute'}), (gcp_fund:Skill {id: 'skill-gcp-fundamentals'})
MERGE (gcp_compute)-[:REQUIRES {priority: 1, type: 'hard'}]->(gcp_fund);

MATCH (gcp_gke:Skill {id: 'skill-gcp-gke'}), (k8s:Skill {id: 'skill-kubernetes'})
MERGE (gcp_gke)-[:REQUIRES {priority: 1, type: 'hard'}]->(k8s);

MATCH (gcp_gke:Skill {id: 'skill-gcp-gke'}), (gcp_fund:Skill {id: 'skill-gcp-fundamentals'})
MERGE (gcp_gke)-[:REQUIRES {priority: 2, type: 'hard'}]->(gcp_fund);

// Connect GCP certifications
MATCH (gcp_compute:Skill {id: 'skill-gcp-compute'}), (cert:Certification {id: 'cert-gcp-ace'})
MERGE (gcp_compute)-[:LEADS_TO]->(cert);

MATCH (gcp_vertex_ai:Skill {id: 'skill-gcp-vertex-ai'}), (cert:Certification {id: 'cert-gcp-pml'})
MERGE (gcp_vertex_ai)-[:LEADS_TO]->(cert);

// ====================================================================================================
// SECTION 15: CONCEPTS (FUNDAMENTAL KNOWLEDGE)
// ====================================================================================================

MERGE (solid_principles:Concept {id: 'concept-solid'})
ON CREATE SET
    solid_principles.name = 'SOLID Principles',
    solid_principles.description = 'Five design principles for maintainable object-oriented software',
    solid_principles.why_important = 'Foundation for writing clean, maintainable code',
    solid_principles.applies_to = ['software', 'architecture'];

MERGE (cap_theorem:Concept {id: 'concept-cap'})
ON CREATE SET
    cap_theorem.name = 'CAP Theorem',
    cap_theorem.description = 'States that distributed systems can only guarantee two of: Consistency, Availability, Partition tolerance',
    cap_theorem.why_important = 'Critical for understanding distributed system trade-offs',
    cap_theorem.applies_to = ['architecture', 'database', 'distributed-systems'];

MERGE (twelve_factor:Concept {id: 'concept-twelve-factor'})
ON CREATE SET
    twelve_factor.name = 'Twelve-Factor App',
    twelve_factor.description = 'Methodology for building software-as-a-service applications',
    twelve_factor.why_important = 'Best practices for cloud-native application development',
    twelve_factor.applies_to = ['cloud', 'devops', 'architecture'];

MERGE (agile:Concept {id: 'concept-agile'})
ON CREATE SET
    agile.name = 'Agile Methodology',
    agile.description = 'Iterative approach to software development and project management',
    agile.why_important = 'Industry standard for modern software development',
    agile.applies_to = ['software', 'project-management'];

MERGE (ci_cd_concept:Concept {id: 'concept-ci-cd'})
ON CREATE SET
    ci_cd_concept.name = 'CI/CD Principles',
    ci_cd_concept.description = 'Continuous Integration and Continuous Delivery/Deployment practices',
    ci_cd_concept.why_important = 'Enables rapid, reliable software delivery',
    ci_cd_concept.applies_to = ['devops', 'software'];

MERGE (microservices_concept:Concept {id: 'concept-microservices'})
ON CREATE SET
    microservices_concept.name = 'Microservices Architecture',
    microservices_concept.description = 'Architectural style structuring applications as collections of loosely coupled services',
    microservices_concept.why_important = 'Enables scalability and independent deployment',
    microservices_concept.applies_to = ['architecture', 'cloud', 'devops'];

MERGE (zero_trust:Concept {id: 'concept-zero-trust'})
ON CREATE SET
    zero_trust.name = 'Zero Trust Security',
    zero_trust.description = 'Security model that requires verification for every person and device',
    zero_trust.why_important = 'Modern security approach for cloud and distributed systems',
    zero_trust.applies_to = ['security', 'cloud', 'networking'];

MERGE (data_mesh:Concept {id: 'concept-data-mesh'})
ON CREATE SET
    data_mesh.name = 'Data Mesh',
    data_mesh.description = 'Decentralized socio-technical approach to data management',
    data_mesh.why_important = 'Scales data architecture for large organizations',
    data_mesh.applies_to = ['data', 'architecture'];

// Connect concepts to relevant skills
MATCH (concept:Concept {id: 'concept-solid'}), (skill:Skill {id: 'skill-system-design'})
MERGE (skill)-[:BASED_ON]->(concept);

MATCH (concept:Concept {id: 'concept-cap'}), (skill:Skill {id: 'skill-system-design'})
MERGE (skill)-[:BASED_ON]->(concept);

MATCH (concept:Concept {id: 'concept-twelve-factor'}), (skill:Skill {id: 'skill-microservices'})
MERGE (skill)-[:BASED_ON]->(concept);

MATCH (concept:Concept {id: 'concept-ci-cd'}), (skill:Skill {id: 'skill-cicd-pipelines'})
MERGE (skill)-[:BASED_ON]->(concept);

MATCH (concept:Concept {id: 'concept-microservices'}), (skill:Skill {id: 'skill-microservices'})
MERGE (skill)-[:BASED_ON]->(concept);

MATCH (concept:Concept {id: 'concept-zero-trust'}), (skill:Skill {id: 'skill-cloud-security-fundamentals'})
MERGE (skill)-[:BASED_ON]->(concept);

// ====================================================================================================
// SECTION 16: FINAL STATISTICS QUERY
// ====================================================================================================

// Query to verify the expansion
MATCH (s:Skill) 
WITH COUNT(s) as totalSkills
MATCH (c:Certification) 
WITH totalSkills, COUNT(c) as totalCerts
MATCH (r:Resource) 
WITH totalSkills, totalCerts, COUNT(r) as totalResources
MATCH (con:Concept)
WITH totalSkills, totalCerts, totalResources, COUNT(con) as totalConcepts
RETURN 
    '=== EXPANSION COMPLETE ===' AS Status,
    totalSkills AS TotalSkills,
    totalCerts AS TotalCertifications,
    totalResources AS TotalResources,
    totalConcepts AS TotalConcepts,
    CASE 
        WHEN totalSkills >= 200 THEN '✅ Successfully expanded to 200+ skills!' 
        ELSE '⚠️ Expansion incomplete' 
    END AS Result;

// ====================================================================================================
// END OF COMPREHENSIVE DATA EXPANSION
// ====================================================================================================

// ====================================================================================================
// SKILL PATH NAVIGATOR - DATA ISSUES FIX SCRIPT
// Version: 1.0 - Fixes for 60 identified data issues
// This script is idempotent and should be appended to the main expansion script
// ====================================================================================================

// ====================================================================================================
// FIX #1: CORRECTING INVALID DIFFICULTY LEVELS (9 skills)
// Changing "advanced" to "expert" for proper schema compliance
// ====================================================================================================

MATCH (s:Skill {id: 'skill-cassandra'})
SET s.difficulty_level = 'expert';

MATCH (s:Skill {id: 'skill-kafka'})
SET s.difficulty_level = 'expert';

MATCH (s:Skill {id: 'skill-istio'})
SET s.difficulty_level = 'expert';

MATCH (s:Skill {id: 'skill-computer-vision'})
SET s.difficulty_level = 'expert';

MATCH (s:Skill {id: 'skill-nlp'})
SET s.difficulty_level = 'expert';

MATCH (s:Skill {id: 'skill-flink'})
SET s.difficulty_level = 'expert';

MATCH (s:Skill {id: 'skill-beam'})
SET s.difficulty_level = 'expert';

MATCH (s:Skill {id: 'skill-cpp'})
SET s.difficulty_level = 'expert';

MATCH (s:Skill {id: 'skill-scala'})
SET s.difficulty_level = 'expert';

// ====================================================================================================
// FIX #2: ADDING MISSING PREREQUISITES (25 skills)
// ====================================================================================================

// Pulumi - requires programming and cloud basics
MATCH (pulumi:Skill {id: 'skill-pulumi'}), (ts:Skill {id: 'skill-typescript'})
MERGE (pulumi)-[:REQUIRES {priority: 1, type: 'soft'}]->(ts);

MATCH (pulumi:Skill {id: 'skill-pulumi'}), (aws:Skill {id: 'skill-aws-fundamentals'})
MERGE (pulumi)-[:REQUIRES {priority: 2, type: 'soft'}]->(aws);

// Flutter - requires Dart (creating Dart first)
MERGE (dart:Skill {id: 'skill-dart'})
ON CREATE SET
    dart.name = 'Dart',
    dart.difficulty_level = 'beginner',
    dart.estimated_hours = 40,
    dart.demand_score = 6,
    dart.category = 'programming',
    dart.prereq_level = 1;

MATCH (fund:SubDomain {id: 'sub-sw-fundamentals'}), (dart:Skill {id: 'skill-dart'})
MERGE (fund)-[:CONTAINS]->(dart);

MATCH (flutter:Skill {id: 'skill-flutter'}), (dart:Skill {id: 'skill-dart'})
MERGE (flutter)-[:REQUIRES {priority: 1, type: 'hard'}]->(dart);

// TCP/IP - requires network fundamentals
MATCH (tcpip:Skill {id: 'skill-tcp-ip'}), (net:Skill {id: 'skill-network-fundamentals'})
MERGE (tcpip)-[:REQUIRES {priority: 1, type: 'hard'}]->(net);

// Load Balancing - requires network fundamentals
MATCH (lb:Skill {id: 'skill-load-balancing'}), (net:Skill {id: 'skill-network-fundamentals'})
MERGE (lb)-[:REQUIRES {priority: 1, type: 'hard'}]->(net);

MATCH (lb:Skill {id: 'skill-load-balancing'}), (tcpip:Skill {id: 'skill-tcp-ip'})
MERGE (lb)-[:REQUIRES {priority: 2, type: 'soft'}]->(tcpip);

// API Security - requires API design
MATCH (apisec:Skill {id: 'skill-api-security'}), (api:Skill {id: 'skill-api-design'})
MERGE (apisec)-[:REQUIRES {priority: 1, type: 'hard'}]->(api);

// OAuth - requires API security
MATCH (oauth:Skill {id: 'skill-oauth'}), (apisec:Skill {id: 'skill-api-security'})
MERGE (oauth)-[:REQUIRES {priority: 1, type: 'soft'}]->(apisec);

// SAST - requires programming and security fundamentals
MATCH (sast:Skill {id: 'skill-sast'}), (git:Skill {id: 'skill-git'})
MERGE (sast)-[:REQUIRES {priority: 1, type: 'soft'}]->(git);

MATCH (sast:Skill {id: 'skill-sast'}), (cloud_sec:Skill {id: 'skill-cloud-security-fundamentals'})
MERGE (sast)-[:REQUIRES {priority: 2, type: 'soft'}]->(cloud_sec);

// DAST - requires web basics and security fundamentals
MATCH (dast:Skill {id: 'skill-dast'}), (api:Skill {id: 'skill-api-design'})
MERGE (dast)-[:REQUIRES {priority: 1, type: 'soft'}]->(api);

MATCH (dast:Skill {id: 'skill-dast'}), (cloud_sec:Skill {id: 'skill-cloud-security-fundamentals'})
MERGE (dast)-[:REQUIRES {priority: 2, type: 'soft'}]->(cloud_sec);

// GCP Cloud Functions - requires GCP fundamentals
MATCH (gcf:Skill {id: 'skill-gcp-cloud-functions'}), (gcp:Skill {id: 'skill-gcp-fundamentals'})
MERGE (gcf)-[:REQUIRES {priority: 1, type: 'hard'}]->(gcp);

// Vertex AI - requires ML basics and GCP fundamentals
MATCH (vertex:Skill {id: 'skill-gcp-vertex-ai'}), (ml:Skill {id: 'skill-ml-basics'})
MERGE (vertex)-[:REQUIRES {priority: 1, type: 'hard'}]->(ml);

MATCH (vertex:Skill {id: 'skill-gcp-vertex-ai'}), (gcp:Skill {id: 'skill-gcp-fundamentals'})
MERGE (vertex)-[:REQUIRES {priority: 2, type: 'hard'}]->(gcp);

// XGBoost - requires ML basics and Python
MATCH (xgb:Skill {id: 'skill-xgboost'}), (ml:Skill {id: 'skill-ml-basics'})
MERGE (xgb)-[:REQUIRES {priority: 1, type: 'hard'}]->(ml);

MATCH (xgb:Skill {id: 'skill-xgboost'}), (python:Skill {id: 'skill-python'})
MERGE (xgb)-[:REQUIRES {priority: 2, type: 'hard'}]->(python);

// CUDA Programming - requires C++ and GPU concepts
MATCH (cuda:Skill {id: 'skill-cuda'}), (cpp:Skill {id: 'skill-cpp'})
MERGE (cuda)-[:REQUIRES {priority: 1, type: 'hard'}]->(cpp);

MATCH (cuda:Skill {id: 'skill-cuda'}), (dl:Skill {id: 'skill-deep-learning'})
MERGE (cuda)-[:REQUIRES {priority: 2, type: 'soft'}]->(dl);

// Looker - requires SQL and data viz basics
MATCH (looker:Skill {id: 'skill-looker'}), (sql:Skill {id: 'skill-sql'})
MERGE (looker)-[:REQUIRES {priority: 1, type: 'hard'}]->(sql);

// Swift - requires programming fundamentals (using Git as proxy for basic programming knowledge)
MATCH (swift:Skill {id: 'skill-swift'}), (git:Skill {id: 'skill-git'})
MERGE (swift)-[:REQUIRES {priority: 1, type: 'soft'}]->(git);

// C# - requires OOP fundamentals (using Git as proxy for basic programming knowledge)
MATCH (csharp:Skill {id: 'skill-csharp'}), (git:Skill {id: 'skill-git'})
MERGE (csharp)-[:REQUIRES {priority: 1, type: 'soft'}]->(git);

// ====================================================================================================
// FIX #3: CONNECTING CERTIFICATIONS TO SKILLS (11 certifications)
// ====================================================================================================

// AWS Data Engineer Associate - create AWS data services skill and connect
MERGE (aws_data_services:Skill {id: 'skill-aws-data-services'})
ON CREATE SET
    aws_data_services.name = 'AWS Data Services (Glue, EMR, Athena)',
    aws_data_services.difficulty_level = 'intermediate',
    aws_data_services.estimated_hours = 60,
    aws_data_services.demand_score = 8,
    aws_data_services.category = 'aws',
    aws_data_services.prereq_level = 2;

MATCH (aws_sub:SubDomain {id: 'sub-aws'}), (aws_data:Skill {id: 'skill-aws-data-services'})
MERGE (aws_sub)-[:CONTAINS]->(aws_data);

MATCH (aws_data:Skill {id: 'skill-aws-data-services'}), (cert:Certification {id: 'cert-aws-data'})
MERGE (aws_data)-[:LEADS_TO]->(cert);

// AWS DevOps Professional - connect from CI/CD and AWS skills
MATCH (cicd:Skill {id: 'skill-cicd-pipelines'}), (cert:Certification {id: 'cert-aws-devops'})
MERGE (cicd)-[:LEADS_TO]->(cert);

// AWS ML Specialty - create SageMaker skill and connect
MERGE (sagemaker:Skill {id: 'skill-aws-sagemaker'})
ON CREATE SET
    sagemaker.name = 'AWS SageMaker',
    sagemaker.difficulty_level = 'intermediate',
    sagemaker.estimated_hours = 50,
    sagemaker.demand_score = 8,
    sagemaker.category = 'aws',
    sagemaker.prereq_level = 3;

MATCH (aws_sub:SubDomain {id: 'sub-aws'}), (sagemaker:Skill {id: 'skill-aws-sagemaker'})
MERGE (aws_sub)-[:CONTAINS]->(sagemaker);

MATCH (sagemaker:Skill {id: 'skill-aws-sagemaker'}), (ml:Skill {id: 'skill-ml-basics'})
MERGE (sagemaker)-[:REQUIRES {priority: 1, type: 'hard'}]->(ml);

MATCH (sagemaker:Skill {id: 'skill-aws-sagemaker'}), (cert:Certification {id: 'cert-aws-ml'})
MERGE (sagemaker)-[:LEADS_TO]->(cert);

// Azure Data Engineer Associate - create Azure data services skill
MERGE (azure_data_services:Skill {id: 'skill-azure-data-services'})
ON CREATE SET
    azure_data_services.name = 'Azure Data Services (Data Factory, Synapse)',
    azure_data_services.difficulty_level = 'intermediate',
    azure_data_services.estimated_hours = 60,
    azure_data_services.demand_score = 7,
    azure_data_services.category = 'azure',
    azure_data_services.prereq_level = 2;

MATCH (azure_sub:SubDomain {id: 'sub-azure'}), (azure_data:Skill {id: 'skill-azure-data-services'})
MERGE (azure_sub)-[:CONTAINS]->(azure_data);

MATCH (azure_data:Skill {id: 'skill-azure-data-services'}), (cert:Certification {id: 'cert-dp-203'})
MERGE (azure_data)-[:LEADS_TO]->(cert);

// Azure Data Scientist Associate - connect from Azure ML
MATCH (azure_ml:Skill {id: 'skill-azure-ml'}), (cert:Certification {id: 'cert-dp-100'})
MERGE (azure_ml)-[:LEADS_TO]->(cert);

// Databricks Professional - connect from existing Databricks skill
MATCH (databricks:Skill {id: 'skill-databricks'}), (cert:Certification {id: 'cert-databricks-de-pro'})
MERGE (databricks)-[:LEADS_TO]->(cert);

// GCP Professional Cloud Architect - connect from GCP skills
MATCH (gcp_compute:Skill {id: 'skill-gcp-compute'}), (cert:Certification {id: 'cert-gcp-pca'})
MERGE (gcp_compute)-[:LEADS_TO]->(cert);

// GCP Professional Data Engineer - connect from BigQuery
MATCH (bigquery:Skill {id: 'skill-bigquery'}), (cert:Certification {id: 'cert-gcp-pde'})
MERGE (bigquery)-[:LEADS_TO]->(cert);

// HashiCorp Vault Operations Professional - connect from Vault skill
MATCH (vault:Skill {id: 'skill-vault'}), (cert:Certification {id: 'cert-vault-pro'})
MERGE (vault)-[:LEADS_TO]->(cert);

// Kubernetes and Cloud Native Associate - connect from Kubernetes
MATCH (k8s:Skill {id: 'skill-kubernetes'}), (cert:Certification {id: 'cert-kcna'})
MERGE (k8s)-[:LEADS_TO]->(cert);

// SnowPro Advanced Data Engineer - connect from Snowflake
MATCH (snowflake:Skill {id: 'skill-snowflake'}), (cert:Certification {id: 'cert-snowpro-de'})
MERGE (snowflake)-[:LEADS_TO]->(cert);

// ====================================================================================================
// FIX #4: ADDING MISSING RESOURCES (15 skills)
// ====================================================================================================

// Sass/SCSS Resources
MERGE (sass_docs:Resource {id: 'res-sass-docs'})
ON CREATE SET
    sass_docs.title = 'Sass Documentation',
    sass_docs.type = 'documentation',
    sass_docs.url = 'https://sass-lang.com/documentation',
    sass_docs.provider = 'Sass',
    sass_docs.cost = 0,
    sass_docs.rating = 4.7;

MERGE (sass_guide:Resource {id: 'res-sass-guide'})
ON CREATE SET
    sass_guide.title = 'The Sass Way',
    sass_guide.type = 'guide',
    sass_guide.url = 'http://thesassway.com/',
    sass_guide.provider = 'Community',
    sass_guide.cost = 0,
    sass_guide.rating = 4.5;

MATCH (sass:Skill {id: 'skill-sass'}), (res1:Resource {id: 'res-sass-docs'})
MERGE (sass)-[:HAS_RESOURCE]->(res1);

MATCH (sass:Skill {id: 'skill-sass'}), (res2:Resource {id: 'res-sass-guide'})
MERGE (sass)-[:HAS_RESOURCE]->(res2);

// Ruby on Rails Resources
MERGE (rails_guides:Resource {id: 'res-rails-guides'})
ON CREATE SET
    rails_guides.title = 'Ruby on Rails Guides',
    rails_guides.type = 'documentation',
    rails_guides.url = 'https://guides.rubyonrails.org/',
    rails_guides.provider = 'Rails',
    rails_guides.cost = 0,
    rails_guides.rating = 4.8;

MERGE (rails_tutorial:Resource {id: 'res-rails-tutorial'})
ON CREATE SET
    rails_tutorial.title = 'Ruby on Rails Tutorial',
    rails_tutorial.type = 'book',
    rails_tutorial.url = 'https://www.railstutorial.org/',
    rails_tutorial.provider = 'Michael Hartl',
    rails_tutorial.cost = 0,
    rails_tutorial.rating = 4.9;

MATCH (rails:Skill {id: 'skill-rails'}), (res1:Resource {id: 'res-rails-guides'})
MERGE (rails)-[:HAS_RESOURCE]->(res1);

MATCH (rails:Skill {id: 'skill-rails'}), (res2:Resource {id: 'res-rails-tutorial'})
MERGE (rails)-[:HAS_RESOURCE]->(res2);

// Cassandra Resources
MERGE (cassandra_docs:Resource {id: 'res-cassandra-docs'})
ON CREATE SET
    cassandra_docs.title = 'Apache Cassandra Documentation',
    cassandra_docs.type = 'documentation',
    cassandra_docs.url = 'https://cassandra.apache.org/doc/latest/',
    cassandra_docs.provider = 'Apache',
    cassandra_docs.cost = 0,
    cassandra_docs.rating = 4.5;

MERGE (cassandra_datastax:Resource {id: 'res-cassandra-datastax'})
ON CREATE SET
    cassandra_datastax.title = 'DataStax Cassandra Academy',
    cassandra_datastax.type = 'course',
    cassandra_datastax.url = 'https://www.datastax.com/learn',
    cassandra_datastax.provider = 'DataStax',
    cassandra_datastax.cost = 0,
    cassandra_datastax.rating = 4.7;

MATCH (cassandra:Skill {id: 'skill-cassandra'}), (res1:Resource {id: 'res-cassandra-docs'})
MERGE (cassandra)-[:HAS_RESOURCE]->(res1);

MATCH (cassandra:Skill {id: 'skill-cassandra'}), (res2:Resource {id: 'res-cassandra-datastax'})
MERGE (cassandra)-[:HAS_RESOURCE]->(res2);

// Istio Resources
MERGE (istio_docs:Resource {id: 'res-istio-docs'})
ON CREATE SET
    istio_docs.title = 'Istio Documentation',
    istio_docs.type = 'documentation',
    istio_docs.url = 'https://istio.io/latest/docs/',
    istio_docs.provider = 'Istio',
    istio_docs.cost = 0,
    istio_docs.rating = 4.6;

MERGE (istio_mastery:Resource {id: 'res-istio-mastery'})
ON CREATE SET
    istio_mastery.title = 'Mastering Service Mesh',
    istio_mastery.type = 'book',
    istio_mastery.url = 'https://www.oreilly.com/library/view/mastering-service-mesh/9781492043782/',
    istio_mastery.provider = 'OReilly',
    istio_mastery.cost = 50,
    istio_mastery.rating = 4.5;

MATCH (istio:Skill {id: 'skill-istio'}), (res1:Resource {id: 'res-istio-docs'})
MERGE (istio)-[:HAS_RESOURCE]->(res1);

MATCH (istio:Skill {id: 'skill-istio'}), (res2:Resource {id: 'res-istio-mastery'})
MERGE (istio)-[:HAS_RESOURCE]->(res2);

// AWS CloudFormation Resources
MERGE (cloudformation_docs:Resource {id: 'res-cloudformation-docs'})
ON CREATE SET
    cloudformation_docs.title = 'AWS CloudFormation Documentation',
    cloudformation_docs.type = 'documentation',
    cloudformation_docs.url = 'https://docs.aws.amazon.com/cloudformation/',
    cloudformation_docs.provider = 'AWS',
    cloudformation_docs.cost = 0,
    cloudformation_docs.rating = 4.5;

MERGE (cloudformation_course:Resource {id: 'res-cloudformation-course'})
ON CREATE SET
    cloudformation_course.title = 'AWS CloudFormation Master Class',
    cloudformation_course.type = 'course',
    cloudformation_course.url = 'https://www.udemy.com/course/aws-cloudformation-master-class/',
    cloudformation_course.provider = 'Udemy',
    cloudformation_course.cost = 20,
    cloudformation_course.rating = 4.6;

MATCH (cf:Skill {id: 'skill-cloudformation'}), (res1:Resource {id: 'res-cloudformation-docs'})
MERGE (cf)-[:HAS_RESOURCE]->(res1);

MATCH (cf:Skill {id: 'skill-cloudformation'}), (res2:Resource {id: 'res-cloudformation-course'})
MERGE (cf)-[:HAS_RESOURCE]->(res2);

// TCP/IP Resources
MERGE (tcpip_guide:Resource {id: 'res-tcpip-guide'})
ON CREATE SET
    tcpip_guide.title = 'TCP/IP Illustrated',
    tcpip_guide.type = 'book',
    tcpip_guide.url = 'https://www.oreilly.com/library/view/tcpip-illustrated-volume/9780132808200/',
    tcpip_guide.provider = 'Addison-Wesley',
    tcpip_guide.cost = 60,
    tcpip_guide.rating = 4.8;

MERGE (tcpip_course:Resource {id: 'res-tcpip-course'})
ON CREATE SET
    tcpip_course.title = 'Computer Networking Course',
    tcpip_course.type = 'course',
    tcpip_course.url = 'https://www.coursera.org/learn/computer-networking',
    tcpip_course.provider = 'Coursera',
    tcpip_course.cost = 49,
    tcpip_course.rating = 4.7;

MATCH (tcpip:Skill {id: 'skill-tcp-ip'}), (res1:Resource {id: 'res-tcpip-guide'})
MERGE (tcpip)-[:HAS_RESOURCE]->(res1);

MATCH (tcpip:Skill {id: 'skill-tcp-ip'}), (res2:Resource {id: 'res-tcpip-course'})
MERGE (tcpip)-[:HAS_RESOURCE]->(res2);

// CUDA Resources
MERGE (cuda_docs:Resource {id: 'res-cuda-docs'})
ON CREATE SET
    cuda_docs.title = 'CUDA Programming Guide',
    cuda_docs.type = 'documentation',
    cuda_docs.url = 'https://docs.nvidia.com/cuda/cuda-c-programming-guide/',
    cuda_docs.provider = 'NVIDIA',
    cuda_docs.cost = 0,
    cuda_docs.rating = 4.7;

MERGE (cuda_course:Resource {id: 'res-cuda-course'})
ON CREATE SET
    cuda_course.title = 'Fundamentals of Accelerated Computing with CUDA',
    cuda_course.type = 'course',
    cuda_course.url = 'https://www.nvidia.com/en-us/training/instructor-led-workshops/fundamentals-of-accelerated-computing-with-cuda/',
    cuda_course.provider = 'NVIDIA',
    cuda_course.cost = 0,
    cuda_course.rating = 4.8;

MATCH (cuda:Skill {id: 'skill-cuda'}), (res1:Resource {id: 'res-cuda-docs'})
MERGE (cuda)-[:HAS_RESOURCE]->(res1);

MATCH (cuda:Skill {id: 'skill-cuda'}), (res2:Resource {id: 'res-cuda-course'})
MERGE (cuda)-[:HAS_RESOURCE]->(res2);

// Apache Flink Resources
MERGE (flink_docs:Resource {id: 'res-flink-docs'})
ON CREATE SET
    flink_docs.title = 'Apache Flink Documentation',
    flink_docs.type = 'documentation',
    flink_docs.url = 'https://flink.apache.org/docs/stable/',
    flink_docs.provider = 'Apache',
    flink_docs.cost = 0,
    flink_docs.rating = 4.5;

MERGE (flink_training:Resource {id: 'res-flink-training'})
ON CREATE SET
    flink_training.title = 'Flink Training Course',
    flink_training.type = 'course',
    flink_training.url = 'https://training.ververica.com/',
    flink_training.provider = 'Ververica',
    flink_training.cost = 0,
    flink_training.rating = 4.6;

MATCH (flink:Skill {id: 'skill-flink'}), (res1:Resource {id: 'res-flink-docs'})
MERGE (flink)-[:HAS_RESOURCE]->(res1);

MATCH (flink:Skill {id: 'skill-flink'}), (res2:Resource {id: 'res-flink-training'})
MERGE (flink)-[:HAS_RESOURCE]->(res2);

// Looker Resources
MERGE (looker_docs:Resource {id: 'res-looker-docs'})
ON CREATE SET
    looker_docs.title = 'Looker Documentation',
    looker_docs.type = 'documentation',
    looker_docs.url = 'https://cloud.google.com/looker/docs',
    looker_docs.provider = 'Google Cloud',
    looker_docs.cost = 0,
    looker_docs.rating = 4.5;

MERGE (looker_learning:Resource {id: 'res-looker-learning'})
ON CREATE SET
    looker_learning.title = 'Looker Learning Path',
    looker_learning.type = 'course',
    looker_learning.url = 'https://www.cloudskillsboost.google/paths/18',
    looker_learning.provider = 'Google Cloud Skills Boost',
    looker_learning.cost = 0,
    looker_learning.rating = 4.6;

MATCH (looker:Skill {id: 'skill-looker'}), (res1:Resource {id: 'res-looker-docs'})
MERGE (looker)-[:HAS_RESOURCE]->(res1);

MATCH (looker:Skill {id: 'skill-looker'}), (res2:Resource {id: 'res-looker-learning'})
MERGE (looker)-[:HAS_RESOURCE]->(res2);

// Scala Resources
MERGE (scala_docs:Resource {id: 'res-scala-docs'})
ON CREATE SET
    scala_docs.title = 'Scala Documentation',
    scala_docs.type = 'documentation',
    scala_docs.url = 'https://docs.scala-lang.org/',
    scala_docs.provider = 'Scala',
    scala_docs.cost = 0,
    scala_docs.rating = 4.6;

MERGE (scala_coursera:Resource {id: 'res-scala-coursera'})
ON CREATE SET
    scala_coursera.title = 'Functional Programming in Scala',
    scala_coursera.type = 'course',
    scala_coursera.url = 'https://www.coursera.org/specializations/scala',
    scala_coursera.provider = 'Coursera',
    scala_coursera.cost = 49,
    scala_coursera.rating = 4.8;

MATCH (scala:Skill {id: 'skill-scala'}), (res1:Resource {id: 'res-scala-docs'})
MERGE (scala)-[:HAS_RESOURCE]->(res1);

MATCH (scala:Skill {id: 'skill-scala'}), (res2:Resource {id: 'res-scala-coursera'})
MERGE (scala)-[:HAS_RESOURCE]->(res2);

// Julia Resources
MERGE (julia_docs:Resource {id: 'res-julia-docs'})
ON CREATE SET
    julia_docs.title = 'Julia Documentation',
    julia_docs.type = 'documentation',
    julia_docs.url = 'https://docs.julialang.org/',
    julia_docs.provider = 'Julia',
    julia_docs.cost = 0,
    julia_docs.rating = 4.7;

MERGE (julia_academy:Resource {id: 'res-julia-academy'})
ON CREATE SET
    julia_academy.title = 'Julia Academy',
    julia_academy.type = 'course',
    julia_academy.url = 'https://juliaacademy.com/',
    julia_academy.provider = 'Julia Computing',
    julia_academy.cost = 0,
    julia_academy.rating = 4.6;

MATCH (julia:Skill {id: 'skill-julia'}), (res1:Resource {id: 'res-julia-docs'})
MERGE (julia)-[:HAS_RESOURCE]->(res1);

MATCH (julia:Skill {id: 'skill-julia'}), (res2:Resource {id: 'res-julia-academy'})
MERGE (julia)-[:HAS_RESOURCE]->(res2);

// Elixir Resources
MERGE (elixir_docs:Resource {id: 'res-elixir-docs'})
ON CREATE SET
    elixir_docs.title = 'Elixir Documentation',
    elixir_docs.type = 'documentation',
    elixir_docs.url = 'https://elixir-lang.org/docs.html',
    elixir_docs.provider = 'Elixir',
    elixir_docs.cost = 0,
    elixir_docs.rating = 4.7;

MERGE (elixir_school:Resource {id: 'res-elixir-school'})
ON CREATE SET
    elixir_school.title = 'Elixir School',
    elixir_school.type = 'tutorial',
    elixir_school.url = 'https://elixirschool.com/',
    elixir_school.provider = 'Community',
    elixir_school.cost = 0,
    elixir_school.rating = 4.8;

MATCH (elixir:Skill {id: 'skill-elixir'}), (res1:Resource {id: 'res-elixir-docs'})
MERGE (elixir)-[:HAS_RESOURCE]->(res1);

MATCH (elixir:Skill {id: 'skill-elixir'}), (res2:Resource {id: 'res-elixir-school'})
MERGE (elixir)-[:HAS_RESOURCE]->(res2);

// HashiCorp Consul Resources
MERGE (consul_docs:Resource {id: 'res-consul-docs'})
ON CREATE SET
    consul_docs.title = 'Consul Documentation',
    consul_docs.type = 'documentation',
    consul_docs.url = 'https://developer.hashicorp.com/consul/docs',
    consul_docs.provider = 'HashiCorp',
    consul_docs.cost = 0,
    consul_docs.rating = 4.5;

MERGE (consul_tutorials:Resource {id: 'res-consul-tutorials'})
ON CREATE SET
    consul_tutorials.title = 'Consul Tutorials',
    consul_tutorials.type = 'tutorial',
    consul_tutorials.url = 'https://developer.hashicorp.com/consul/tutorials',
    consul_tutorials.provider = 'HashiCorp',
    consul_tutorials.cost = 0,
    consul_tutorials.rating = 4.6;

MATCH (consul:Skill {id: 'skill-consul'}), (res1:Resource {id: 'res-consul-docs'})
MERGE (consul)-[:HAS_RESOURCE]->(res1);

MATCH (consul:Skill {id: 'skill-consul'}), (res2:Resource {id: 'res-consul-tutorials'})
MERGE (consul)-[:HAS_RESOURCE]->(res2);

// Pulumi Resources
MERGE (pulumi_docs:Resource {id: 'res-pulumi-docs'})
ON CREATE SET
    pulumi_docs.title = 'Pulumi Documentation',
    pulumi_docs.type = 'documentation',
    pulumi_docs.url = 'https://www.pulumi.com/docs/',
    pulumi_docs.provider = 'Pulumi',
    pulumi_docs.cost = 0,
    pulumi_docs.rating = 4.6;

MERGE (pulumi_tutorials:Resource {id: 'res-pulumi-tutorials'})
ON CREATE SET
    pulumi_tutorials.title = 'Pulumi Tutorials',
    pulumi_tutorials.type = 'tutorial',
    pulumi_tutorials.url = 'https://www.pulumi.com/learn/',
    pulumi_tutorials.provider = 'Pulumi',
    pulumi_tutorials.cost = 0,
    pulumi_tutorials.rating = 4.7;

MATCH (pulumi:Skill {id: 'skill-pulumi'}), (res1:Resource {id: 'res-pulumi-docs'})
MERGE (pulumi)-[:HAS_RESOURCE]->(res1);

MATCH (pulumi:Skill {id: 'skill-pulumi'}), (res2:Resource {id: 'res-pulumi-tutorials'})
MERGE (pulumi)-[:HAS_RESOURCE]->(res2);

// Apache Beam Resources
MERGE (beam_docs:Resource {id: 'res-beam-docs'})
ON CREATE SET
    beam_docs.title = 'Apache Beam Documentation',
    beam_docs.type = 'documentation',
    beam_docs.url = 'https://beam.apache.org/documentation/',
    beam_docs.provider = 'Apache',
    beam_docs.cost = 0,
    beam_docs.rating = 4.5;

MERGE (beam_playground:Resource {id: 'res-beam-playground'})
ON CREATE SET
    beam_playground.title = 'Beam Playground',
    beam_playground.type = 'tutorial',
    beam_playground.url = 'https://play.beam.apache.org/',
    beam_playground.provider = 'Apache',
    beam_playground.cost = 0,
    beam_playground.rating = 4.6;

MATCH (beam:Skill {id: 'skill-beam'}), (res1:Resource {id: 'res-beam-docs'})
MERGE (beam)-[:HAS_RESOURCE]->(res1);

MATCH (beam:Skill {id: 'skill-beam'}), (res2:Resource {id: 'res-beam-playground'})
MERGE (beam)-[:HAS_RESOURCE]->(res2);

// ====================================================================================================
// FIX #5: ADDING RESOURCES FOR NEWLY CREATED SKILLS
// ====================================================================================================

// Dart Resources (for Flutter prerequisite)
MERGE (dart_docs:Resource {id: 'res-dart-docs'})
ON CREATE SET
    dart_docs.title = 'Dart Language Tour',
    dart_docs.type = 'documentation',
    dart_docs.url = 'https://dart.dev/language',
    dart_docs.provider = 'Dart',
    dart_docs.cost = 0,
    dart_docs.rating = 4.7;

MATCH (dart:Skill {id: 'skill-dart'}), (res:Resource {id: 'res-dart-docs'})
MERGE (dart)-[:HAS_RESOURCE]->(res);

// AWS Data Services Resources
MERGE (aws_data_docs:Resource {id: 'res-aws-data-docs'})
ON CREATE SET
    aws_data_docs.title = 'AWS Analytics Services Overview',
    aws_data_docs.type = 'documentation',
    aws_data_docs.url = 'https://aws.amazon.com/big-data/datalakes-and-analytics/',
    aws_data_docs.provider = 'AWS',
    aws_data_docs.cost = 0,
    aws_data_docs.rating = 4.6;

MATCH (aws_data:Skill {id: 'skill-aws-data-services'}), (res:Resource {id: 'res-aws-data-docs'})
MERGE (aws_data)-[:HAS_RESOURCE]->(res);

// AWS SageMaker Resources
MERGE (sagemaker_docs:Resource {id: 'res-sagemaker-docs'})
ON CREATE SET
    sagemaker_docs.title = 'Amazon SageMaker Documentation',
    sagemaker_docs.type = 'documentation',
    sagemaker_docs.url = 'https://docs.aws.amazon.com/sagemaker/',
    sagemaker_docs.provider = 'AWS',
    sagemaker_docs.cost = 0,
    sagemaker_docs.rating = 4.7;

MATCH (sagemaker:Skill {id: 'skill-aws-sagemaker'}), (res:Resource {id: 'res-sagemaker-docs'})
MERGE (sagemaker)-[:HAS_RESOURCE]->(res);

// Azure Data Services Resources
MERGE (azure_data_docs:Resource {id: 'res-azure-data-docs'})
ON CREATE SET
    azure_data_docs.title = 'Azure Data Factory Documentation',
    azure_data_docs.type = 'documentation',
    azure_data_docs.url = 'https://learn.microsoft.com/azure/data-factory/',
    azure_data_docs.provider = 'Microsoft',
    azure_data_docs.cost = 0,
    azure_data_docs.rating = 4.5;

MATCH (azure_data:Skill {id: 'skill-azure-data-services'}), (res:Resource {id: 'res-azure-data-docs'})
MERGE (azure_data)-[:HAS_RESOURCE]->(res);


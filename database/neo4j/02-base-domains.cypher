// ========================================
// SKILL PATH NAVIGATOR - BASE DOMAINS & SETUP
// ========================================
// Run this AFTER schema script, BEFORE domain-specific scripts
// Creates all domains and core cross-domain skills

// ========================================
// 1. CREATE ALL DOMAINS
// ========================================

CREATE (ai:Domain {
    id: 'domain-ai-ml',
    name: 'AI & Machine Learning',
    description: 'Artificial Intelligence, Machine Learning, Deep Learning, and Generative AI',
    color: '#FF6B6B',
    icon: 'brain',
    market_growth: 'explosive',
    avg_salary_range: '$120k-$250k',
    priority: 1
});

CREATE (cloud:Domain {
    id: 'domain-cloud',
    name: 'Cloud & Infrastructure',
    description: 'AWS, Azure, GCP, Multi-cloud Architecture, and Cloud Native Technologies',
    color: '#4ECDC4',
    icon: 'cloud',
    market_growth: 'high',
    avg_salary_range: '$110k-$200k',
    priority: 2
});

CREATE (devops:Domain {
    id: 'domain-devops',
    name: 'DevOps & Platform Engineering',
    description: 'CI/CD, Infrastructure as Code, Platform Engineering, Developer Experience',
    color: '#95E77E',
    icon: 'infinity',
    market_growth: 'high',
    avg_salary_range: '$115k-$190k',
    priority: 3
});

CREATE (sre:Domain {
    id: 'domain-sre',
    name: 'Site Reliability Engineering',
    description: 'Observability, Monitoring, Incident Management, Chaos Engineering',
    color: '#FFE66D',
    icon: 'activity',
    market_growth: 'high',
    avg_salary_range: '$125k-$210k',
    priority: 4
});

CREATE (data:Domain {
    id: 'domain-data',
    name: 'Data Engineering',
    description: 'Data Pipelines, ETL/ELT, Data Warehousing, Real-time Processing',
    color: '#A8E6CF',
    icon: 'database',
    market_growth: 'very-high',
    avg_salary_range: '$115k-$185k',
    priority: 5
});

CREATE (security:Domain {
    id: 'domain-security',
    name: 'Security & Compliance',
    description: 'Cloud Security, DevSecOps, Zero Trust, Compliance, Threat Modeling',
    color: '#C3AED6',
    icon: 'shield',
    market_growth: 'critical',
    avg_salary_range: '$120k-$200k',
    priority: 6
});

CREATE (software:Domain {
    id: 'domain-software',
    name: 'Software Engineering',
    description: 'Backend, Frontend, Full-Stack, Mobile Development',
    color: '#FDD5B1',
    icon: 'code',
    market_growth: 'steady',
    avg_salary_range: '$100k-$180k',
    priority: 7
});

// ========================================
// 2. CREATE CORE BRIDGE SKILLS
// ========================================
// These skills span multiple domains and should be loaded first

// Python - THE universal bridge skill
CREATE (python:Skill {
    id: 'skill-python',
    name: 'Python',
    description: 'General-purpose programming language essential for AI/ML, Data, DevOps, and automation',
    difficulty_level: 'beginner',
    estimated_hours: 100,
    demand_score: 10,
    category: 'programming',
    is_bridge_skill: true,
    market_insights: 'Most in-demand programming language for 2024-2025',
    last_updated: date('2025-01-15')
});

// SQL - Data bridge skill
CREATE (sql:Skill {
    id: 'skill-sql',
    name: 'SQL',
    description: 'Database querying, optimization, data manipulation - essential for all data work',
    difficulty_level: 'beginner',
    estimated_hours: 40,
    demand_score: 10,
    category: 'data',
    is_bridge_skill: true,
    market_insights: 'Required for nearly all data and backend roles',
    last_updated: date('2025-01-15')
});

// Git - Universal version control
CREATE (git:Skill {
    id: 'skill-git',
    name: 'Git',
    description: 'Version control, branching, merging, collaboration - required for all development',
    difficulty_level: 'beginner',
    estimated_hours: 20,
    demand_score: 10,
    category: 'devops',
    is_bridge_skill: true,
    market_insights: 'Non-negotiable skill for any technical role',
    last_updated: date('2025-01-15')
});

// Docker - Containerization bridge
CREATE (docker:Skill {
    id: 'skill-docker',
    name: 'Docker',
    description: 'Containerization, Dockerfiles, Docker Compose - foundation for cloud-native',
    difficulty_level: 'beginner',
    estimated_hours: 30,
    demand_score: 9,
    category: 'cloud-native',
    is_bridge_skill: true,
    market_insights: 'Essential for modern application deployment',
    last_updated: date('2025-01-15')
});

// Kubernetes - Orchestration bridge
CREATE (kubernetes:Skill {
    id: 'skill-kubernetes',
    name: 'Kubernetes',
    description: 'Container orchestration, deployments, services, scaling - the cloud-native standard',
    difficulty_level: 'intermediate',
    estimated_hours: 80,
    demand_score: 10,
    category: 'cloud-native',
    is_bridge_skill: true,
    market_insights: 'Most sought-after DevOps/Cloud skill in 2025',
    last_updated: date('2025-01-15')
});

// Terraform - IaC bridge
CREATE (terraform:Skill {
    id: 'skill-terraform',
    name: 'Terraform',
    description: 'Infrastructure as Code, multi-cloud provisioning - cloud agnostic IaC',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 9,
    category: 'iac',
    is_bridge_skill: true,
    market_insights: 'Leading IaC tool, vendor-neutral',
    last_updated: date('2025-01-15')
});

// Linux - System foundation
CREATE (linux:Skill {
    id: 'skill-linux',
    name: 'Linux',
    description: 'Linux administration, shell scripting, system management',
    difficulty_level: 'beginner',
    estimated_hours: 50,
    demand_score: 9,
    category: 'systems',
    is_bridge_skill: true,
    market_insights: 'Foundation for cloud, DevOps, and SRE roles',
    last_updated: date('2025-01-15')
});

// ========================================
// 3. CREATE BRIDGE SKILL RESOURCES
// ========================================

// Python Resources
CREATE (python_crash:Resource {
    id: 'res-python-crash',
    title: 'Python Crash Course',
    url: 'https://nostarch.com/pythoncrashcourse2e',
    type: 'book',
    platform: 'No Starch Press',
    duration: '40 hours',
    rating: 4.7,
    price: 'paid',
    difficulty_level: 'beginner',
    learning_style: 'reading'
});

CREATE (python_udemy:Resource {
    id: 'res-python-udemy',
    title: '100 Days of Code - Python Bootcamp',
    url: 'https://www.udemy.com/course/100-days-of-code/',
    type: 'video',
    platform: 'Udemy',
    duration: '60 hours',
    rating: 4.7,
    price: 'paid',
    difficulty_level: 'beginner',
    learning_style: 'visual'
});

CREATE (python_docs:Resource {
    id: 'res-python-docs',
    title: 'Official Python Documentation',
    url: 'https://docs.python.org/3/',
    type: 'doc',
    platform: 'Python.org',
    duration: 'self-paced',
    rating: 5.0,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

// Git Resources
CREATE (git_docs:Resource {
    id: 'res-git-docs',
    title: 'Pro Git Book',
    url: 'https://git-scm.com/book',
    type: 'book',
    platform: 'Git SCM',
    duration: '20 hours',
    rating: 4.8,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'reading'
});

CREATE (git_game:Resource {
    id: 'res-git-game',
    title: 'Oh My Git! - Visual Git Learning',
    url: 'https://ohmygit.org/',
    type: 'interactive',
    platform: 'Oh My Git',
    duration: '5 hours',
    rating: 4.6,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'hands-on'
});

// Docker Resources
CREATE (docker_docs:Resource {
    id: 'res-docker-docs',
    title: 'Docker Official Documentation',
    url: 'https://docs.docker.com/',
    type: 'doc',
    platform: 'Docker',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (docker_nana:Resource {
    id: 'res-docker-nana',
    title: 'Docker Tutorial for Beginners',
    url: 'https://www.youtube.com/watch?v=3c-iBn73dDE',
    type: 'video',
    platform: 'YouTube - TechWorld with Nana',
    duration: '3 hours',
    rating: 4.8,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'visual'
});

// Kubernetes Resources  
CREATE (k8s_docs:Resource {
    id: 'res-k8s-docs',
    title: 'Kubernetes Official Documentation',
    url: 'https://kubernetes.io/docs/',
    type: 'doc',
    platform: 'Kubernetes.io',
    duration: 'self-paced',
    rating: 5.0,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (k8s_kodekloud:Resource {
    id: 'res-k8s-kodekloud',
    title: 'Kubernetes for Beginners',
    url: 'https://kodekloud.com/courses/kubernetes-for-beginners/',
    type: 'video',
    platform: 'KodeKloud',
    duration: '6 hours',
    rating: 4.8,
    price: 'paid',
    difficulty_level: 'beginner',
    learning_style: 'visual'
});

// Terraform Resources
CREATE (terraform_docs:Resource {
    id: 'res-terraform-docs',
    title: 'Terraform Documentation',
    url: 'https://www.terraform.io/docs',
    type: 'doc',
    platform: 'HashiCorp',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (terraform_freecodecamp:Resource {
    id: 'res-terraform-fcc',
    title: 'Terraform Course - Automate AWS',
    url: 'https://www.youtube.com/watch?v=SLB_c_ayRMo',
    type: 'video',
    platform: 'freeCodeCamp',
    duration: '2.5 hours',
    rating: 4.7,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'visual'
});

// SQL Resources
CREATE (sql_zoo:Resource {
    id: 'res-sql-zoo',
    title: 'SQLZoo Interactive Tutorial',
    url: 'https://sqlzoo.net/',
    type: 'interactive',
    platform: 'SQLZoo',
    duration: '20 hours',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'hands-on'
});

CREATE (sql_bolt:Resource {
    id: 'res-sql-bolt',
    title: 'SQLBolt - Learn SQL interactively',
    url: 'https://sqlbolt.com/',
    type: 'interactive',
    platform: 'SQLBolt',
    duration: '10 hours',
    rating: 4.7,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'hands-on'
});

// Linux Resources
CREATE (linux_journey:Resource {
    id: 'res-linux-journey',
    title: 'Linux Journey',
    url: 'https://linuxjourney.com/',
    type: 'interactive',
    platform: 'Linux Journey',
    duration: '20 hours',
    rating: 4.6,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'hands-on'
});

// ========================================
// 4. CONNECT BRIDGE SKILLS TO RESOURCES
// ========================================

MATCH (python:Skill {id: 'skill-python'}), (python_crash:Resource {id: 'res-python-crash'})
CREATE (python)-[:HAS_RESOURCE]->(python_crash);

MATCH (python:Skill {id: 'skill-python'}), (python_udemy:Resource {id: 'res-python-udemy'})
CREATE (python)-[:HAS_RESOURCE]->(python_udemy);

MATCH (python:Skill {id: 'skill-python'}), (python_docs:Resource {id: 'res-python-docs'})
CREATE (python)-[:HAS_RESOURCE]->(python_docs);

MATCH (git:Skill {id: 'skill-git'}), (git_docs:Resource {id: 'res-git-docs'})
CREATE (git)-[:HAS_RESOURCE]->(git_docs);

MATCH (git:Skill {id: 'skill-git'}), (git_game:Resource {id: 'res-git-game'})
CREATE (git)-[:HAS_RESOURCE]->(git_game);

MATCH (docker:Skill {id: 'skill-docker'}), (docker_docs:Resource {id: 'res-docker-docs'})
CREATE (docker)-[:HAS_RESOURCE]->(docker_docs);

MATCH (docker:Skill {id: 'skill-docker'}), (docker_nana:Resource {id: 'res-docker-nana'})
CREATE (docker)-[:HAS_RESOURCE]->(docker_nana);

MATCH (kubernetes:Skill {id: 'skill-kubernetes'}), (k8s_docs:Resource {id: 'res-k8s-docs'})
CREATE (kubernetes)-[:HAS_RESOURCE]->(k8s_docs);

MATCH (kubernetes:Skill {id: 'skill-kubernetes'}), (k8s_kodekloud:Resource {id: 'res-k8s-kodekloud'})
CREATE (kubernetes)-[:HAS_RESOURCE]->(k8s_kodekloud);

MATCH (terraform:Skill {id: 'skill-terraform'}), (terraform_docs:Resource {id: 'res-terraform-docs'})
CREATE (terraform)-[:HAS_RESOURCE]->(terraform_docs);

MATCH (terraform:Skill {id: 'skill-terraform'}), (terraform_freecodecamp:Resource {id: 'res-terraform-fcc'})
CREATE (terraform)-[:HAS_RESOURCE]->(terraform_freecodecamp);

MATCH (sql:Skill {id: 'skill-sql'}), (sql_zoo:Resource {id: 'res-sql-zoo'})
CREATE (sql)-[:HAS_RESOURCE]->(sql_zoo);

MATCH (sql:Skill {id: 'skill-sql'}), (sql_bolt:Resource {id: 'res-sql-bolt'})
CREATE (sql)-[:HAS_RESOURCE]->(sql_bolt);

MATCH (linux:Skill {id: 'skill-linux'}), (linux_journey:Resource {id: 'res-linux-journey'})
CREATE (linux)-[:HAS_RESOURCE]->(linux_journey);

// ========================================
// 5. CONNECT BRIDGE SKILLS TO DOMAINS
// ========================================

// Python applies to multiple domains
MATCH (python:Skill {id: 'skill-python'}), (ai:Domain {id: 'domain-ai-ml'})
CREATE (python)-[:APPLIES_IN]->(ai);

MATCH (python:Skill {id: 'skill-python'}), (data:Domain {id: 'domain-data'})
CREATE (python)-[:APPLIES_IN]->(data);

MATCH (python:Skill {id: 'skill-python'}), (devops:Domain {id: 'domain-devops'})
CREATE (python)-[:APPLIES_IN]->(devops);

MATCH (python:Skill {id: 'skill-python'}), (software:Domain {id: 'domain-software'})
CREATE (python)-[:APPLIES_IN]->(software);

// SQL applies to data and software
MATCH (sql:Skill {id: 'skill-sql'}), (data:Domain {id: 'domain-data'})
CREATE (sql)-[:APPLIES_IN]->(data);

MATCH (sql:Skill {id: 'skill-sql'}), (software:Domain {id: 'domain-software'})
CREATE (sql)-[:APPLIES_IN]->(software);

// Git applies everywhere
MATCH (git:Skill {id: 'skill-git'}), (software:Domain {id: 'domain-software'})
CREATE (git)-[:APPLIES_IN]->(software);

MATCH (git:Skill {id: 'skill-git'}), (devops:Domain {id: 'domain-devops'})
CREATE (git)-[:APPLIES_IN]->(devops);

MATCH (git:Skill {id: 'skill-git'}), (data:Domain {id: 'domain-data'})
CREATE (git)-[:APPLIES_IN]->(data);

// Docker and Kubernetes apply to cloud/devops/sre
MATCH (docker:Skill {id: 'skill-docker'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (docker)-[:APPLIES_IN]->(cloud);

MATCH (docker:Skill {id: 'skill-docker'}), (devops:Domain {id: 'domain-devops'})
CREATE (docker)-[:APPLIES_IN]->(devops);

MATCH (kubernetes:Skill {id: 'skill-kubernetes'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (kubernetes)-[:APPLIES_IN]->(cloud);

MATCH (kubernetes:Skill {id: 'skill-kubernetes'}), (devops:Domain {id: 'domain-devops'})
CREATE (kubernetes)-[:APPLIES_IN]->(devops);

MATCH (kubernetes:Skill {id: 'skill-kubernetes'}), (sre:Domain {id: 'domain-sre'})
CREATE (kubernetes)-[:APPLIES_IN]->(sre);

// Terraform applies to cloud and devops
MATCH (terraform:Skill {id: 'skill-terraform'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (terraform)-[:APPLIES_IN]->(cloud);

MATCH (terraform:Skill {id: 'skill-terraform'}), (devops:Domain {id: 'domain-devops'})
CREATE (terraform)-[:APPLIES_IN]->(devops);

// Linux applies to most technical domains
MATCH (linux:Skill {id: 'skill-linux'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (linux)-[:APPLIES_IN]->(cloud);

MATCH (linux:Skill {id: 'skill-linux'}), (devops:Domain {id: 'domain-devops'})
CREATE (linux)-[:APPLIES_IN]->(devops);

MATCH (linux:Skill {id: 'skill-linux'}), (sre:Domain {id: 'domain-sre'})
CREATE (linux)-[:APPLIES_IN]->(sre);

// ========================================
// 6. CREATE CORE SKILL PROGRESSIONS
// ========================================

// Docker -> Kubernetes is a fundamental progression
MATCH (docker:Skill {id: 'skill-docker'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (docker)-[:LEADS_TO]->(kubernetes);

// Kubernetes requires Docker
MATCH (kubernetes:Skill {id: 'skill-kubernetes'}), (docker:Skill {id: 'skill-docker'})
CREATE (kubernetes)-[:REQUIRES]->(docker);

// Linux is prerequisite for many things
MATCH (docker:Skill {id: 'skill-docker'}), (linux:Skill {id: 'skill-linux'})
CREATE (docker)-[:REQUIRES]->(linux);

// ========================================
// VERIFICATION QUERY
// ========================================
// Run this to verify base setup:
// MATCH (d:Domain) RETURN d.name, d.id;
// MATCH (s:Skill {is_bridge_skill: true}) RETURN s.name, s.id;
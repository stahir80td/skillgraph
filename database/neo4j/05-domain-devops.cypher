// ========================================
// SKILL PATH NAVIGATOR - DEVOPS & PLATFORM ENGINEERING DOMAIN
// ========================================
// Run AFTER base domains script
// Creates complete DevOps skill tree with CI/CD, IaC, GitOps, and Platform Engineering

// ========================================
// 1. CREATE SUBDOMAINS
// ========================================

CREATE (cicd:SubDomain {
    id: 'sub-cicd',
    name: 'CI/CD & Automation',
    description: 'Continuous Integration, Deployment, and Delivery pipelines',
    order: 1
});

CREATE (iac:SubDomain {
    id: 'sub-iac',
    name: 'Infrastructure as Code',
    description: 'Terraform, Ansible, Pulumi - Managing infrastructure through code',
    order: 2
});

CREATE (gitops:SubDomain {
    id: 'sub-gitops',
    name: 'GitOps',
    description: 'Git-centric operational workflows, ArgoCD, Flux',
    order: 3
});

CREATE (platform_eng:SubDomain {
    id: 'sub-platform-eng',
    name: 'Platform Engineering',
    description: 'Internal Developer Platforms, Developer Experience - The evolution of DevOps',
    order: 4
});

CREATE (containers:SubDomain {
    id: 'sub-containers',
    name: 'Containerization & Orchestration',
    description: 'Docker, Kubernetes, Container registries',
    order: 5
});

// Connect to domain
MATCH (devops:Domain {id: 'domain-devops'}), (cicd:SubDomain {id: 'sub-cicd'})
CREATE (devops)-[:CONTAINS]->(cicd);

MATCH (devops:Domain {id: 'domain-devops'}), (iac:SubDomain {id: 'sub-iac'})
CREATE (devops)-[:CONTAINS]->(iac);

MATCH (devops:Domain {id: 'domain-devops'}), (gitops:SubDomain {id: 'sub-gitops'})
CREATE (devops)-[:CONTAINS]->(gitops);

MATCH (devops:Domain {id: 'domain-devops'}), (platform_eng:SubDomain {id: 'sub-platform-eng'})
CREATE (devops)-[:CONTAINS]->(platform_eng);

MATCH (devops:Domain {id: 'domain-devops'}), (containers:SubDomain {id: 'sub-containers'})
CREATE (devops)-[:CONTAINS]->(containers);

// ========================================
// 2. CREATE CI/CD SKILLS
// ========================================

CREATE (cicd_pipelines:Skill {
    id: 'skill-cicd-pipelines',
    name: 'CI/CD Pipeline Design',
    description: 'Building automated build, test, and deployment pipelines',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 9,
    category: 'devops-cicd',
    market_insights: 'Core DevOps competency',
    last_updated: date('2025-01-15')
});

CREATE (jenkins:Skill {
    id: 'skill-jenkins',
    name: 'Jenkins',
    description: 'Open-source automation server, Jenkinsfile, plugins',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 7,
    category: 'devops-cicd',
    last_updated: date('2025-01-15')
});

CREATE (github_actions:Skill {
    id: 'skill-github-actions',
    name: 'GitHub Actions',
    description: 'GitHub native CI/CD, workflows, actions marketplace',
    difficulty_level: 'beginner',
    estimated_hours: 25,
    demand_score: 9,
    category: 'devops-cicd',
    market_insights: 'Rapidly growing adoption',
    last_updated: date('2025-01-15')
});

CREATE (gitlab_ci:Skill {
    id: 'skill-gitlab-ci',
    name: 'GitLab CI/CD',
    description: 'GitLab integrated CI/CD, .gitlab-ci.yml, runners',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'devops-cicd',
    last_updated: date('2025-01-15')
});

CREATE (circleci:Skill {
    id: 'skill-circleci',
    name: 'CircleCI',
    description: 'Cloud-native CI/CD platform, orbs, workflows',
    difficulty_level: 'intermediate',
    estimated_hours: 25,
    demand_score: 6,
    category: 'devops-cicd',
    last_updated: date('2025-01-15')
});

CREATE (azure_pipelines:Skill {
    id: 'skill-azure-pipelines',
    name: 'Azure Pipelines',
    description: 'Microsoft CI/CD, YAML pipelines, Azure DevOps integration',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'devops-cicd',
    last_updated: date('2025-01-15')
});

// ========================================
// 3. CREATE INFRASTRUCTURE AS CODE SKILLS
// ========================================

CREATE (ansible:Skill {
    id: 'skill-ansible',
    name: 'Ansible',
    description: 'Configuration management, playbooks, automation',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'devops-iac',
    last_updated: date('2025-01-15')
});

CREATE (pulumi:Skill {
    id: 'skill-pulumi',
    name: 'Pulumi',
    description: 'IaC using programming languages, cloud-native',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 6,
    category: 'devops-iac',
    market_insights: 'Growing alternative to Terraform',
    last_updated: date('2025-01-15')
});

CREATE (cloudformation:Skill {
    id: 'skill-cloudformation',
    name: 'AWS CloudFormation',
    description: 'AWS native IaC, templates, stacks',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 7,
    category: 'devops-iac',
    last_updated: date('2025-01-15')
});

CREATE (arm_templates:Skill {
    id: 'skill-arm-templates',
    name: 'ARM Templates/Bicep',
    description: 'Azure Resource Manager templates and Bicep language',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 6,
    category: 'devops-iac',
    last_updated: date('2025-01-15')
});

// ========================================
// 4. CREATE GITOPS SKILLS
// ========================================

CREATE (argocd:Skill {
    id: 'skill-argocd',
    name: 'ArgoCD',
    description: 'Kubernetes GitOps continuous delivery',
    difficulty_level: 'advanced',
    estimated_hours: 40,
    demand_score: 8,
    category: 'devops-gitops',
    market_insights: 'Leading GitOps tool',
    last_updated: date('2025-01-15')
});

CREATE (flux:Skill {
    id: 'skill-flux',
    name: 'Flux',
    description: 'GitOps for Kubernetes, automated deployments',
    difficulty_level: 'advanced',
    estimated_hours: 40,
    demand_score: 7,
    category: 'devops-gitops',
    last_updated: date('2025-01-15')
});

CREATE (gitops_practices:Skill {
    id: 'skill-gitops-practices',
    name: 'GitOps Practices',
    description: 'Git as source of truth, declarative infrastructure',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 8,
    category: 'devops-gitops',
    last_updated: date('2025-01-15')
});

// ========================================
// 5. CREATE PLATFORM ENGINEERING SKILLS
// ========================================

CREATE (backstage:Skill {
    id: 'skill-backstage',
    name: 'Backstage',
    description: 'Spotify\'s developer portal platform',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 7,
    category: 'platform-eng',
    market_insights: 'Leading IDP solution',
    last_updated: date('2025-01-15')
});

CREATE (crossplane:Skill {
    id: 'skill-crossplane',
    name: 'Crossplane',
    description: 'Cloud-native control plane, universal control plane',
    difficulty_level: 'advanced',
    estimated_hours: 50,
    demand_score: 6,
    category: 'platform-eng',
    last_updated: date('2025-01-15')
});

CREATE (port_io:Skill {
    id: 'skill-port-io',
    name: 'Port.io',
    description: 'Internal developer portal platform',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 5,
    category: 'platform-eng',
    last_updated: date('2025-01-15')
});

CREATE (platform_design:Skill {
    id: 'skill-platform-design',
    name: 'Platform Design & Architecture',
    description: 'Designing IDPs, golden paths, self-service platforms',
    difficulty_level: 'advanced',
    estimated_hours: 80,
    demand_score: 9,
    category: 'platform-eng',
    market_insights: 'Critical for Platform Engineers',
    last_updated: date('2025-01-15')
});

CREATE (developer_experience:Skill {
    id: 'skill-developer-experience',
    name: 'Developer Experience (DX)',
    description: 'Improving developer productivity, tooling, workflows',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'platform-eng',
    market_insights: 'Key focus area for 2025',
    last_updated: date('2025-01-15')
});

// ========================================
// 6. CREATE CONTAINER & ORCHESTRATION SKILLS
// ========================================

CREATE (container_security:Skill {
    id: 'skill-container-security',
    name: 'Container Security',
    description: 'Image scanning, runtime security, best practices',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'devops-containers',
    last_updated: date('2025-01-15')
});

CREATE (docker_compose:Skill {
    id: 'skill-docker-compose',
    name: 'Docker Compose',
    description: 'Multi-container applications, local development',
    difficulty_level: 'beginner',
    estimated_hours: 15,
    demand_score: 7,
    category: 'devops-containers',
    last_updated: date('2025-01-15')
});

CREATE (container_registries:Skill {
    id: 'skill-container-registries',
    name: 'Container Registries',
    description: 'Docker Hub, ECR, ACR, GCR, Harbor',
    difficulty_level: 'beginner',
    estimated_hours: 20,
    demand_score: 7,
    category: 'devops-containers',
    last_updated: date('2025-01-15')
});

// ========================================
// 7. CREATE MONITORING & LOGGING SKILLS (DevOps perspective)
// ========================================

CREATE (prometheus_devops:Skill {
    id: 'skill-prometheus-devops',
    name: 'Prometheus for DevOps',
    description: 'Metrics collection in CI/CD and deployments',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 7,
    category: 'devops-monitoring',
    last_updated: date('2025-01-15')
});

CREATE (logging_pipelines:Skill {
    id: 'skill-logging-pipelines',
    name: 'Logging Pipelines',
    description: 'Centralized logging, log aggregation in CI/CD',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'devops-monitoring',
    last_updated: date('2025-01-15')
});

// ========================================
// 8. CONNECT SKILLS TO SUBDOMAINS
// ========================================

// CI/CD connections
MATCH (cicd:SubDomain {id: 'sub-cicd'}), (cicd_pipelines:Skill {id: 'skill-cicd-pipelines'})
CREATE (cicd)-[:CONTAINS]->(cicd_pipelines);

MATCH (cicd:SubDomain {id: 'sub-cicd'}), (jenkins:Skill {id: 'skill-jenkins'})
CREATE (cicd)-[:CONTAINS]->(jenkins);

MATCH (cicd:SubDomain {id: 'sub-cicd'}), (github_actions:Skill {id: 'skill-github-actions'})
CREATE (cicd)-[:CONTAINS]->(github_actions);

MATCH (cicd:SubDomain {id: 'sub-cicd'}), (gitlab_ci:Skill {id: 'skill-gitlab-ci'})
CREATE (cicd)-[:CONTAINS]->(gitlab_ci);

MATCH (cicd:SubDomain {id: 'sub-cicd'}), (circleci:Skill {id: 'skill-circleci'})
CREATE (cicd)-[:CONTAINS]->(circleci);

MATCH (cicd:SubDomain {id: 'sub-cicd'}), (azure_pipelines:Skill {id: 'skill-azure-pipelines'})
CREATE (cicd)-[:CONTAINS]->(azure_pipelines);

// IaC connections
MATCH (iac:SubDomain {id: 'sub-iac'}), (ansible:Skill {id: 'skill-ansible'})
CREATE (iac)-[:CONTAINS]->(ansible);

MATCH (iac:SubDomain {id: 'sub-iac'}), (pulumi:Skill {id: 'skill-pulumi'})
CREATE (iac)-[:CONTAINS]->(pulumi);

MATCH (iac:SubDomain {id: 'sub-iac'}), (cloudformation:Skill {id: 'skill-cloudformation'})
CREATE (iac)-[:CONTAINS]->(cloudformation);

MATCH (iac:SubDomain {id: 'sub-iac'}), (arm_templates:Skill {id: 'skill-arm-templates'})
CREATE (iac)-[:CONTAINS]->(arm_templates);

// Note: Terraform is in base domains as a bridge skill, but also belongs to IaC
MATCH (iac:SubDomain {id: 'sub-iac'}), (terraform:Skill {id: 'skill-terraform'})
CREATE (iac)-[:CONTAINS]->(terraform);

// GitOps connections
MATCH (gitops:SubDomain {id: 'sub-gitops'}), (argocd:Skill {id: 'skill-argocd'})
CREATE (gitops)-[:CONTAINS]->(argocd);

MATCH (gitops:SubDomain {id: 'sub-gitops'}), (flux:Skill {id: 'skill-flux'})
CREATE (gitops)-[:CONTAINS]->(flux);

MATCH (gitops:SubDomain {id: 'sub-gitops'}), (gitops_practices:Skill {id: 'skill-gitops-practices'})
CREATE (gitops)-[:CONTAINS]->(gitops_practices);

// Platform Engineering connections
MATCH (platform_eng:SubDomain {id: 'sub-platform-eng'}), (backstage:Skill {id: 'skill-backstage'})
CREATE (platform_eng)-[:CONTAINS]->(backstage);

MATCH (platform_eng:SubDomain {id: 'sub-platform-eng'}), (crossplane:Skill {id: 'skill-crossplane'})
CREATE (platform_eng)-[:CONTAINS]->(crossplane);

MATCH (platform_eng:SubDomain {id: 'sub-platform-eng'}), (port_io:Skill {id: 'skill-port-io'})
CREATE (platform_eng)-[:CONTAINS]->(port_io);

MATCH (platform_eng:SubDomain {id: 'sub-platform-eng'}), (platform_design:Skill {id: 'skill-platform-design'})
CREATE (platform_eng)-[:CONTAINS]->(platform_design);

MATCH (platform_eng:SubDomain {id: 'sub-platform-eng'}), (developer_experience:Skill {id: 'skill-developer-experience'})
CREATE (platform_eng)-[:CONTAINS]->(developer_experience);

// Containers connections
MATCH (containers:SubDomain {id: 'sub-containers'}), (container_security:Skill {id: 'skill-container-security'})
CREATE (containers)-[:CONTAINS]->(container_security);

MATCH (containers:SubDomain {id: 'sub-containers'}), (docker_compose:Skill {id: 'skill-docker-compose'})
CREATE (containers)-[:CONTAINS]->(docker_compose);

MATCH (containers:SubDomain {id: 'sub-containers'}), (container_registries:Skill {id: 'skill-container-registries'})
CREATE (containers)-[:CONTAINS]->(container_registries);

// Note: Docker and Kubernetes are in base domains but also belong here
MATCH (containers:SubDomain {id: 'sub-containers'}), (docker:Skill {id: 'skill-docker'})
CREATE (containers)-[:CONTAINS]->(docker);

MATCH (containers:SubDomain {id: 'sub-containers'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (containers)-[:CONTAINS]->(kubernetes);

// ========================================
// 9. CREATE SKILL PREREQUISITES
// ========================================

// CI/CD prerequisites
MATCH (cicd_pipelines:Skill {id: 'skill-cicd-pipelines'}), (git:Skill {id: 'skill-git'})
CREATE (cicd_pipelines)-[:REQUIRES]->(git);

MATCH (github_actions:Skill {id: 'skill-github-actions'}), (git:Skill {id: 'skill-git'})
CREATE (github_actions)-[:REQUIRES]->(git);

MATCH (gitlab_ci:Skill {id: 'skill-gitlab-ci'}), (git:Skill {id: 'skill-git'})
CREATE (gitlab_ci)-[:REQUIRES]->(git);

MATCH (jenkins:Skill {id: 'skill-jenkins'}), (git:Skill {id: 'skill-git'})
CREATE (jenkins)-[:REQUIRES]->(git);

// IaC prerequisites
MATCH (ansible:Skill {id: 'skill-ansible'}), (linux:Skill {id: 'skill-linux'})
CREATE (ansible)-[:REQUIRES]->(linux);

MATCH (ansible:Skill {id: 'skill-ansible'}), (python:Skill {id: 'skill-python'})
CREATE (ansible)-[:REQUIRES]->(python);

MATCH (pulumi:Skill {id: 'skill-pulumi'}), (python:Skill {id: 'skill-python'})
CREATE (pulumi)-[:REQUIRES]->(python);

MATCH (cloudformation:Skill {id: 'skill-cloudformation'}), (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'})
WHERE exists((aws_fundamentals))
CREATE (cloudformation)-[:REQUIRES]->(aws_fundamentals);

MATCH (arm_templates:Skill {id: 'skill-arm-templates'}), (azure_fundamentals:Skill {id: 'skill-azure-fundamentals'})
WHERE exists((azure_fundamentals))
CREATE (arm_templates)-[:REQUIRES]->(azure_fundamentals);

// GitOps prerequisites
MATCH (argocd:Skill {id: 'skill-argocd'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (argocd)-[:REQUIRES]->(kubernetes);

MATCH (argocd:Skill {id: 'skill-argocd'}), (git:Skill {id: 'skill-git'})
CREATE (argocd)-[:REQUIRES]->(git);

MATCH (flux:Skill {id: 'skill-flux'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (flux)-[:REQUIRES]->(kubernetes);

MATCH (flux:Skill {id: 'skill-flux'}), (git:Skill {id: 'skill-git'})
CREATE (flux)-[:REQUIRES]->(git);

MATCH (gitops_practices:Skill {id: 'skill-gitops-practices'}), (git:Skill {id: 'skill-git'})
CREATE (gitops_practices)-[:REQUIRES]->(git);

// Platform Engineering prerequisites
MATCH (backstage:Skill {id: 'skill-backstage'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (backstage)-[:REQUIRES]->(kubernetes);

MATCH (crossplane:Skill {id: 'skill-crossplane'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (crossplane)-[:REQUIRES]->(kubernetes);

MATCH (platform_design:Skill {id: 'skill-platform-design'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (platform_design)-[:REQUIRES]->(kubernetes);

MATCH (platform_design:Skill {id: 'skill-platform-design'}), (cicd_pipelines:Skill {id: 'skill-cicd-pipelines'})
CREATE (platform_design)-[:REQUIRES]->(cicd_pipelines);

// Container prerequisites
MATCH (docker_compose:Skill {id: 'skill-docker-compose'}), (docker:Skill {id: 'skill-docker'})
CREATE (docker_compose)-[:REQUIRES]->(docker);

MATCH (container_security:Skill {id: 'skill-container-security'}), (docker:Skill {id: 'skill-docker'})
CREATE (container_security)-[:REQUIRES]->(docker);

MATCH (container_registries:Skill {id: 'skill-container-registries'}), (docker:Skill {id: 'skill-docker'})
CREATE (container_registries)-[:REQUIRES]->(docker);

// ========================================
// 10. CREATE SKILL PROGRESSIONS
// ========================================

MATCH (git:Skill {id: 'skill-git'}), (github_actions:Skill {id: 'skill-github-actions'})
CREATE (git)-[:LEADS_TO]->(github_actions);

MATCH (github_actions:Skill {id: 'skill-github-actions'}), (cicd_pipelines:Skill {id: 'skill-cicd-pipelines'})
CREATE (github_actions)-[:LEADS_TO]->(cicd_pipelines);

MATCH (docker:Skill {id: 'skill-docker'}), (docker_compose:Skill {id: 'skill-docker-compose'})
CREATE (docker)-[:LEADS_TO]->(docker_compose);

MATCH (cicd_pipelines:Skill {id: 'skill-cicd-pipelines'}), (gitops_practices:Skill {id: 'skill-gitops-practices'})
CREATE (cicd_pipelines)-[:LEADS_TO]->(gitops_practices);

MATCH (gitops_practices:Skill {id: 'skill-gitops-practices'}), (argocd:Skill {id: 'skill-argocd'})
CREATE (gitops_practices)-[:LEADS_TO]->(argocd);

MATCH (kubernetes:Skill {id: 'skill-kubernetes'}), (argocd:Skill {id: 'skill-argocd'})
CREATE (kubernetes)-[:LEADS_TO]->(argocd);

MATCH (terraform:Skill {id: 'skill-terraform'}), (pulumi:Skill {id: 'skill-pulumi'})
CREATE (terraform)-[:LEADS_TO]->(pulumi);

MATCH (developer_experience:Skill {id: 'skill-developer-experience'}), (platform_design:Skill {id: 'skill-platform-design'})
CREATE (developer_experience)-[:LEADS_TO]->(platform_design);

MATCH (platform_design:Skill {id: 'skill-platform-design'}), (backstage:Skill {id: 'skill-backstage'})
CREATE (platform_design)-[:LEADS_TO]->(backstage);

// ========================================
// 11. CREATE CERTIFICATIONS
// ========================================

CREATE (aws_devops:Certification {
    id: 'cert-aws-devops',
    name: 'AWS DevOps Engineer Professional',
    provider: 'AWS',
    level: 'professional',
    cost: 300,
    validity_period: '3 years',
    estimated_prep_hours: 120,
    difficulty_rating: 8,
    market_value: 'very-high',
    url: 'https://aws.amazon.com/certification/certified-devops-engineer-professional/',
    exam_format: 'Multiple choice, 180 minutes'
});

CREATE (az_400:Certification {
    id: 'cert-az-400',
    name: 'Azure DevOps Engineer Expert',
    provider: 'Microsoft',
    level: 'expert',
    cost: 165,
    validity_period: '1 year',
    estimated_prep_hours: 80,
    difficulty_rating: 7,
    market_value: 'very-high',
    url: 'https://learn.microsoft.com/certifications/devops-engineer/',
    exam_format: 'Multiple choice, 150 minutes'
});

CREATE (gcp_devops:Certification {
    id: 'cert-gcp-devops',
    name: 'Google Cloud Professional DevOps Engineer',
    provider: 'Google',
    level: 'professional',
    cost: 200,
    validity_period: '2 years',
    estimated_prep_hours: 100,
    difficulty_rating: 7,
    market_value: 'high',
    url: 'https://cloud.google.com/certification/cloud-devops-engineer',
    exam_format: 'Multiple choice, 120 minutes'
});

CREATE (terraform_associate:Certification {
    id: 'cert-terraform-associate',
    name: 'HashiCorp Terraform Associate',
    provider: 'HashiCorp',
    level: 'associate',
    cost: 70,
    validity_period: '2 years',
    estimated_prep_hours: 40,
    difficulty_rating: 5,
    market_value: 'high',
    url: 'https://www.hashicorp.com/certification/terraform-associate',
    exam_format: 'Multiple choice, 60 minutes'
});

CREATE (jenkins_engineer:Certification {
    id: 'cert-jenkins-engineer',
    name: 'Certified Jenkins Engineer',
    provider: 'CloudBees',
    level: 'professional',
    cost: 150,
    validity_period: '2 years',
    estimated_prep_hours: 40,
    difficulty_rating: 6,
    market_value: 'medium',
    url: 'https://www.cloudbees.com/jenkins/certification',
    exam_format: 'Multiple choice, 90 minutes'
});

CREATE (github_actions_cert:Certification {
    id: 'cert-github-actions',
    name: 'GitHub Actions Certification',
    provider: 'GitHub',
    level: 'associate',
    cost: 99,
    validity_period: '3 years',
    estimated_prep_hours: 30,
    difficulty_rating: 5,
    market_value: 'medium',
    url: 'https://examregistration.github.com/certification/actions',
    exam_format: 'Multiple choice, 120 minutes'
});

CREATE (cks:Certification {
    id: 'cert-cks',
    name: 'Certified Kubernetes Security Specialist',
    provider: 'CNCF',
    level: 'professional',
    cost: 395,
    validity_period: '2 years',
    estimated_prep_hours: 60,
    difficulty_rating: 8,
    market_value: 'very-high',
    url: 'https://www.cncf.io/certification/cks/',
    exam_format: 'Hands-on, 120 minutes'
});

// Connect certifications to skills
MATCH (aws_devops:Certification {id: 'cert-aws-devops'}), (cicd_pipelines:Skill {id: 'skill-cicd-pipelines'})
CREATE (aws_devops)-[:REQUIRES]->(cicd_pipelines);

MATCH (aws_devops:Certification {id: 'cert-aws-devops'}), (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'})
WHERE exists((aws_fundamentals))
CREATE (aws_devops)-[:REQUIRES]->(aws_fundamentals);

MATCH (az_400:Certification {id: 'cert-az-400'}), (azure_pipelines:Skill {id: 'skill-azure-pipelines'})
CREATE (az_400)-[:REQUIRES]->(azure_pipelines);

MATCH (gcp_devops:Certification {id: 'cert-gcp-devops'}), (gcp_fundamentals:Skill {id: 'skill-gcp-fundamentals'})
WHERE exists((gcp_fundamentals))
CREATE (gcp_devops)-[:REQUIRES]->(gcp_fundamentals);

MATCH (terraform_associate:Certification {id: 'cert-terraform-associate'}), (terraform:Skill {id: 'skill-terraform'})
CREATE (terraform_associate)-[:REQUIRES]->(terraform);

MATCH (jenkins_engineer:Certification {id: 'cert-jenkins-engineer'}), (jenkins:Skill {id: 'skill-jenkins'})
CREATE (jenkins_engineer)-[:REQUIRES]->(jenkins);

MATCH (github_actions_cert:Certification {id: 'cert-github-actions'}), (github_actions:Skill {id: 'skill-github-actions'})
CREATE (github_actions_cert)-[:REQUIRES]->(github_actions);

MATCH (cks:Certification {id: 'cert-cks'}), (container_security:Skill {id: 'skill-container-security'})
CREATE (cks)-[:REQUIRES]->(container_security);

MATCH (cks:Certification {id: 'cert-cks'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (cks)-[:REQUIRES]->(kubernetes);

// Certification progressions
MATCH (cka:Certification {id: 'cert-cka'}), (cks:Certification {id: 'cert-cks'})
WHERE exists((cka))
CREATE (cka)-[:LEADS_TO]->(cks);

MATCH (aws_saa:Certification {id: 'cert-aws-saa'}), (aws_devops:Certification {id: 'cert-aws-devops'})
WHERE exists((aws_saa))
CREATE (aws_saa)-[:LEADS_TO]->(aws_devops);

// Connect certifications to domain
MATCH (aws_devops:Certification {id: 'cert-aws-devops'}), (devops:Domain {id: 'domain-devops'})
CREATE (aws_devops)-[:RECOMMENDED_FOR]->(devops);

MATCH (az_400:Certification {id: 'cert-az-400'}), (devops:Domain {id: 'domain-devops'})
CREATE (az_400)-[:RECOMMENDED_FOR]->(devops);

MATCH (terraform_associate:Certification {id: 'cert-terraform-associate'}), (devops:Domain {id: 'domain-devops'})
CREATE (terraform_associate)-[:RECOMMENDED_FOR]->(devops);

// ========================================
// 12. CREATE RESOURCES
// ========================================

// CI/CD Resources
CREATE (jenkins_docs:Resource {
    id: 'res-jenkins-docs',
    title: 'Jenkins Documentation',
    url: 'https://www.jenkins.io/doc/',
    type: 'doc',
    platform: 'Jenkins',
    duration: 'self-paced',
    rating: 4.3,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (github_actions_docs:Resource {
    id: 'res-github-actions-docs',
    title: 'GitHub Actions Documentation',
    url: 'https://docs.github.com/actions',
    type: 'doc',
    platform: 'GitHub',
    duration: 'self-paced',
    rating: 4.6,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (github_actions_course:Resource {
    id: 'res-github-actions-course',
    title: 'GitHub Actions - The Complete Guide',
    url: 'https://www.udemy.com/course/github-actions-the-complete-guide/',
    type: 'video',
    platform: 'Udemy',
    duration: '9 hours',
    rating: 4.7,
    price: 'paid',
    difficulty_level: 'beginner',
    learning_style: 'visual'
});

// IaC Resources
CREATE (ansible_docs:Resource {
    id: 'res-ansible-docs',
    title: 'Ansible Documentation',
    url: 'https://docs.ansible.com/',
    type: 'doc',
    platform: 'Ansible',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (ansible_jeff:Resource {
    id: 'res-ansible-jeff',
    title: 'Ansible for DevOps by Jeff Geerling',
    url: 'https://www.ansiblefordevops.com/',
    type: 'book',
    platform: 'LeanPub',
    duration: '20 hours',
    rating: 4.8,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (pulumi_docs:Resource {
    id: 'res-pulumi-docs',
    title: 'Pulumi Documentation',
    url: 'https://www.pulumi.com/docs/',
    type: 'doc',
    platform: 'Pulumi',
    duration: 'self-paced',
    rating: 4.4,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

// GitOps Resources
CREATE (argocd_docs:Resource {
    id: 'res-argocd-docs',
    title: 'ArgoCD Documentation',
    url: 'https://argo-cd.readthedocs.io/',
    type: 'doc',
    platform: 'ArgoCD',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (gitops_toolkit:Resource {
    id: 'res-gitops-toolkit',
    title: 'GitOps Toolkit',
    url: 'https://fluxcd.io/flux/',
    type: 'doc',
    platform: 'Flux',
    duration: 'self-paced',
    rating: 4.4,
    price: 'free',
    difficulty_level: 'advanced',
    learning_style: 'reading'
});

// Platform Engineering Resources
CREATE (backstage_docs:Resource {
    id: 'res-backstage-docs',
    title: 'Backstage Documentation',
    url: 'https://backstage.io/docs/',
    type: 'doc',
    platform: 'Backstage',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (platform_eng_book:Resource {
    id: 'res-platform-eng-book',
    title: 'Platform Engineering on Kubernetes',
    url: 'https://www.manning.com/books/platform-engineering-on-kubernetes',
    type: 'book',
    platform: 'Manning',
    duration: '25 hours',
    rating: 4.7,
    price: 'paid',
    difficulty_level: 'advanced',
    learning_style: 'reading'
});

// DevOps General Resources
CREATE (devops_handbook:Resource {
    id: 'res-devops-handbook',
    title: 'The DevOps Handbook',
    url: 'https://itrevolution.com/the-devops-handbook/',
    type: 'book',
    platform: 'IT Revolution',
    duration: '20 hours',
    rating: 4.8,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (phoenix_project:Resource {
    id: 'res-phoenix-project',
    title: 'The Phoenix Project',
    url: 'https://itrevolution.com/the-phoenix-project/',
    type: 'book',
    platform: 'IT Revolution',
    duration: '12 hours',
    rating: 4.7,
    price: 'paid',
    difficulty_level: 'beginner',
    learning_style: 'reading'
});

// Connect resources to skills
MATCH (jenkins:Skill {id: 'skill-jenkins'}), (jenkins_docs:Resource {id: 'res-jenkins-docs'})
CREATE (jenkins)-[:HAS_RESOURCE]->(jenkins_docs);

MATCH (github_actions:Skill {id: 'skill-github-actions'}), (github_actions_docs:Resource {id: 'res-github-actions-docs'})
CREATE (github_actions)-[:HAS_RESOURCE]->(github_actions_docs);

MATCH (github_actions:Skill {id: 'skill-github-actions'}), (github_actions_course:Resource {id: 'res-github-actions-course'})
CREATE (github_actions)-[:HAS_RESOURCE]->(github_actions_course);

MATCH (ansible:Skill {id: 'skill-ansible'}), (ansible_docs:Resource {id: 'res-ansible-docs'})
CREATE (ansible)-[:HAS_RESOURCE]->(ansible_docs);

MATCH (ansible:Skill {id: 'skill-ansible'}), (ansible_jeff:Resource {id: 'res-ansible-jeff'})
CREATE (ansible)-[:HAS_RESOURCE]->(ansible_jeff);

MATCH (pulumi:Skill {id: 'skill-pulumi'}), (pulumi_docs:Resource {id: 'res-pulumi-docs'})
CREATE (pulumi)-[:HAS_RESOURCE]->(pulumi_docs);

MATCH (argocd:Skill {id: 'skill-argocd'}), (argocd_docs:Resource {id: 'res-argocd-docs'})
CREATE (argocd)-[:HAS_RESOURCE]->(argocd_docs);

MATCH (flux:Skill {id: 'skill-flux'}), (gitops_toolkit:Resource {id: 'res-gitops-toolkit'})
CREATE (flux)-[:HAS_RESOURCE]->(gitops_toolkit);

MATCH (backstage:Skill {id: 'skill-backstage'}), (backstage_docs:Resource {id: 'res-backstage-docs'})
CREATE (backstage)-[:HAS_RESOURCE]->(backstage_docs);

MATCH (platform_design:Skill {id: 'skill-platform-design'}), (platform_eng_book:Resource {id: 'res-platform-eng-book'})
CREATE (platform_design)-[:HAS_RESOURCE]->(platform_eng_book);

MATCH (cicd_pipelines:Skill {id: 'skill-cicd-pipelines'}), (devops_handbook:Resource {id: 'res-devops-handbook'})
CREATE (cicd_pipelines)-[:HAS_RESOURCE]->(devops_handbook);

MATCH (developer_experience:Skill {id: 'skill-developer-experience'}), (phoenix_project:Resource {id: 'res-phoenix-project'})
CREATE (developer_experience)-[:HAS_RESOURCE]->(phoenix_project);

// ========================================
// CROSS-DOMAIN RELATIONSHIPS
// ========================================

// Platform Engineering bridges to other domains
MATCH (platform_design:Skill {id: 'skill-platform-design'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (platform_design)-[:APPLIES_IN]->(cloud);

MATCH (platform_design:Skill {id: 'skill-platform-design'}), (sre:Domain {id: 'domain-sre'})
CREATE (platform_design)-[:APPLIES_IN]->(sre);

// GitOps bridges to SRE
MATCH (argocd:Skill {id: 'skill-argocd'}), (sre:Domain {id: 'domain-sre'})
CREATE (argocd)-[:APPLIES_IN]->(sre);

// Container security bridges to security domain
MATCH (container_security:Skill {id: 'skill-container-security'}), (security:Domain {id: 'domain-security'})
CREATE (container_security)-[:APPLIES_IN]->(security);

// ========================================
// VERIFICATION QUERY
// ========================================
// Run to verify DevOps domain is loaded:
// MATCH (d:Domain {id: 'domain-devops'})-[:CONTAINS]->(sd:SubDomain)-[:CONTAINS]->(s:Skill) 
// RETURN d.name, sd.name, count(s) as skill_count;
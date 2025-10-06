// ========================================
// SKILL PATH NAVIGATOR - SECURITY & COMPLIANCE DOMAIN
// ========================================
// Run AFTER base domains script
// Creates complete Security skill tree with DevSecOps, Cloud Security, and Compliance

// ========================================
// 1. CREATE SUBDOMAINS
// ========================================

CREATE (cloud_security:SubDomain {
    id: 'sub-cloud-security',
    name: 'Cloud Security',
    description: 'IAM, encryption, cloud-native security, CSPM',
    order: 1
});

CREATE (devsecops_sub:SubDomain {
    id: 'sub-devsecops',
    name: 'DevSecOps',
    description: 'Security in CI/CD, SAST, DAST, dependency scanning',
    order: 2
});

CREATE (appsec:SubDomain {
    id: 'sub-appsec',
    name: 'Application Security',
    description: 'OWASP, secure coding, vulnerability management',
    order: 3
});

CREATE (zero_trust_sub:SubDomain {
    id: 'sub-zero-trust',
    name: 'Zero Trust & Identity',
    description: 'Zero Trust architecture, identity management, PAM',
    order: 4
});

CREATE (compliance_sub:SubDomain {
    id: 'sub-compliance',
    name: 'Compliance & Governance',
    description: 'GDPR, SOC2, HIPAA, security frameworks',
    order: 5
});

// Connect to domain
MATCH (security:Domain {id: 'domain-security'}), (cloud_security:SubDomain {id: 'sub-cloud-security'})
CREATE (security)-[:CONTAINS]->(cloud_security);

MATCH (security:Domain {id: 'domain-security'}), (devsecops_sub:SubDomain {id: 'sub-devsecops'})
CREATE (security)-[:CONTAINS]->(devsecops_sub);

MATCH (security:Domain {id: 'domain-security'}), (appsec:SubDomain {id: 'sub-appsec'})
CREATE (security)-[:CONTAINS]->(appsec);

MATCH (security:Domain {id: 'domain-security'}), (zero_trust_sub:SubDomain {id: 'sub-zero-trust'})
CREATE (security)-[:CONTAINS]->(zero_trust_sub);

MATCH (security:Domain {id: 'domain-security'}), (compliance_sub:SubDomain {id: 'sub-compliance'})
CREATE (security)-[:CONTAINS]->(compliance_sub);

// ========================================
// 2. CREATE CLOUD SECURITY SKILLS
// ========================================

CREATE (cloud_security_fundamentals:Skill {
    id: 'skill-cloud-security-fundamentals',
    name: 'Cloud Security Fundamentals',
    description: 'Shared responsibility model, cloud security basics',
    difficulty_level: 'beginner',
    estimated_hours: 40,
    demand_score: 9,
    category: 'security-cloud',
    market_insights: 'Essential as everything moves to cloud',
    last_updated: date('2025-01-15')
});

CREATE (iam:Skill {
    id: 'skill-iam',
    name: 'Identity and Access Management',
    description: 'IAM policies, roles, MFA, SSO, SAML',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 9,
    category: 'security-cloud',
    last_updated: date('2025-01-15')
});

CREATE (cloud_encryption:Skill {
    id: 'skill-cloud-encryption',
    name: 'Cloud Encryption',
    description: 'KMS, data encryption at rest and in transit',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'security-cloud',
    last_updated: date('2025-01-15')
});

CREATE (cspm:Skill {
    id: 'skill-cspm',
    name: 'Cloud Security Posture Management',
    description: 'Cloud config monitoring, compliance checking',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 8,
    category: 'security-cloud',
    market_insights: 'Growing area for cloud governance',
    last_updated: date('2025-01-15')
});

CREATE (aws_security_services:Skill {
    id: 'skill-aws-security-services',
    name: 'AWS Security Services',
    description: 'GuardDuty, Security Hub, WAF, Shield, Macie',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 8,
    category: 'security-cloud',
    last_updated: date('2025-01-15')
});

CREATE (azure_security_services:Skill {
    id: 'skill-azure-security-services',
    name: 'Azure Security Services',
    description: 'Azure Sentinel, Defender, Key Vault',
    difficulty_level: 'intermediate',
    estimated_hours: 45,
    demand_score: 7,
    category: 'security-cloud',
    last_updated: date('2025-01-15')
});

// ========================================
// 3. CREATE DEVSECOPS SKILLS
// ========================================

CREATE (devsecops:Skill {
    id: 'skill-devsecops',
    name: 'DevSecOps Practices',
    description: 'Shift-left security, security as code',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 9,
    category: 'security-devsecops',
    is_bridge_skill: true,
    market_insights: 'Critical for modern development',
    last_updated: date('2025-01-15')
});

CREATE (sast:Skill {
    id: 'skill-sast',
    name: 'SAST (Static Application Security Testing)',
    description: 'SonarQube, Checkmarx, Fortify',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 8,
    category: 'security-devsecops',
    last_updated: date('2025-01-15')
});

CREATE (dast:Skill {
    id: 'skill-dast',
    name: 'DAST (Dynamic Application Security Testing)',
    description: 'OWASP ZAP, Burp Suite, runtime testing',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 7,
    category: 'security-devsecops',
    last_updated: date('2025-01-15')
});

CREATE (dependency_scanning:Skill {
    id: 'skill-dependency-scanning',
    name: 'Dependency & Supply Chain Security',
    description: 'Snyk, Dependabot, SBOM, supply chain attacks',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 9,
    category: 'security-devsecops',
    market_insights: 'Critical after SolarWinds, Log4j',
    last_updated: date('2025-01-15')
});

CREATE (secrets_management:Skill {
    id: 'skill-secrets-management',
    name: 'Secrets Management',
    description: 'HashiCorp Vault, AWS Secrets Manager, key rotation',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 8,
    category: 'security-devsecops',
    last_updated: date('2025-01-15')
});

CREATE (container_sec:Skill {
    id: 'skill-container-security-sec',
    name: 'Container Security',
    description: 'Image scanning, runtime protection, Falco, Twistlock',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'security-devsecops',
    last_updated: date('2025-01-15')
});

// ========================================
// 4. CREATE APPLICATION SECURITY SKILLS
// ========================================

CREATE (owasp_top10:Skill {
    id: 'skill-owasp-top10',
    name: 'OWASP Top 10',
    description: 'Common web vulnerabilities and mitigations',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 9,
    category: 'security-appsec',
    market_insights: 'Foundation of AppSec knowledge',
    last_updated: date('2025-01-15')
});

CREATE (secure_coding:Skill {
    id: 'skill-secure-coding',
    name: 'Secure Coding Practices',
    description: 'Input validation, error handling, secure defaults',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'security-appsec',
    last_updated: date('2025-01-15')
});

CREATE (api_security:Skill {
    id: 'skill-api-security',
    name: 'API Security',
    description: 'OAuth, JWT, API gateways, rate limiting',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 9,
    category: 'security-appsec',
    market_insights: 'Critical as APIs proliferate',
    last_updated: date('2025-01-15')
});

CREATE (threat_modeling:Skill {
    id: 'skill-threat-modeling',
    name: 'Threat Modeling',
    description: 'STRIDE, DREAD, attack trees, risk assessment',
    difficulty_level: 'advanced',
    estimated_hours: 45,
    demand_score: 7,
    category: 'security-appsec',
    last_updated: date('2025-01-15')
});

// ========================================
// 5. CREATE ZERO TRUST & IDENTITY SKILLS
// ========================================

CREATE (zero_trust:Skill {
    id: 'skill-zero-trust',
    name: 'Zero Trust Architecture',
    description: 'Never trust, always verify, micro-segmentation',
    difficulty_level: 'advanced',
    estimated_hours: 50,
    demand_score: 8,
    category: 'security-zero-trust',
    market_insights: 'Modern security architecture standard',
    last_updated: date('2025-01-15')
});

CREATE (okta:Skill {
    id: 'skill-okta',
    name: 'Okta',
    description: 'Identity management, SSO, MFA platform',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'security-zero-trust',
    last_updated: date('2025-01-15')
});

CREATE (azure_ad:Skill {
    id: 'skill-azure-ad',
    name: 'Azure Active Directory/Entra ID',
    description: 'Microsoft identity platform, conditional access',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'security-zero-trust',
    last_updated: date('2025-01-15')
});

CREATE (pam:Skill {
    id: 'skill-pam',
    name: 'Privileged Access Management',
    description: 'CyberArk, BeyondTrust, just-in-time access',
    difficulty_level: 'advanced',
    estimated_hours: 40,
    demand_score: 7,
    category: 'security-zero-trust',
    last_updated: date('2025-01-15')
});

// ========================================
// 6. CREATE COMPLIANCE & GOVERNANCE SKILLS
// ========================================

CREATE (gdpr:Skill {
    id: 'skill-gdpr',
    name: 'GDPR Compliance',
    description: 'EU data protection, privacy by design',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 8,
    category: 'security-compliance',
    last_updated: date('2025-01-15')
});

CREATE (soc2:Skill {
    id: 'skill-soc2',
    name: 'SOC 2 Compliance',
    description: 'Security controls, audit preparation',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'security-compliance',
    market_insights: 'Required for B2B SaaS',
    last_updated: date('2025-01-15')
});

CREATE (hipaa:Skill {
    id: 'skill-hipaa',
    name: 'HIPAA Compliance',
    description: 'Healthcare data protection, PHI handling',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 7,
    category: 'security-compliance',
    last_updated: date('2025-01-15')
});

CREATE (iso27001:Skill {
    id: 'skill-iso27001',
    name: 'ISO 27001',
    description: 'Information security management system',
    difficulty_level: 'advanced',
    estimated_hours: 50,
    demand_score: 7,
    category: 'security-compliance',
    last_updated: date('2025-01-15')
});

CREATE (nist:Skill {
    id: 'skill-nist',
    name: 'NIST Framework',
    description: 'Cybersecurity framework, risk management',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'security-compliance',
    last_updated: date('2025-01-15')
});

// ========================================
// 7. CONNECT SKILLS TO SUBDOMAINS
// ========================================

// Cloud Security connections
MATCH (cloud_security:SubDomain {id: 'sub-cloud-security'}), (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'})
CREATE (cloud_security)-[:CONTAINS]->(cloud_security_fundamentals);

MATCH (cloud_security:SubDomain {id: 'sub-cloud-security'}), (iam:Skill {id: 'skill-iam'})
CREATE (cloud_security)-[:CONTAINS]->(iam);

MATCH (cloud_security:SubDomain {id: 'sub-cloud-security'}), (cloud_encryption:Skill {id: 'skill-cloud-encryption'})
CREATE (cloud_security)-[:CONTAINS]->(cloud_encryption);

MATCH (cloud_security:SubDomain {id: 'sub-cloud-security'}), (cspm:Skill {id: 'skill-cspm'})
CREATE (cloud_security)-[:CONTAINS]->(cspm);

MATCH (cloud_security:SubDomain {id: 'sub-cloud-security'}), (aws_security_services:Skill {id: 'skill-aws-security-services'})
CREATE (cloud_security)-[:CONTAINS]->(aws_security_services);

MATCH (cloud_security:SubDomain {id: 'sub-cloud-security'}), (azure_security_services:Skill {id: 'skill-azure-security-services'})
CREATE (cloud_security)-[:CONTAINS]->(azure_security_services);

// DevSecOps connections
MATCH (devsecops_sub:SubDomain {id: 'sub-devsecops'}), (devsecops:Skill {id: 'skill-devsecops'})
CREATE (devsecops_sub)-[:CONTAINS]->(devsecops);

MATCH (devsecops_sub:SubDomain {id: 'sub-devsecops'}), (sast:Skill {id: 'skill-sast'})
CREATE (devsecops_sub)-[:CONTAINS]->(sast);

MATCH (devsecops_sub:SubDomain {id: 'sub-devsecops'}), (dast:Skill {id: 'skill-dast'})
CREATE (devsecops_sub)-[:CONTAINS]->(dast);

MATCH (devsecops_sub:SubDomain {id: 'sub-devsecops'}), (dependency_scanning:Skill {id: 'skill-dependency-scanning'})
CREATE (devsecops_sub)-[:CONTAINS]->(dependency_scanning);

MATCH (devsecops_sub:SubDomain {id: 'sub-devsecops'}), (secrets_management:Skill {id: 'skill-secrets-management'})
CREATE (devsecops_sub)-[:CONTAINS]->(secrets_management);

MATCH (devsecops_sub:SubDomain {id: 'sub-devsecops'}), (container_sec:Skill {id: 'skill-container-security-sec'})
CREATE (devsecops_sub)-[:CONTAINS]->(container_sec);

// Application Security connections
MATCH (appsec:SubDomain {id: 'sub-appsec'}), (owasp_top10:Skill {id: 'skill-owasp-top10'})
CREATE (appsec)-[:CONTAINS]->(owasp_top10);

MATCH (appsec:SubDomain {id: 'sub-appsec'}), (secure_coding:Skill {id: 'skill-secure-coding'})
CREATE (appsec)-[:CONTAINS]->(secure_coding);

MATCH (appsec:SubDomain {id: 'sub-appsec'}), (api_security:Skill {id: 'skill-api-security'})
CREATE (appsec)-[:CONTAINS]->(api_security);

MATCH (appsec:SubDomain {id: 'sub-appsec'}), (threat_modeling:Skill {id: 'skill-threat-modeling'})
CREATE (appsec)-[:CONTAINS]->(threat_modeling);

// Zero Trust connections
MATCH (zero_trust_sub:SubDomain {id: 'sub-zero-trust'}), (zero_trust:Skill {id: 'skill-zero-trust'})
CREATE (zero_trust_sub)-[:CONTAINS]->(zero_trust);

MATCH (zero_trust_sub:SubDomain {id: 'sub-zero-trust'}), (okta:Skill {id: 'skill-okta'})
CREATE (zero_trust_sub)-[:CONTAINS]->(okta);

MATCH (zero_trust_sub:SubDomain {id: 'sub-zero-trust'}), (azure_ad:Skill {id: 'skill-azure-ad'})
CREATE (zero_trust_sub)-[:CONTAINS]->(azure_ad);

MATCH (zero_trust_sub:SubDomain {id: 'sub-zero-trust'}), (pam:Skill {id: 'skill-pam'})
CREATE (zero_trust_sub)-[:CONTAINS]->(pam);

// Compliance connections
MATCH (compliance_sub:SubDomain {id: 'sub-compliance'}), (gdpr:Skill {id: 'skill-gdpr'})
CREATE (compliance_sub)-[:CONTAINS]->(gdpr);

MATCH (compliance_sub:SubDomain {id: 'sub-compliance'}), (soc2:Skill {id: 'skill-soc2'})
CREATE (compliance_sub)-[:CONTAINS]->(soc2);

MATCH (compliance_sub:SubDomain {id: 'sub-compliance'}), (hipaa:Skill {id: 'skill-hipaa'})
CREATE (compliance_sub)-[:CONTAINS]->(hipaa);

MATCH (compliance_sub:SubDomain {id: 'sub-compliance'}), (iso27001:Skill {id: 'skill-iso27001'})
CREATE (compliance_sub)-[:CONTAINS]->(iso27001);

MATCH (compliance_sub:SubDomain {id: 'sub-compliance'}), (nist:Skill {id: 'skill-nist'})
CREATE (compliance_sub)-[:CONTAINS]->(nist);

// ========================================
// 8. CREATE SKILL PREREQUISITES
// ========================================

// Cloud Security prerequisites
MATCH (aws_security_services:Skill {id: 'skill-aws-security-services'}), (aws_fundamentals:Skill {id: 'skill-aws-fundamentals'})
WHERE exists((aws_fundamentals))
CREATE (aws_security_services)-[:REQUIRES]->(aws_fundamentals);

MATCH (azure_security_services:Skill {id: 'skill-azure-security-services'}), (azure_fundamentals:Skill {id: 'skill-azure-fundamentals'})
WHERE exists((azure_fundamentals))
CREATE (azure_security_services)-[:REQUIRES]->(azure_fundamentals);

MATCH (iam:Skill {id: 'skill-iam'}), (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'})
CREATE (iam)-[:REQUIRES]->(cloud_security_fundamentals);

MATCH (cspm:Skill {id: 'skill-cspm'}), (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'})
CREATE (cspm)-[:REQUIRES]->(cloud_security_fundamentals);

// DevSecOps prerequisites
MATCH (devsecops:Skill {id: 'skill-devsecops'}), (git:Skill {id: 'skill-git'})
CREATE (devsecops)-[:REQUIRES]->(git);

MATCH (sast:Skill {id: 'skill-sast'}), (git:Skill {id: 'skill-git'})
CREATE (sast)-[:REQUIRES]->(git);

MATCH (dependency_scanning:Skill {id: 'skill-dependency-scanning'}), (git:Skill {id: 'skill-git'})
CREATE (dependency_scanning)-[:REQUIRES]->(git);

MATCH (container_sec:Skill {id: 'skill-container-security-sec'}), (docker:Skill {id: 'skill-docker'})
CREATE (container_sec)-[:REQUIRES]->(docker);

MATCH (container_sec:Skill {id: 'skill-container-security-sec'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (container_sec)-[:REQUIRES]->(kubernetes);

// Application Security prerequisites
MATCH (secure_coding:Skill {id: 'skill-secure-coding'}), (python:Skill {id: 'skill-python'})
CREATE (secure_coding)-[:REQUIRES]->(python);

MATCH (api_security:Skill {id: 'skill-api-security'}), (owasp_top10:Skill {id: 'skill-owasp-top10'})
CREATE (api_security)-[:REQUIRES]->(owasp_top10);

MATCH (threat_modeling:Skill {id: 'skill-threat-modeling'}), (owasp_top10:Skill {id: 'skill-owasp-top10'})
CREATE (threat_modeling)-[:REQUIRES]->(owasp_top10);

// Zero Trust prerequisites
MATCH (zero_trust:Skill {id: 'skill-zero-trust'}), (iam:Skill {id: 'skill-iam'})
CREATE (zero_trust)-[:REQUIRES]->(iam);

MATCH (pam:Skill {id: 'skill-pam'}), (iam:Skill {id: 'skill-iam'})
CREATE (pam)-[:REQUIRES]->(iam);

// Compliance prerequisites
MATCH (soc2:Skill {id: 'skill-soc2'}), (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'})
CREATE (soc2)-[:REQUIRES]->(cloud_security_fundamentals);

MATCH (iso27001:Skill {id: 'skill-iso27001'}), (nist:Skill {id: 'skill-nist'})
CREATE (iso27001)-[:REQUIRES]->(nist);

// ========================================
// 9. CREATE SKILL PROGRESSIONS
// ========================================

MATCH (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'}), (iam:Skill {id: 'skill-iam'})
CREATE (cloud_security_fundamentals)-[:LEADS_TO]->(iam);

MATCH (iam:Skill {id: 'skill-iam'}), (zero_trust:Skill {id: 'skill-zero-trust'})
CREATE (iam)-[:LEADS_TO]->(zero_trust);

MATCH (owasp_top10:Skill {id: 'skill-owasp-top10'}), (secure_coding:Skill {id: 'skill-secure-coding'})
CREATE (owasp_top10)-[:LEADS_TO]->(secure_coding);

MATCH (secure_coding:Skill {id: 'skill-secure-coding'}), (sast:Skill {id: 'skill-sast'})
CREATE (secure_coding)-[:LEADS_TO]->(sast);

MATCH (sast:Skill {id: 'skill-sast'}), (devsecops:Skill {id: 'skill-devsecops'})
CREATE (sast)-[:LEADS_TO]->(devsecops);

MATCH (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'}), (cspm:Skill {id: 'skill-cspm'})
CREATE (cloud_security_fundamentals)-[:LEADS_TO]->(cspm);

MATCH (nist:Skill {id: 'skill-nist'}), (soc2:Skill {id: 'skill-soc2'})
CREATE (nist)-[:LEADS_TO]->(soc2);

MATCH (soc2:Skill {id: 'skill-soc2'}), (iso27001:Skill {id: 'skill-iso27001'})
CREATE (soc2)-[:LEADS_TO]->(iso27001);

// ========================================
// 10. CREATE CERTIFICATIONS
// ========================================

CREATE (aws_security:Certification {
    id: 'cert-aws-security',
    name: 'AWS Certified Security Specialty',
    provider: 'AWS',
    level: 'specialty',
    cost: 300,
    validity_period: '3 years',
    estimated_prep_hours: 100,
    difficulty_rating: 8,
    market_value: 'very-high',
    url: 'https://aws.amazon.com/certification/certified-security-specialty/',
    exam_format: 'Multiple choice, 170 minutes'
});

CREATE (az_500:Certification {
    id: 'cert-az-500',
    name: 'Azure Security Engineer Associate',
    provider: 'Microsoft',
    level: 'associate',
    cost: 165,
    validity_period: '1 year',
    estimated_prep_hours: 60,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://learn.microsoft.com/certifications/azure-security-engineer/',
    exam_format: 'Multiple choice, 150 minutes'
});

CREATE (gcp_security:Certification {
    id: 'cert-gcp-security',
    name: 'Google Cloud Security Engineer',
    provider: 'Google',
    level: 'professional',
    cost: 200,
    validity_period: '2 years',
    estimated_prep_hours: 80,
    difficulty_rating: 7,
    market_value: 'high',
    url: 'https://cloud.google.com/certification/cloud-security-engineer',
    exam_format: 'Multiple choice, 120 minutes'
});

CREATE (cissp:Certification {
    id: 'cert-cissp',
    name: 'CISSP',
    provider: 'ISC2',
    level: 'professional',
    cost: 749,
    validity_period: '3 years',
    estimated_prep_hours: 150,
    difficulty_rating: 9,
    market_value: 'very-high',
    url: 'https://www.isc2.org/Certifications/CISSP',
    exam_format: 'Multiple choice, 180 minutes'
});

CREATE (cisa:Certification {
    id: 'cert-cisa',
    name: 'CISA',
    provider: 'ISACA',
    level: 'professional',
    cost: 760,
    validity_period: '3 years',
    estimated_prep_hours: 120,
    difficulty_rating: 8,
    market_value: 'high',
    url: 'https://www.isaca.org/credentialing/cisa',
    exam_format: 'Multiple choice, 240 minutes'
});

CREATE (ceh:Certification {
    id: 'cert-ceh',
    name: 'Certified Ethical Hacker',
    provider: 'EC-Council',
    level: 'professional',
    cost: 1199,
    validity_period: '3 years',
    estimated_prep_hours: 80,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://www.eccouncil.org/programs/certified-ethical-hacker-ceh/',
    exam_format: 'Multiple choice, 240 minutes'
});

CREATE (comptia_security:Certification {
    id: 'cert-comptia-security',
    name: 'CompTIA Security+',
    provider: 'CompTIA',
    level: 'foundational',
    cost: 392,
    validity_period: '3 years',
    estimated_prep_hours: 60,
    difficulty_rating: 5,
    market_value: 'medium',
    url: 'https://www.comptia.org/certifications/security',
    exam_format: 'Multiple choice, 90 minutes'
});

CREATE (ccsp:Certification {
    id: 'cert-ccsp',
    name: 'Certified Cloud Security Professional',
    provider: 'ISC2',
    level: 'professional',
    cost: 599,
    validity_period: '3 years',
    estimated_prep_hours: 100,
    difficulty_rating: 8,
    market_value: 'very-high',
    url: 'https://www.isc2.org/Certifications/CCSP',
    exam_format: 'Multiple choice, 180 minutes'
});

// Connect certifications to skills
MATCH (aws_security:Certification {id: 'cert-aws-security'}), (aws_security_services:Skill {id: 'skill-aws-security-services'})
CREATE (aws_security)-[:REQUIRES]->(aws_security_services);

MATCH (aws_security:Certification {id: 'cert-aws-security'}), (iam:Skill {id: 'skill-iam'})
CREATE (aws_security)-[:REQUIRES]->(iam);

MATCH (az_500:Certification {id: 'cert-az-500'}), (azure_security_services:Skill {id: 'skill-azure-security-services'})
CREATE (az_500)-[:REQUIRES]->(azure_security_services);

MATCH (gcp_security:Certification {id: 'cert-gcp-security'}), (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'})
CREATE (gcp_security)-[:REQUIRES]->(cloud_security_fundamentals);

MATCH (cissp:Certification {id: 'cert-cissp'}), (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'})
CREATE (cissp)-[:REQUIRES]->(cloud_security_fundamentals);

MATCH (ccsp:Certification {id: 'cert-ccsp'}), (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'})
CREATE (ccsp)-[:REQUIRES]->(cloud_security_fundamentals);

MATCH (comptia_security:Certification {id: 'cert-comptia-security'}), (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'})
CREATE (comptia_security)-[:REQUIRES]->(cloud_security_fundamentals);

// Certification progressions
MATCH (comptia_security:Certification {id: 'cert-comptia-security'}), (aws_security:Certification {id: 'cert-aws-security'})
CREATE (comptia_security)-[:LEADS_TO]->(aws_security);

MATCH (comptia_security:Certification {id: 'cert-comptia-security'}), (cissp:Certification {id: 'cert-cissp'})
CREATE (comptia_security)-[:LEADS_TO]->(cissp);

MATCH (aws_security:Certification {id: 'cert-aws-security'}), (ccsp:Certification {id: 'cert-ccsp'})
CREATE (aws_security)-[:LEADS_TO]->(ccsp);

// Connect certifications to domain
MATCH (aws_security:Certification {id: 'cert-aws-security'}), (security:Domain {id: 'domain-security'})
CREATE (aws_security)-[:RECOMMENDED_FOR]->(security);

MATCH (cissp:Certification {id: 'cert-cissp'}), (security:Domain {id: 'domain-security'})
CREATE (cissp)-[:RECOMMENDED_FOR]->(security);

MATCH (ccsp:Certification {id: 'cert-ccsp'}), (security:Domain {id: 'domain-security'})
CREATE (ccsp)-[:RECOMMENDED_FOR]->(security);

// ========================================
// 11. CREATE RESOURCES
// ========================================

// Security Books
CREATE (security_engineering:Resource {
    id: 'res-security-engineering',
    title: 'Security Engineering by Ross Anderson',
    url: 'https://www.cl.cam.ac.uk/~rja14/book.html',
    type: 'book',
    platform: 'Cambridge',
    duration: '50 hours',
    rating: 4.8,
    price: 'free',
    difficulty_level: 'advanced',
    learning_style: 'reading'
});

CREATE (web_app_hackers:Resource {
    id: 'res-web-app-hackers',
    title: 'Web Application Hackers Handbook',
    url: 'https://www.wiley.com/en-us/The+Web+Application+Hacker%27s+Handbook',
    type: 'book',
    platform: 'Wiley',
    duration: '40 hours',
    rating: 4.7,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// OWASP Resources
CREATE (owasp_guide:Resource {
    id: 'res-owasp-guide',
    title: 'OWASP Testing Guide',
    url: 'https://owasp.org/www-project-web-security-testing-guide/',
    type: 'guide',
    platform: 'OWASP',
    duration: '30 hours',
    rating: 4.8,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (owasp_top10_resource:Resource {
    id: 'res-owasp-top10',
    title: 'OWASP Top 10 Documentation',
    url: 'https://owasp.org/www-project-top-ten/',
    type: 'doc',
    platform: 'OWASP',
    duration: '10 hours',
    rating: 4.9,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// DevSecOps Resources
CREATE (devsecops_handbook:Resource {
    id: 'res-devsecops-handbook',
    title: 'DevSecOps Handbook',
    url: 'https://www.oreilly.com/library/view/devsecops/9781492083863/',
    type: 'book',
    platform: 'OReilly',
    duration: '25 hours',
    rating: 4.6,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (snyk_learn:Resource {
    id: 'res-snyk-learn',
    title: 'Snyk Learn Security Education',
    url: 'https://learn.snyk.io/',
    type: 'course',
    platform: 'Snyk',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'mixed'
});

// Cloud Security Resources
CREATE (aws_security_best:Resource {
    id: 'res-aws-security-best',
    title: 'AWS Security Best Practices',
    url: 'https://aws.amazon.com/security/security-resources/',
    type: 'doc',
    platform: 'AWS',
    duration: 'self-paced',
    rating: 4.6,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (azure_security_docs:Resource {
    id: 'res-azure-security-docs',
    title: 'Azure Security Documentation',
    url: 'https://docs.microsoft.com/azure/security/',
    type: 'doc',
    platform: 'Microsoft',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

// Zero Trust Resources
CREATE (zero_trust_book:Resource {
    id: 'res-zero-trust-book',
    title: 'Zero Trust Networks',
    url: 'https://www.oreilly.com/library/view/zero-trust-networks/9781491962183/',
    type: 'book',
    platform: 'OReilly',
    duration: '20 hours',
    rating: 4.6,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// Compliance Resources
CREATE (soc2_guide:Resource {
    id: 'res-soc2-guide',
    title: 'SOC 2 Academy',
    url: 'https://www.soc2.co/',
    type: 'course',
    platform: 'SOC2.co',
    duration: '20 hours',
    rating: 4.5,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'mixed'
});

CREATE (nist_framework:Resource {
    id: 'res-nist-framework',
    title: 'NIST Cybersecurity Framework',
    url: 'https://www.nist.gov/cyberframework',
    type: 'doc',
    platform: 'NIST',
    duration: '15 hours',
    rating: 4.7,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// Connect resources to skills
MATCH (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'}), (security_engineering:Resource {id: 'res-security-engineering'})
CREATE (cloud_security_fundamentals)-[:HAS_RESOURCE]->(security_engineering);

MATCH (owasp_top10:Skill {id: 'skill-owasp-top10'}), (owasp_top10_resource:Resource {id: 'res-owasp-top10'})
CREATE (owasp_top10)-[:HAS_RESOURCE]->(owasp_top10_resource);

MATCH (owasp_top10:Skill {id: 'skill-owasp-top10'}), (web_app_hackers:Resource {id: 'res-web-app-hackers'})
CREATE (owasp_top10)-[:HAS_RESOURCE]->(web_app_hackers);

MATCH (secure_coding:Skill {id: 'skill-secure-coding'}), (owasp_guide:Resource {id: 'res-owasp-guide'})
CREATE (secure_coding)-[:HAS_RESOURCE]->(owasp_guide);

MATCH (devsecops:Skill {id: 'skill-devsecops'}), (devsecops_handbook:Resource {id: 'res-devsecops-handbook'})
CREATE (devsecops)-[:HAS_RESOURCE]->(devsecops_handbook);

MATCH (dependency_scanning:Skill {id: 'skill-dependency-scanning'}), (snyk_learn:Resource {id: 'res-snyk-learn'})
CREATE (dependency_scanning)-[:HAS_RESOURCE]->(snyk_learn);

MATCH (aws_security_services:Skill {id: 'skill-aws-security-services'}), (aws_security_best:Resource {id: 'res-aws-security-best'})
CREATE (aws_security_services)-[:HAS_RESOURCE]->(aws_security_best);

MATCH (azure_security_services:Skill {id: 'skill-azure-security-services'}), (azure_security_docs:Resource {id: 'res-azure-security-docs'})
CREATE (azure_security_services)-[:HAS_RESOURCE]->(azure_security_docs);

MATCH (zero_trust:Skill {id: 'skill-zero-trust'}), (zero_trust_book:Resource {id: 'res-zero-trust-book'})
CREATE (zero_trust)-[:HAS_RESOURCE]->(zero_trust_book);

MATCH (soc2:Skill {id: 'skill-soc2'}), (soc2_guide:Resource {id: 'res-soc2-guide'})
CREATE (soc2)-[:HAS_RESOURCE]->(soc2_guide);

MATCH (nist:Skill {id: 'skill-nist'}), (nist_framework:Resource {id: 'res-nist-framework'})
CREATE (nist)-[:HAS_RESOURCE]->(nist_framework);

// ========================================
// CROSS-DOMAIN RELATIONSHIPS
// ========================================

// DevSecOps bridges to DevOps
MATCH (devsecops:Skill {id: 'skill-devsecops'}), (devops:Domain {id: 'domain-devops'})
CREATE (devsecops)-[:APPLIES_IN]->(devops);

// Container Security bridges to Cloud and DevOps
MATCH (container_sec:Skill {id: 'skill-container-security-sec'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (container_sec)-[:APPLIES_IN]->(cloud);

MATCH (container_sec:Skill {id: 'skill-container-security-sec'}), (devops:Domain {id: 'domain-devops'})
CREATE (container_sec)-[:APPLIES_IN]->(devops);

// API Security bridges to Software Engineering
MATCH (api_security:Skill {id: 'skill-api-security'}), (software:Domain {id: 'domain-software'})
CREATE (api_security)-[:APPLIES_IN]->(software);

// Cloud Security bridges to Cloud domain
MATCH (cloud_security_fundamentals:Skill {id: 'skill-cloud-security-fundamentals'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (cloud_security_fundamentals)-[:APPLIES_IN]->(cloud);

// Compliance bridges to Data Engineering (for data privacy)
MATCH (gdpr:Skill {id: 'skill-gdpr'}), (data:Domain {id: 'domain-data'})
CREATE (gdpr)-[:APPLIES_IN]->(data);

// ========================================
// VERIFICATION QUERY
// ========================================
// Run to verify Security domain is loaded:
// MATCH (d:Domain {id: 'domain-security'})-[:CONTAINS]->(sd:SubDomain)-[:CONTAINS]->(s:Skill) 
// RETURN d.name, sd.name, count(s) as skill_count;
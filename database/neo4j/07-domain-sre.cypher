// ========================================
// SKILL PATH NAVIGATOR - SITE RELIABILITY ENGINEERING DOMAIN
// ========================================
// Run AFTER base domains script
// Creates complete SRE skill tree with observability, monitoring, and reliability engineering

// ========================================
// 1. CREATE SUBDOMAINS
// ========================================

CREATE (observability:SubDomain {
    id: 'sub-observability',
    name: 'Observability',
    description: 'Monitoring, logging, tracing, and metrics - the three pillars plus more',
    order: 1
});

CREATE (incident_mgmt:SubDomain {
    id: 'sub-incident',
    name: 'Incident Management',
    description: 'On-call, incident response, postmortems, runbooks',
    order: 2
});

CREATE (reliability_eng:SubDomain {
    id: 'sub-reliability',
    name: 'Reliability Engineering',
    description: 'SLIs, SLOs, error budgets, reliability patterns',
    order: 3
});

CREATE (chaos_eng:SubDomain {
    id: 'sub-chaos',
    name: 'Chaos Engineering',
    description: 'Fault injection, resilience testing, game days',
    order: 4
});

CREATE (performance:SubDomain {
    id: 'sub-performance',
    name: 'Performance Engineering',
    description: 'Load testing, optimization, capacity planning',
    order: 5
});

// Connect to domain
MATCH (sre:Domain {id: 'domain-sre'}), (observability:SubDomain {id: 'sub-observability'})
CREATE (sre)-[:CONTAINS]->(observability);

MATCH (sre:Domain {id: 'domain-sre'}), (incident_mgmt:SubDomain {id: 'sub-incident'})
CREATE (sre)-[:CONTAINS]->(incident_mgmt);

MATCH (sre:Domain {id: 'domain-sre'}), (reliability_eng:SubDomain {id: 'sub-reliability'})
CREATE (sre)-[:CONTAINS]->(reliability_eng);

MATCH (sre:Domain {id: 'domain-sre'}), (chaos_eng:SubDomain {id: 'sub-chaos'})
CREATE (sre)-[:CONTAINS]->(chaos_eng);

MATCH (sre:Domain {id: 'domain-sre'}), (performance:SubDomain {id: 'sub-performance'})
CREATE (sre)-[:CONTAINS]->(performance);

// ========================================
// 2. CREATE OBSERVABILITY SKILLS
// ========================================

CREATE (prometheus:Skill {
    id: 'skill-prometheus',
    name: 'Prometheus',
    description: 'Metrics collection, alerting, PromQL',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'sre-observability',
    market_insights: 'Industry standard for Kubernetes monitoring',
    last_updated: date('2025-01-15')
});

CREATE (grafana:Skill {
    id: 'skill-grafana',
    name: 'Grafana',
    description: 'Data visualization, dashboards, alerting',
    difficulty_level: 'beginner',
    estimated_hours: 25,
    demand_score: 8,
    category: 'sre-observability',
    last_updated: date('2025-01-15')
});

CREATE (opentelemetry:Skill {
    id: 'skill-opentelemetry',
    name: 'OpenTelemetry',
    description: 'Distributed tracing, vendor-neutral observability',
    difficulty_level: 'advanced',
    estimated_hours: 50,
    demand_score: 8,
    category: 'sre-observability',
    market_insights: 'Future of observability standards',
    last_updated: date('2025-01-15')
});

CREATE (elk_stack:Skill {
    id: 'skill-elk-stack',
    name: 'ELK Stack',
    description: 'Elasticsearch, Logstash, Kibana for log management',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 7,
    category: 'sre-observability',
    last_updated: date('2025-01-15')
});

CREATE (datadog:Skill {
    id: 'skill-datadog',
    name: 'Datadog',
    description: 'Full-stack observability platform',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 8,
    category: 'sre-observability',
    market_insights: 'Popular enterprise solution',
    last_updated: date('2025-01-15')
});

CREATE (new_relic:Skill {
    id: 'skill-new-relic',
    name: 'New Relic',
    description: 'APM and observability platform',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'sre-observability',
    last_updated: date('2025-01-15')
});

CREATE (jaeger:Skill {
    id: 'skill-jaeger',
    name: 'Jaeger',
    description: 'Distributed tracing system',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'sre-observability',
    last_updated: date('2025-01-15')
});

CREATE (loki:Skill {
    id: 'skill-loki',
    name: 'Grafana Loki',
    description: 'Log aggregation for Kubernetes',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'sre-observability',
    last_updated: date('2025-01-15')
});

// ========================================
// 3. CREATE INCIDENT MANAGEMENT SKILLS
// ========================================

CREATE (incident_response:Skill {
    id: 'skill-incident-response',
    name: 'Incident Response',
    description: 'Incident command, communication, resolution',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 9,
    category: 'sre-incident',
    market_insights: 'Critical SRE skill',
    last_updated: date('2025-01-15')
});

CREATE (on_call:Skill {
    id: 'skill-on-call',
    name: 'On-Call Management',
    description: 'Rotation management, escalation, alerting fatigue',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 8,
    category: 'sre-incident',
    last_updated: date('2025-01-15')
});

CREATE (pagerduty:Skill {
    id: 'skill-pagerduty',
    name: 'PagerDuty',
    description: 'Incident management platform',
    difficulty_level: 'beginner',
    estimated_hours: 15,
    demand_score: 7,
    category: 'sre-incident',
    last_updated: date('2025-01-15')
});

CREATE (postmortems:Skill {
    id: 'skill-postmortems',
    name: 'Blameless Postmortems',
    description: 'Root cause analysis, learning from failures',
    difficulty_level: 'intermediate',
    estimated_hours: 25,
    demand_score: 8,
    category: 'sre-incident',
    market_insights: 'Key to building resilient culture',
    last_updated: date('2025-01-15')
});

CREATE (runbooks:Skill {
    id: 'skill-runbooks',
    name: 'Runbook Automation',
    description: 'Automated remediation, self-healing systems',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 7,
    category: 'sre-incident',
    last_updated: date('2025-01-15')
});

// ========================================
// 4. CREATE RELIABILITY ENGINEERING SKILLS
// ========================================

CREATE (sli_slo:Skill {
    id: 'skill-sli-slo',
    name: 'SLIs, SLOs, and Error Budgets',
    description: 'Service level indicators, objectives, and error budget management',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 9,
    category: 'sre-reliability',
    market_insights: 'Core SRE practice from Google',
    last_updated: date('2025-01-15')
});

CREATE (reliability_patterns:Skill {
    id: 'skill-reliability-patterns',
    name: 'Reliability Patterns',
    description: 'Circuit breakers, retries, timeouts, bulkheads',
    difficulty_level: 'intermediate',
    estimated_hours: 45,
    demand_score: 8,
    category: 'sre-reliability',
    last_updated: date('2025-01-15')
});

CREATE (capacity_planning:Skill {
    id: 'skill-capacity-planning',
    name: 'Capacity Planning',
    description: 'Forecasting, resource optimization, scaling strategies',
    difficulty_level: 'advanced',
    estimated_hours: 50,
    demand_score: 8,
    category: 'sre-reliability',
    last_updated: date('2025-01-15')
});

CREATE (disaster_recovery:Skill {
    id: 'skill-disaster-recovery',
    name: 'Disaster Recovery',
    description: 'RTO, RPO, backup strategies, failover',
    difficulty_level: 'advanced',
    estimated_hours: 60,
    demand_score: 8,
    category: 'sre-reliability',
    last_updated: date('2025-01-15')
});

// ========================================
// 5. CREATE CHAOS ENGINEERING SKILLS
// ========================================

CREATE (chaos_principles:Skill {
    id: 'skill-chaos-principles',
    name: 'Chaos Engineering Principles',
    description: 'Hypothesis-driven experiments, blast radius control',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'sre-chaos',
    market_insights: 'Growing practice for building resilience',
    last_updated: date('2025-01-15')
});

CREATE (chaos_monkey:Skill {
    id: 'skill-chaos-monkey',
    name: 'Chaos Monkey & Simian Army',
    description: 'Netflix chaos engineering tools',
    difficulty_level: 'intermediate',
    estimated_hours: 25,
    demand_score: 6,
    category: 'sre-chaos',
    last_updated: date('2025-01-15')
});

CREATE (litmus:Skill {
    id: 'skill-litmus',
    name: 'Litmus Chaos',
    description: 'Cloud-native chaos engineering for Kubernetes',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 6,
    category: 'sre-chaos',
    last_updated: date('2025-01-15')
});

CREATE (game_days:Skill {
    id: 'skill-game-days',
    name: 'Game Days',
    description: 'Planned failure exercises, team training',
    difficulty_level: 'intermediate',
    estimated_hours: 25,
    demand_score: 7,
    category: 'sre-chaos',
    last_updated: date('2025-01-15')
});

// ========================================
// 6. CREATE PERFORMANCE ENGINEERING SKILLS
// ========================================

CREATE (load_testing:Skill {
    id: 'skill-load-testing',
    name: 'Load Testing',
    description: 'Performance testing, stress testing, spike testing',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'sre-performance',
    last_updated: date('2025-01-15')
});

CREATE (jmeter:Skill {
    id: 'skill-jmeter',
    name: 'Apache JMeter',
    description: 'Performance testing tool',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'sre-performance',
    last_updated: date('2025-01-15')
});

CREATE (k6:Skill {
    id: 'skill-k6',
    name: 'k6',
    description: 'Modern load testing tool, developer-centric',
    difficulty_level: 'beginner',
    estimated_hours: 20,
    demand_score: 7,
    category: 'sre-performance',
    market_insights: 'Growing alternative to JMeter',
    last_updated: date('2025-01-15')
});

CREATE (performance_optimization:Skill {
    id: 'skill-performance-optimization',
    name: 'Performance Optimization',
    description: 'Profiling, bottleneck analysis, optimization techniques',
    difficulty_level: 'advanced',
    estimated_hours: 60,
    demand_score: 8,
    category: 'sre-performance',
    last_updated: date('2025-01-15')
});

// ========================================
// 7. CONNECT SKILLS TO SUBDOMAINS
// ========================================

// Observability connections
MATCH (observability:SubDomain {id: 'sub-observability'}), (prometheus:Skill {id: 'skill-prometheus'})
CREATE (observability)-[:CONTAINS]->(prometheus);

MATCH (observability:SubDomain {id: 'sub-observability'}), (grafana:Skill {id: 'skill-grafana'})
CREATE (observability)-[:CONTAINS]->(grafana);

MATCH (observability:SubDomain {id: 'sub-observability'}), (opentelemetry:Skill {id: 'skill-opentelemetry'})
CREATE (observability)-[:CONTAINS]->(opentelemetry);

MATCH (observability:SubDomain {id: 'sub-observability'}), (elk_stack:Skill {id: 'skill-elk-stack'})
CREATE (observability)-[:CONTAINS]->(elk_stack);

MATCH (observability:SubDomain {id: 'sub-observability'}), (datadog:Skill {id: 'skill-datadog'})
CREATE (observability)-[:CONTAINS]->(datadog);

MATCH (observability:SubDomain {id: 'sub-observability'}), (new_relic:Skill {id: 'skill-new-relic'})
CREATE (observability)-[:CONTAINS]->(new_relic);

MATCH (observability:SubDomain {id: 'sub-observability'}), (jaeger:Skill {id: 'skill-jaeger'})
CREATE (observability)-[:CONTAINS]->(jaeger);

MATCH (observability:SubDomain {id: 'sub-observability'}), (loki:Skill {id: 'skill-loki'})
CREATE (observability)-[:CONTAINS]->(loki);

// Incident Management connections
MATCH (incident_mgmt:SubDomain {id: 'sub-incident'}), (incident_response:Skill {id: 'skill-incident-response'})
CREATE (incident_mgmt)-[:CONTAINS]->(incident_response);

MATCH (incident_mgmt:SubDomain {id: 'sub-incident'}), (on_call:Skill {id: 'skill-on-call'})
CREATE (incident_mgmt)-[:CONTAINS]->(on_call);

MATCH (incident_mgmt:SubDomain {id: 'sub-incident'}), (pagerduty:Skill {id: 'skill-pagerduty'})
CREATE (incident_mgmt)-[:CONTAINS]->(pagerduty);

MATCH (incident_mgmt:SubDomain {id: 'sub-incident'}), (postmortems:Skill {id: 'skill-postmortems'})
CREATE (incident_mgmt)-[:CONTAINS]->(postmortems);

MATCH (incident_mgmt:SubDomain {id: 'sub-incident'}), (runbooks:Skill {id: 'skill-runbooks'})
CREATE (incident_mgmt)-[:CONTAINS]->(runbooks);

// Reliability Engineering connections
MATCH (reliability_eng:SubDomain {id: 'sub-reliability'}), (sli_slo:Skill {id: 'skill-sli-slo'})
CREATE (reliability_eng)-[:CONTAINS]->(sli_slo);

MATCH (reliability_eng:SubDomain {id: 'sub-reliability'}), (reliability_patterns:Skill {id: 'skill-reliability-patterns'})
CREATE (reliability_eng)-[:CONTAINS]->(reliability_patterns);

MATCH (reliability_eng:SubDomain {id: 'sub-reliability'}), (capacity_planning:Skill {id: 'skill-capacity-planning'})
CREATE (reliability_eng)-[:CONTAINS]->(capacity_planning);

MATCH (reliability_eng:SubDomain {id: 'sub-reliability'}), (disaster_recovery:Skill {id: 'skill-disaster-recovery'})
CREATE (reliability_eng)-[:CONTAINS]->(disaster_recovery);

// Chaos Engineering connections
MATCH (chaos_eng:SubDomain {id: 'sub-chaos'}), (chaos_principles:Skill {id: 'skill-chaos-principles'})
CREATE (chaos_eng)-[:CONTAINS]->(chaos_principles);

MATCH (chaos_eng:SubDomain {id: 'sub-chaos'}), (chaos_monkey:Skill {id: 'skill-chaos-monkey'})
CREATE (chaos_eng)-[:CONTAINS]->(chaos_monkey);

MATCH (chaos_eng:SubDomain {id: 'sub-chaos'}), (litmus:Skill {id: 'skill-litmus'})
CREATE (chaos_eng)-[:CONTAINS]->(litmus);

MATCH (chaos_eng:SubDomain {id: 'sub-chaos'}), (game_days:Skill {id: 'skill-game-days'})
CREATE (chaos_eng)-[:CONTAINS]->(game_days);

// Performance Engineering connections
MATCH (performance:SubDomain {id: 'sub-performance'}), (load_testing:Skill {id: 'skill-load-testing'})
CREATE (performance)-[:CONTAINS]->(load_testing);

MATCH (performance:SubDomain {id: 'sub-performance'}), (jmeter:Skill {id: 'skill-jmeter'})
CREATE (performance)-[:CONTAINS]->(jmeter);

MATCH (performance:SubDomain {id: 'sub-performance'}), (k6:Skill {id: 'skill-k6'})
CREATE (performance)-[:CONTAINS]->(k6);

MATCH (performance:SubDomain {id: 'sub-performance'}), (performance_optimization:Skill {id: 'skill-performance-optimization'})
CREATE (performance)-[:CONTAINS]->(performance_optimization);

// ========================================
// 8. CREATE SKILL PREREQUISITES
// ========================================

// Observability prerequisites
MATCH (prometheus:Skill {id: 'skill-prometheus'}), (linux:Skill {id: 'skill-linux'})
CREATE (prometheus)-[:REQUIRES]->(linux);

MATCH (grafana:Skill {id: 'skill-grafana'}), (prometheus:Skill {id: 'skill-prometheus'})
CREATE (grafana)-[:REQUIRES]->(prometheus);

MATCH (opentelemetry:Skill {id: 'skill-opentelemetry'}), (prometheus:Skill {id: 'skill-prometheus'})
CREATE (opentelemetry)-[:REQUIRES]->(prometheus);

MATCH (jaeger:Skill {id: 'skill-jaeger'}), (docker:Skill {id: 'skill-docker'})
CREATE (jaeger)-[:REQUIRES]->(docker);

MATCH (loki:Skill {id: 'skill-loki'}), (grafana:Skill {id: 'skill-grafana'})
CREATE (loki)-[:REQUIRES]->(grafana);

MATCH (elk_stack:Skill {id: 'skill-elk-stack'}), (linux:Skill {id: 'skill-linux'})
CREATE (elk_stack)-[:REQUIRES]->(linux);

// Incident Management prerequisites
MATCH (incident_response:Skill {id: 'skill-incident-response'}), (prometheus:Skill {id: 'skill-prometheus'})
CREATE (incident_response)-[:REQUIRES]->(prometheus);

MATCH (on_call:Skill {id: 'skill-on-call'}), (incident_response:Skill {id: 'skill-incident-response'})
CREATE (on_call)-[:REQUIRES]->(incident_response);

MATCH (postmortems:Skill {id: 'skill-postmortems'}), (incident_response:Skill {id: 'skill-incident-response'})
CREATE (postmortems)-[:REQUIRES]->(incident_response);

MATCH (runbooks:Skill {id: 'skill-runbooks'}), (python:Skill {id: 'skill-python'})
CREATE (runbooks)-[:REQUIRES]->(python);

// Reliability prerequisites
MATCH (sli_slo:Skill {id: 'skill-sli-slo'}), (prometheus:Skill {id: 'skill-prometheus'})
CREATE (sli_slo)-[:REQUIRES]->(prometheus);

MATCH (reliability_patterns:Skill {id: 'skill-reliability-patterns'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (reliability_patterns)-[:REQUIRES]->(kubernetes);

MATCH (capacity_planning:Skill {id: 'skill-capacity-planning'}), (prometheus:Skill {id: 'skill-prometheus'})
CREATE (capacity_planning)-[:REQUIRES]->(prometheus);

MATCH (disaster_recovery:Skill {id: 'skill-disaster-recovery'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (disaster_recovery)-[:REQUIRES]->(kubernetes);

// Chaos prerequisites
MATCH (chaos_principles:Skill {id: 'skill-chaos-principles'}), (sli_slo:Skill {id: 'skill-sli-slo'})
CREATE (chaos_principles)-[:REQUIRES]->(sli_slo);

MATCH (chaos_monkey:Skill {id: 'skill-chaos-monkey'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (chaos_monkey)-[:REQUIRES]->(kubernetes);

MATCH (litmus:Skill {id: 'skill-litmus'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (litmus)-[:REQUIRES]->(kubernetes);

MATCH (game_days:Skill {id: 'skill-game-days'}), (chaos_principles:Skill {id: 'skill-chaos-principles'})
CREATE (game_days)-[:REQUIRES]->(chaos_principles);

// Performance prerequisites
MATCH (load_testing:Skill {id: 'skill-load-testing'}), (linux:Skill {id: 'skill-linux'})
CREATE (load_testing)-[:REQUIRES]->(linux);

MATCH (k6:Skill {id: 'skill-k6'}), (javascript:Skill {id: 'skill-javascript'})
WHERE exists((javascript))
CREATE (k6)-[:REQUIRES]->(javascript);

MATCH (performance_optimization:Skill {id: 'skill-performance-optimization'}), (prometheus:Skill {id: 'skill-prometheus'})
CREATE (performance_optimization)-[:REQUIRES]->(prometheus);

// ========================================
// 9. CREATE SKILL PROGRESSIONS
// ========================================

MATCH (prometheus:Skill {id: 'skill-prometheus'}), (grafana:Skill {id: 'skill-grafana'})
CREATE (prometheus)-[:LEADS_TO]->(grafana);

MATCH (grafana:Skill {id: 'skill-grafana'}), (loki:Skill {id: 'skill-loki'})
CREATE (grafana)-[:LEADS_TO]->(loki);

MATCH (prometheus:Skill {id: 'skill-prometheus'}), (sli_slo:Skill {id: 'skill-sli-slo'})
CREATE (prometheus)-[:LEADS_TO]->(sli_slo);

MATCH (sli_slo:Skill {id: 'skill-sli-slo'}), (capacity_planning:Skill {id: 'skill-capacity-planning'})
CREATE (sli_slo)-[:LEADS_TO]->(capacity_planning);

MATCH (incident_response:Skill {id: 'skill-incident-response'}), (postmortems:Skill {id: 'skill-postmortems'})
CREATE (incident_response)-[:LEADS_TO]->(postmortems);

MATCH (postmortems:Skill {id: 'skill-postmortems'}), (chaos_principles:Skill {id: 'skill-chaos-principles'})
CREATE (postmortems)-[:LEADS_TO]->(chaos_principles);

MATCH (chaos_principles:Skill {id: 'skill-chaos-principles'}), (game_days:Skill {id: 'skill-game-days'})
CREATE (chaos_principles)-[:LEADS_TO]->(game_days);

MATCH (load_testing:Skill {id: 'skill-load-testing'}), (performance_optimization:Skill {id: 'skill-performance-optimization'})
CREATE (load_testing)-[:LEADS_TO]->(performance_optimization);

// ========================================
// 10. CREATE CERTIFICATIONS
// ========================================

CREATE (google_sre:Certification {
    id: 'cert-google-sre',
    name: 'Google Cloud Professional Cloud DevOps Engineer',
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

CREATE (prometheus_cert:Certification {
    id: 'cert-prometheus',
    name: 'Prometheus Certified Associate',
    provider: 'Linux Foundation',
    level: 'associate',
    cost: 250,
    validity_period: '3 years',
    estimated_prep_hours: 40,
    difficulty_rating: 6,
    market_value: 'medium',
    url: 'https://training.linuxfoundation.org/certification/prometheus-certified-associate/',
    exam_format: 'Multiple choice, 90 minutes'
});

CREATE (elastic_observability:Certification {
    id: 'cert-elastic-observability',
    name: 'Elastic Certified Observability Engineer',
    provider: 'Elastic',
    level: 'professional',
    cost: 400,
    validity_period: '2 years',
    estimated_prep_hours: 60,
    difficulty_rating: 7,
    market_value: 'high',
    url: 'https://www.elastic.co/training/certification',
    exam_format: 'Hands-on, 180 minutes'
});

CREATE (datadog_fundamentals:Certification {
    id: 'cert-datadog-fundamentals',
    name: 'Datadog Fundamentals',
    provider: 'Datadog',
    level: 'foundational',
    cost: 150,
    validity_period: '2 years',
    estimated_prep_hours: 20,
    difficulty_rating: 4,
    market_value: 'medium',
    url: 'https://www.datadoghq.com/certification/',
    exam_format: 'Multiple choice, 60 minutes'
});

CREATE (new_relic_practitioner:Certification {
    id: 'cert-new-relic',
    name: 'New Relic Practitioner',
    provider: 'New Relic',
    level: 'associate',
    cost: 150,
    validity_period: '2 years',
    estimated_prep_hours: 25,
    difficulty_rating: 5,
    market_value: 'medium',
    url: 'https://learn.newrelic.com/certification',
    exam_format: 'Multiple choice, 90 minutes'
});

// Connect certifications to skills
MATCH (google_sre:Certification {id: 'cert-google-sre'}), (sli_slo:Skill {id: 'skill-sli-slo'})
CREATE (google_sre)-[:REQUIRES]->(sli_slo);

MATCH (google_sre:Certification {id: 'cert-google-sre'}), (gcp_fundamentals:Skill {id: 'skill-gcp-fundamentals'})
WHERE exists((gcp_fundamentals))
CREATE (google_sre)-[:REQUIRES]->(gcp_fundamentals);

MATCH (prometheus_cert:Certification {id: 'cert-prometheus'}), (prometheus:Skill {id: 'skill-prometheus'})
CREATE (prometheus_cert)-[:REQUIRES]->(prometheus);

MATCH (elastic_observability:Certification {id: 'cert-elastic-observability'}), (elk_stack:Skill {id: 'skill-elk-stack'})
CREATE (elastic_observability)-[:REQUIRES]->(elk_stack);

MATCH (datadog_fundamentals:Certification {id: 'cert-datadog-fundamentals'}), (datadog:Skill {id: 'skill-datadog'})
CREATE (datadog_fundamentals)-[:REQUIRES]->(datadog);

MATCH (new_relic_practitioner:Certification {id: 'cert-new-relic'}), (new_relic:Skill {id: 'skill-new-relic'})
CREATE (new_relic_practitioner)-[:REQUIRES]->(new_relic);

// Connect certifications to domain
MATCH (google_sre:Certification {id: 'cert-google-sre'}), (sre:Domain {id: 'domain-sre'})
CREATE (google_sre)-[:RECOMMENDED_FOR]->(sre);

MATCH (prometheus_cert:Certification {id: 'cert-prometheus'}), (sre:Domain {id: 'domain-sre'})
CREATE (prometheus_cert)-[:RECOMMENDED_FOR]->(sre);

MATCH (elastic_observability:Certification {id: 'cert-elastic-observability'}), (sre:Domain {id: 'domain-sre'})
CREATE (elastic_observability)-[:RECOMMENDED_FOR]->(sre);

// ========================================
// 11. CREATE RESOURCES
// ========================================

// SRE Books
CREATE (sre_book:Resource {
    id: 'res-sre-book',
    title: 'Site Reliability Engineering (Google)',
    url: 'https://sre.google/sre-book/table-of-contents/',
    type: 'book',
    platform: 'Google',
    duration: '40 hours',
    rating: 4.9,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (sre_workbook:Resource {
    id: 'res-sre-workbook',
    title: 'The Site Reliability Workbook',
    url: 'https://sre.google/workbook/table-of-contents/',
    type: 'book',
    platform: 'Google',
    duration: '30 hours',
    rating: 4.8,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// Observability Resources
CREATE (prometheus_docs:Resource {
    id: 'res-prometheus-docs',
    title: 'Prometheus Documentation',
    url: 'https://prometheus.io/docs/',
    type: 'doc',
    platform: 'Prometheus',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (prometheus_course:Resource {
    id: 'res-prometheus-course',
    title: 'Prometheus Monitoring - Complete Guide',
    url: 'https://www.udemy.com/course/prometheus-monitoring/',
    type: 'video',
    platform: 'Udemy',
    duration: '8 hours',
    rating: 4.6,
    price: 'paid',
    difficulty_level: 'beginner',
    learning_style: 'visual'
});

CREATE (grafana_tutorials:Resource {
    id: 'res-grafana-tutorials',
    title: 'Grafana Tutorials',
    url: 'https://grafana.com/tutorials/',
    type: 'tutorial',
    platform: 'Grafana',
    duration: 'self-paced',
    rating: 4.6,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'hands-on'
});

CREATE (opentelemetry_docs:Resource {
    id: 'res-opentelemetry-docs',
    title: 'OpenTelemetry Documentation',
    url: 'https://opentelemetry.io/docs/',
    type: 'doc',
    platform: 'OpenTelemetry',
    duration: 'self-paced',
    rating: 4.4,
    price: 'free',
    difficulty_level: 'advanced',
    learning_style: 'reading'
});

// Chaos Engineering Resources
CREATE (chaos_book:Resource {
    id: 'res-chaos-book',
    title: 'Chaos Engineering (OReilly)',
    url: 'https://www.oreilly.com/library/view/chaos-engineering/9781491988459/',
    type: 'book',
    platform: 'OReilly',
    duration: '20 hours',
    rating: 4.7,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (chaos_toolkit:Resource {
    id: 'res-chaos-toolkit',
    title: 'Chaos Toolkit Documentation',
    url: 'https://chaostoolkit.org/',
    type: 'doc',
    platform: 'Chaos Toolkit',
    duration: 'self-paced',
    rating: 4.3,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// Incident Management Resources
CREATE (incident_handbook:Resource {
    id: 'res-incident-handbook',
    title: 'Incident Management for Operations',
    url: 'https://www.oreilly.com/library/view/incident-management-for/9781491917619/',
    type: 'book',
    platform: 'OReilly',
    duration: '15 hours',
    rating: 4.5,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// Performance Resources
CREATE (k6_docs:Resource {
    id: 'res-k6-docs',
    title: 'k6 Documentation',
    url: 'https://k6.io/docs/',
    type: 'doc',
    platform: 'k6',
    duration: 'self-paced',
    rating: 4.6,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'reading'
});

CREATE (systems_performance:Resource {
    id: 'res-systems-performance',
    title: 'Systems Performance by Brendan Gregg',
    url: 'https://www.brendangregg.com/systems-performance-2nd-edition-book.html',
    type: 'book',
    platform: 'Pearson',
    duration: '50 hours',
    rating: 4.9,
    price: 'paid',
    difficulty_level: 'advanced',
    learning_style: 'reading'
});

// Connect resources to skills
MATCH (sli_slo:Skill {id: 'skill-sli-slo'}), (sre_book:Resource {id: 'res-sre-book'})
CREATE (sli_slo)-[:HAS_RESOURCE]->(sre_book);

MATCH (incident_response:Skill {id: 'skill-incident-response'}), (sre_workbook:Resource {id: 'res-sre-workbook'})
CREATE (incident_response)-[:HAS_RESOURCE]->(sre_workbook);

MATCH (prometheus:Skill {id: 'skill-prometheus'}), (prometheus_docs:Resource {id: 'res-prometheus-docs'})
CREATE (prometheus)-[:HAS_RESOURCE]->(prometheus_docs);

MATCH (prometheus:Skill {id: 'skill-prometheus'}), (prometheus_course:Resource {id: 'res-prometheus-course'})
CREATE (prometheus)-[:HAS_RESOURCE]->(prometheus_course);

MATCH (grafana:Skill {id: 'skill-grafana'}), (grafana_tutorials:Resource {id: 'res-grafana-tutorials'})
CREATE (grafana)-[:HAS_RESOURCE]->(grafana_tutorials);

MATCH (opentelemetry:Skill {id: 'skill-opentelemetry'}), (opentelemetry_docs:Resource {id: 'res-opentelemetry-docs'})
CREATE (opentelemetry)-[:HAS_RESOURCE]->(opentelemetry_docs);

MATCH (chaos_principles:Skill {id: 'skill-chaos-principles'}), (chaos_book:Resource {id: 'res-chaos-book'})
CREATE (chaos_principles)-[:HAS_RESOURCE]->(chaos_book);

MATCH (litmus:Skill {id: 'skill-litmus'}), (chaos_toolkit:Resource {id: 'res-chaos-toolkit'})
CREATE (litmus)-[:HAS_RESOURCE]->(chaos_toolkit);

MATCH (incident_response:Skill {id: 'skill-incident-response'}), (incident_handbook:Resource {id: 'res-incident-handbook'})
CREATE (incident_response)-[:HAS_RESOURCE]->(incident_handbook);

MATCH (k6:Skill {id: 'skill-k6'}), (k6_docs:Resource {id: 'res-k6-docs'})
CREATE (k6)-[:HAS_RESOURCE]->(k6_docs);

MATCH (performance_optimization:Skill {id: 'skill-performance-optimization'}), (systems_performance:Resource {id: 'res-systems-performance'})
CREATE (performance_optimization)-[:HAS_RESOURCE]->(systems_performance);

// ========================================
// CROSS-DOMAIN RELATIONSHIPS
// ========================================

// SRE skills apply to Cloud
MATCH (prometheus:Skill {id: 'skill-prometheus'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (prometheus)-[:APPLIES_IN]->(cloud);

MATCH (disaster_recovery:Skill {id: 'skill-disaster-recovery'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (disaster_recovery)-[:APPLIES_IN]->(cloud);

// SRE skills apply to DevOps
MATCH (prometheus:Skill {id: 'skill-prometheus'}), (devops:Domain {id: 'domain-devops'})
CREATE (prometheus)-[:APPLIES_IN]->(devops);

MATCH (grafana:Skill {id: 'skill-grafana'}), (devops:Domain {id: 'domain-devops'})
CREATE (grafana)-[:APPLIES_IN]->(devops);

// Performance applies to Software Engineering
MATCH (performance_optimization:Skill {id: 'skill-performance-optimization'}), (software:Domain {id: 'domain-software'})
CREATE (performance_optimization)-[:APPLIES_IN]->(software);

// Observability applies to Data Engineering
MATCH (elk_stack:Skill {id: 'skill-elk-stack'}), (data:Domain {id: 'domain-data'})
CREATE (elk_stack)-[:APPLIES_IN]->(data);

// ========================================
// VERIFICATION QUERY
// ========================================
// Run to verify SRE domain is loaded:
// MATCH (d:Domain {id: 'domain-sre'})-[:CONTAINS]->(sd:SubDomain)-[:CONTAINS]->(s:Skill) 
// RETURN d.name, sd.name, count(s) as skill_count;
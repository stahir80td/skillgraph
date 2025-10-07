// ====================================================================================================
// VALIDATION QUERIES FOR SKILL PATH NAVIGATOR
// Run these queries to verify the schema and data are correctly loaded
// ====================================================================================================

// ====================================================================================================
// SECTION 1: NODE COUNTS
// ====================================================================================================

// 1.1 Count all nodes by label
MATCH (n)
RETURN labels(n)[0] AS NodeType, COUNT(n) AS Count
ORDER BY Count DESC;

// 1.2 Verify minimum expected counts
MATCH (d:Domain) WITH COUNT(d) AS domainCount
MATCH (sd:SubDomain) WITH domainCount, COUNT(sd) AS subDomainCount
MATCH (s:Skill) WITH domainCount, subDomainCount, COUNT(s) AS skillCount
MATCH (c:Certification) WITH domainCount, subDomainCount, skillCount, COUNT(c) AS certCount
MATCH (r:Resource) WITH domainCount, subDomainCount, skillCount, certCount, COUNT(r) AS resourceCount
RETURN 
    domainCount AS Domains,
    subDomainCount AS SubDomains,
    skillCount AS Skills,
    certCount AS Certifications,
    resourceCount AS Resources,
    CASE 
        WHEN domainCount >= 7 AND subDomainCount >= 20 AND skillCount >= 40 AND certCount >= 4 
        THEN '✅ PASS' 
        ELSE '❌ FAIL - Missing nodes' 
    END AS Status;

// ====================================================================================================
// SECTION 2: RELATIONSHIP COUNTS
// ====================================================================================================

// 2.1 Count all relationships by type
MATCH ()-[r]->()
RETURN type(r) AS RelationshipType, COUNT(r) AS Count
ORDER BY Count DESC;

// 2.2 Verify critical relationships exist
MATCH ()-[r:REQUIRES]->() WITH COUNT(r) AS requiresCount
MATCH ()-[r:CONTAINS]->() WITH requiresCount, COUNT(r) AS containsCount
MATCH ()-[r:APPLIES_IN]->() WITH requiresCount, containsCount, COUNT(r) AS appliesInCount
MATCH ()-[r:LEADS_TO]->() WITH requiresCount, containsCount, appliesInCount, COUNT(r) AS leadsToCount
RETURN 
    requiresCount AS REQUIRES,
    containsCount AS CONTAINS,
    appliesInCount AS APPLIES_IN,
    leadsToCount AS LEADS_TO,
    CASE 
        WHEN requiresCount >= 15 AND containsCount >= 30 AND appliesInCount >= 10 AND leadsToCount >= 10
        THEN '✅ PASS' 
        ELSE '❌ FAIL - Missing relationships' 
    END AS Status;

// ====================================================================================================
// SECTION 3: DOMAIN VALIDATION
// ====================================================================================================

// 3.1 List all domains with their subdomains
MATCH (d:Domain)-[:CONTAINS]->(sd:SubDomain)
WITH d, COLLECT(sd.name) AS subdomains
RETURN d.name AS Domain, d.id AS DomainId, SIZE(subdomains) AS SubDomainCount, subdomains
ORDER BY d.priority;

// 3.2 Find domains with no subdomains (should be empty)
MATCH (d:Domain)
WHERE NOT (d)-[:CONTAINS]->(:SubDomain)
RETURN d.name AS DomainWithoutSubDomains, '❌ Missing SubDomains' AS Issue;

// ====================================================================================================
// SECTION 4: SKILL VALIDATION
// ====================================================================================================

// 4.1 Skills without prerequisites (should be foundational skills only)
MATCH (s:Skill)
WHERE NOT (s)-[:REQUIRES]->(:Skill)
RETURN s.name AS FoundationalSkill, s.difficulty_level AS Level, s.prereq_level AS PrereqLevel
ORDER BY s.name;

// 4.2 Advanced skills without prerequisites (potential issue)
MATCH (s:Skill)
WHERE s.difficulty_level IN ['intermediate', 'expert'] 
  AND NOT (s)-[:REQUIRES]->(:Skill)
RETURN s.name AS AdvancedSkillWithoutPrereq, s.difficulty_level AS Level, '⚠️ May need prerequisites' AS Issue;

// 4.3 Skills not contained in any subdomain (orphans - should be empty)
MATCH (s:Skill)
WHERE NOT (:SubDomain)-[:CONTAINS]->(s)
RETURN s.name AS OrphanSkill, '❌ Not in any SubDomain' AS Issue;

// 4.4 Skills that apply across multiple domains (cross-cutting skills)
MATCH (s:Skill)-[:APPLIES_IN]->(d:Domain)
WITH s, COLLECT(d.name) AS domains
WHERE SIZE(domains) > 1
RETURN s.name AS CrossDomainSkill, SIZE(domains) AS DomainCount, domains
ORDER BY SIZE(domains) DESC;

// ====================================================================================================
// SECTION 5: LEARNING PATH VALIDATION
// ====================================================================================================

// 5.1 Find the longest learning path
MATCH path = (start:Skill)-[:REQUIRES*]->(end:Skill)
WHERE NOT (end)-[:REQUIRES]->(:Skill)
WITH path, length(path) AS pathLength
ORDER BY pathLength DESC
LIMIT 1
RETURN [node IN nodes(path) | node.name] AS LongestPath, pathLength AS Depth;

// 5.2 Circular dependency check (should be empty)
MATCH (s:Skill)-[:REQUIRES*]->(s)
RETURN s.name AS CircularDependency, '❌ Circular dependency detected' AS Issue;

// 5.3 Skills with both REQUIRES and LEADS_TO relationships (proper progression)
MATCH (s:Skill)
WHERE (s)-[:REQUIRES]->() AND (s)-[:LEADS_TO]->()
RETURN s.name AS WellConnectedSkill, 
       [(s)-[:REQUIRES]->(req) | req.name] AS Prerequisites,
       [(s)-[:LEADS_TO]->(next) | next.name] AS LeadsTo;

// ====================================================================================================
// SECTION 6: CERTIFICATION VALIDATION
// ====================================================================================================

// 6.1 Certifications and their associated skills
MATCH (s:Skill)-[:LEADS_TO]->(c:Certification)
WITH c, COLLECT(s.name) AS skills
RETURN c.name AS Certification, c.provider AS Provider, c.cost AS Cost, skills AS AssociatedSkills
ORDER BY c.name;

// 6.2 Certifications without skills (orphans - should be empty)
MATCH (c:Certification)
WHERE NOT (:Skill)-[:LEADS_TO]->(c)
RETURN c.name AS OrphanCertification, '❌ No skills lead to this cert' AS Issue;

// ====================================================================================================
// SECTION 7: RESOURCE VALIDATION
// ====================================================================================================

// 7.1 Resources by type
MATCH (r:Resource)
RETURN r.type AS ResourceType, COUNT(r) AS Count
ORDER BY Count DESC;

// 7.2 Skills with resources
MATCH (s:Skill)-[:HAS_RESOURCE]->(r:Resource)
WITH s, COLLECT(r.title) AS resources
RETURN s.name AS Skill, SIZE(resources) AS ResourceCount, resources
ORDER BY SIZE(resources) DESC
LIMIT 10;

// 7.3 Skills without resources (may need attention)
MATCH (s:Skill)
WHERE NOT (s)-[:HAS_RESOURCE]->(:Resource)
RETURN s.name AS SkillWithoutResources, '⚠️ No learning resources' AS Issue
ORDER BY s.demand_score DESC;

// ====================================================================================================
// SECTION 8: DATA QUALITY CHECKS
// ====================================================================================================

// 8.1 Check for missing required properties
MATCH (s:Skill)
WHERE s.estimated_hours IS NULL OR s.difficulty_level IS NULL OR s.demand_score IS NULL
RETURN s.name AS SkillWithMissingData, 
       s.estimated_hours AS Hours,
       s.difficulty_level AS Difficulty,
       s.demand_score AS Demand,
       '❌ Missing required properties' AS Issue;

// 8.2 Check for invalid difficulty levels
MATCH (s:Skill)
WHERE NOT s.difficulty_level IN ['beginner', 'intermediate', 'expert']
RETURN s.name AS SkillWithInvalidDifficulty, s.difficulty_level AS InvalidValue, '❌ Invalid difficulty level' AS Issue;

// 8.3 Check prerequisite level consistency
MATCH (s:Skill)
WHERE (s.difficulty_level = 'beginner' AND s.prereq_level > 2)
   OR (s.difficulty_level = 'intermediate' AND s.prereq_level > 3)
   OR (s.difficulty_level = 'expert' AND s.prereq_level < 3)
RETURN s.name AS SkillWithInconsistentLevels, 
       s.difficulty_level AS Difficulty,
       s.prereq_level AS PrereqLevel,
       '⚠️ Inconsistent level mapping' AS Issue;

// ====================================================================================================
// SECTION 9: SPECIFIC DOMAIN CHECKS
// ====================================================================================================

// 9.1 Verify AI/ML domain has proper structure
MATCH (ai:Domain {id: 'domain-ai-ml'})-[:CONTAINS]->(sd:SubDomain)-[:CONTAINS]->(s:Skill)
WITH ai, COUNT(DISTINCT sd) AS subdomains, COUNT(DISTINCT s) AS skills
RETURN ai.name AS Domain, subdomains AS SubDomains, skills AS Skills,
       CASE WHEN subdomains >= 4 AND skills >= 8 THEN '✅ PASS' ELSE '❌ FAIL' END AS Status;

// 9.2 Verify SRE domain has content (was missing in original)
MATCH (sre:Domain {id: 'domain-sre'})-[:CONTAINS]->(sd:SubDomain)-[:CONTAINS]->(s:Skill)
WITH sre, COUNT(DISTINCT sd) AS subdomains, COUNT(DISTINCT s) AS skills
RETURN sre.name AS Domain, subdomains AS SubDomains, skills AS Skills,
       CASE WHEN subdomains >= 3 AND skills >= 4 THEN '✅ PASS' ELSE '❌ FAIL - SRE domain needs more content' END AS Status;

// 9.3 Check cross-domain skills (DevOps skills in multiple domains)
MATCH (s:Skill)-[:APPLIES_IN]->(d:Domain)
WHERE s.id IN ['skill-kubernetes', 'skill-terraform', 'skill-docker']
WITH s.name AS Skill, COLLECT(d.name) AS Domains
RETURN Skill, Domains, SIZE(Domains) AS DomainCount
ORDER BY Skill;

// ====================================================================================================
// SECTION 10: LEARNING PATH EXAMPLES
// ====================================================================================================

// 10.1 Python to ML Engineer path
MATCH path = (python:Skill {id: 'skill-python'})<-[:REQUIRES*]-(ml:Skill {id: 'skill-llm-engineering'})
WITH path, [node IN nodes(path) | node.name] AS skillPath
RETURN 'Python → LLM Engineering' AS Path, LENGTH(path) AS Steps, skillPath AS Skills;

// 10.2 Frontend Developer path
MATCH path = (js:Skill {id: 'skill-javascript'})<-[:REQUIRES*]-(react:Skill {id: 'skill-react'})
WITH path, [node IN nodes(path) | node.name] AS skillPath
RETURN 'JavaScript → React' AS Path, LENGTH(path) AS Steps, skillPath AS Skills;

// 10.3 DevOps Engineer path
MATCH path = (linux:Skill {id: 'skill-linux'})<-[:REQUIRES*]-(k8s:Skill {id: 'skill-kubernetes'})
WITH path, [node IN nodes(path) | node.name] AS skillPath
RETURN 'Linux → Kubernetes' AS Path, LENGTH(path) AS Steps, skillPath AS Skills;

// ====================================================================================================
// SECTION 11: CERTIFICATION READINESS
// ====================================================================================================

// 11.1 Skills needed for AWS Solutions Architect
MATCH (cert:Certification {id: 'cert-aws-sa'})<-[:LEADS_TO]-(skill:Skill)
OPTIONAL MATCH (skill)-[:REQUIRES]->(prereq:Skill)
WITH cert, skill, COLLECT(prereq.name) AS prerequisites
RETURN cert.name AS Certification, skill.name AS DirectSkill, prerequisites AS AlsoNeeded
ORDER BY skill.name;

// 11.2 All certifications with their full skill paths
MATCH (c:Certification)<-[:LEADS_TO]-(s:Skill)
OPTIONAL MATCH path = (s)-[:REQUIRES*]->(prereq:Skill)
WITH c, s, COLLECT(DISTINCT prereq.name) AS allPrereqs
RETURN c.name AS Certification, 
       c.cost AS Cost,
       s.name AS MainSkill,
       SIZE(allPrereqs) + 1 AS TotalSkillsNeeded,
       allPrereqs AS Prerequisites
ORDER BY c.name;

// ====================================================================================================
// SECTION 12: GRAPH STATISTICS SUMMARY
// ====================================================================================================

// 12.1 Complete graph summary
MATCH (d:Domain) WITH COUNT(d) AS domains
MATCH (sd:SubDomain) WITH domains, COUNT(sd) AS subdomains
MATCH (s:Skill) WITH domains, subdomains, COUNT(s) AS skills
MATCH (c:Certification) WITH domains, subdomains, skills, COUNT(c) AS certs
MATCH (r:Resource) WITH domains, subdomains, skills, certs, COUNT(r) AS resources
MATCH ()-[rel]->() WITH domains, subdomains, skills, certs, resources, COUNT(rel) AS relationships
RETURN 
    '=== GRAPH SUMMARY ===' AS Title,
    domains AS Domains,
    subdomains AS SubDomains,
    skills AS Skills,
    certs AS Certifications,
    resources AS Resources,
    relationships AS TotalRelationships,
    CASE 
        WHEN domains >= 7 AND subdomains >= 20 AND skills >= 40 AND relationships >= 100
        THEN '✅ Graph is ready for MVP!' 
        ELSE '⚠️ Graph needs more content' 
    END AS Status;

// ====================================================================================================
// SECTION 13: FIND POTENTIAL ISSUES
// ====================================================================================================

// 13.1 All validation issues in one query
MATCH (n)
WHERE (n:Skill AND NOT (:SubDomain)-[:CONTAINS]->(n))
   OR (n:Skill AND n.difficulty_level IN ['intermediate', 'expert'] AND NOT (n)-[:REQUIRES]->(:Skill))
   OR (n:Certification AND NOT (:Skill)-[:LEADS_TO]->(n))
   OR (n:Resource AND NOT (:Skill)-[:HAS_RESOURCE]->(n))
   OR (n:Domain AND NOT (n)-[:CONTAINS]->(:SubDomain))
RETURN 
    labels(n)[0] AS NodeType,
    n.name AS Name,
    CASE
        WHEN n:Skill AND NOT (:SubDomain)-[:CONTAINS]->(n) THEN 'Orphan skill - not in subdomain'
        WHEN n:Skill AND n.difficulty_level IN ['intermediate', 'expert'] AND NOT (n)-[:REQUIRES]->(:Skill) THEN 'Advanced skill without prerequisites'
        WHEN n:Certification AND NOT (:Skill)-[:LEADS_TO]->(n) THEN 'Orphan certification'
        WHEN n:Resource AND NOT (:Skill)-[:HAS_RESOURCE]->(n) THEN 'Orphan resource'
        WHEN n:Domain AND NOT (n)-[:CONTAINS]->(:SubDomain) THEN 'Domain without subdomains'
        ELSE 'Unknown issue'
    END AS Issue
ORDER BY NodeType, Name;

// ====================================================================================================
// END OF VALIDATION QUERIES
// ====================================================================================================
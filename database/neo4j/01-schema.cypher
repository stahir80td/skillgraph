// ========================================
// SKILL PATH NAVIGATOR - NEO4J SCHEMA
// ========================================
// Run this script first to set up constraints and indexes
// This ensures data integrity and optimizes query performance

// ========================================
// 1. CONSTRAINTS (Ensures uniqueness)
// ========================================

// Domain constraints
CREATE CONSTRAINT domain_id_unique IF NOT EXISTS
FOR (d:Domain) REQUIRE d.id IS UNIQUE;

CREATE CONSTRAINT domain_name_unique IF NOT EXISTS
FOR (d:Domain) REQUIRE d.name IS UNIQUE;

// Skill constraints
CREATE CONSTRAINT skill_id_unique IF NOT EXISTS
FOR (s:Skill) REQUIRE s.id IS UNIQUE;

CREATE CONSTRAINT skill_name_unique IF NOT EXISTS
FOR (s:Skill) REQUIRE s.name IS UNIQUE;

// Resource constraints
CREATE CONSTRAINT resource_id_unique IF NOT EXISTS
FOR (r:Resource) REQUIRE r.id IS UNIQUE;

// Certification constraints
CREATE CONSTRAINT cert_id_unique IF NOT EXISTS
FOR (c:Certification) REQUIRE c.id IS UNIQUE;

CREATE CONSTRAINT cert_name_unique IF NOT EXISTS
FOR (c:Certification) REQUIRE c.name IS UNIQUE;

// Concept constraints (optional nodes)
CREATE CONSTRAINT concept_id_unique IF NOT EXISTS
FOR (co:Concept) REQUIRE co.id IS UNIQUE;

// SubDomain constraints (for hierarchical organization)
CREATE CONSTRAINT subdomain_id_unique IF NOT EXISTS
FOR (sd:SubDomain) REQUIRE sd.id IS UNIQUE;

// ========================================
// 2. INDEXES (Optimizes queries)
// ========================================

// Domain indexes
CREATE INDEX domain_color IF NOT EXISTS
FOR (d:Domain) ON (d.color);

// Skill indexes
CREATE INDEX skill_difficulty IF NOT EXISTS
FOR (s:Skill) ON (s.difficulty_level);

CREATE INDEX skill_hours IF NOT EXISTS
FOR (s:Skill) ON (s.estimated_hours);

CREATE INDEX skill_demand IF NOT EXISTS
FOR (s:Skill) ON (s.demand_score);

CREATE INDEX skill_category IF NOT EXISTS
FOR (s:Skill) ON (s.category);

// Resource indexes
CREATE INDEX resource_type IF NOT EXISTS
FOR (r:Resource) ON (r.type);

CREATE INDEX resource_platform IF NOT EXISTS
FOR (r:Resource) ON (r.platform);

CREATE INDEX resource_price IF NOT EXISTS
FOR (r:Resource) ON (r.price);

CREATE INDEX resource_learning_style IF NOT EXISTS
FOR (r:Resource) ON (r.learning_style);

// Certification indexes
CREATE INDEX cert_provider IF NOT EXISTS
FOR (c:Certification) ON (c.provider);

CREATE INDEX cert_level IF NOT EXISTS
FOR (c:Certification) ON (c.level);

CREATE INDEX cert_cost IF NOT EXISTS
FOR (c:Certification) ON (c.cost);

CREATE INDEX cert_market_value IF NOT EXISTS
FOR (c:Certification) ON (c.market_value);

// SubDomain indexes
CREATE INDEX subdomain_name IF NOT EXISTS
FOR (sd:SubDomain) ON (sd.name);

// ========================================
// 3. NODE PROPERTY EXISTENCE CONSTRAINTS
// ========================================
// Ensures required properties are always present

// Domain required properties
CREATE CONSTRAINT domain_props IF NOT EXISTS
FOR (d:Domain) REQUIRE (d.id, d.name, d.description, d.color) IS NOT NULL;

// Skill required properties
CREATE CONSTRAINT skill_props IF NOT EXISTS
FOR (s:Skill) REQUIRE (s.id, s.name, s.difficulty_level, s.estimated_hours) IS NOT NULL;

// Resource required properties
CREATE CONSTRAINT resource_props IF NOT EXISTS
FOR (r:Resource) REQUIRE (r.id, r.title, r.url, r.type) IS NOT NULL;

// Certification required properties
CREATE CONSTRAINT cert_props IF NOT EXISTS
FOR (c:Certification) REQUIRE (c.id, c.name, c.provider, c.level, c.cost) IS NOT NULL;

// ========================================
// 4. COMPOSITE INDEXES (For complex queries)
// ========================================

// For finding skills by domain and difficulty
CREATE INDEX skill_domain_difficulty IF NOT EXISTS
FOR (s:Skill) ON (s.category, s.difficulty_level);

// For filtering resources by type and price
CREATE INDEX resource_type_price IF NOT EXISTS
FOR (r:Resource) ON (r.type, r.price);

// ========================================
// VERIFICATION QUERIES
// ========================================
// Run these to verify schema creation:

// Check all constraints:
// SHOW CONSTRAINTS;

// Check all indexes:
// SHOW INDEXES;

// ========================================
// NOTES ON RELATIONSHIP TYPES
// ========================================
// The following relationships will be created in the seed data:
// 
// Structural/Hierarchy:
// - (:Domain)-[:CONTAINS]->(:SubDomain)
// - (:SubDomain)-[:CONTAINS]->(:Skill)
// - (:Skill)-[:BELONGS_TO]->(:Domain)
// 
// Learning Paths:
// - (:Skill)-[:REQUIRES]->(:Skill) - Hard prerequisites
// - (:Skill)-[:LEADS_TO]->(:Skill) - Natural progression
// - (:Skill)-[:RELATES_TO]->(:Skill) - Complementary skills
// 
// Cross-Domain:
// - (:Skill)-[:APPLIES_IN]->(:Domain) - Bridge skills
// 
// Resources:
// - (:Skill)-[:HAS_RESOURCE]->(:Resource)
// 
// Certifications:
// - (:Skill)-[:VALIDATES_WITH]->(:Certification)
// - (:Certification)-[:REQUIRES]->(:Skill)
// - (:Certification)-[:LEADS_TO]->(:Certification)
// - (:Certification)-[:RECOMMENDED_FOR]->(:Domain)
// 
// Concepts (Optional):
// - (:Skill)-[:IMPLEMENTS]->(:Concept)
// - (:Concept)-[:FUNDAMENTAL_TO]->(:Domain)
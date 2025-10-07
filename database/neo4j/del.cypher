// ====================================================================================================
// 1. DANGER: WIPE ALL DATA
// ====================================================================================================

// This detaches (deletes relationships) and then deletes ALL nodes in the database.
MATCH (n) DETACH DELETE n;

// ====================================================================================================
// 2. DANGER: WIPE ALL SCHEMA (Constraints and Indexes)
// This requires the APOC plugin to be installed.
// ====================================================================================================

// Drops ALL existing constraints and indexes
CALL apoc.schema.assert({}, {});
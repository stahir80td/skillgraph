const express = require('express');
const neo4j = require('neo4j-driver');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(cors());
app.use(express.json());

// Serve static files in production
if (process.env.NODE_ENV === 'production') {
  // Serve static files from the React app
  app.use(express.static(path.join(__dirname, '../public')));
}

// Neo4j connection
const driver = neo4j.driver(
  process.env.NEO4J_URI,
  neo4j.auth.basic(process.env.NEO4J_USER, process.env.NEO4J_PASSWORD)
);

// Helper function to convert Neo4j integers
const toNumber = (value) => {
  if (value && typeof value === 'object' && 'low' in value && 'high' in value) {
    return value.low;
  }
  return value;
};

// Gemini API configuration
const GEMINI_API_KEY = process.env.GEMINI_API_KEY;
const GEMINI_MODEL = process.env.GEMINI_MODEL || 'gemini-pro-latest';

async function callGemini(prompt) {
  if (!GEMINI_API_KEY) return null;
  
  const url = `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${GEMINI_API_KEY}`;
  
  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        contents: [{
          parts: [{ text: prompt }]
        }]
      })
    });

    if (!response.ok) throw new Error(`Gemini API error: ${response.status}`);
    
    const data = await response.json();
    if (data.candidates && data.candidates[0] && data.candidates[0].content) {
      return data.candidates[0].content.parts[0].text;
    }
    throw new Error('Invalid response from Gemini API');
  } catch (error) {
    console.error('Gemini API call failed:', error.message);
    return null;
  }
}

// Test database connection
async function testConnection() {
  const session = driver.session();
  try {
    const result = await session.run('MATCH (n) RETURN count(n) as count LIMIT 1');
    console.log(`✅ Connected to Neo4j. Database has ${toNumber(result.records[0].get('count'))} nodes.`);
    return true;
  } catch (error) {
    console.error('❌ Failed to connect to Neo4j:', error.message);
    return false;
  } finally {
    await session.close();
  }
}

// Get initial graph with domains only - with better positioning
app.get('/api/graph/initial', async (req, res) => {
  const session = driver.session();
  try {
    // Get all domains with their counts
    const domainsResult = await session.run(`
      MATCH (d:Domain)
      OPTIONAL MATCH (d)-[:CONTAINS]->(sd:SubDomain)
      OPTIONAL MATCH (sd)-[:CONTAINS]->(s:Skill)
      WITH d, count(DISTINCT sd) as subdomainCount, count(DISTINCT s) as skillCount
      RETURN d.id as id, d.name as name, d.description as description, 
             d.color as color, d.icon as icon, d.priority as priority,
             d.market_growth as market_growth, d.avg_salary_range as avg_salary_range,
             subdomainCount, skillCount
      ORDER BY d.priority, d.name
    `);

    const nodes = domainsResult.records.map((record, index) => {
      // Position nodes in a circle for better initial layout
      const angle = (index * 2 * Math.PI) / domainsResult.records.length;
      const radius = 150;
      
      return {
        id: record.get('id'),
        name: record.get('name'),
        description: record.get('description'),
        color: record.get('color') || '#8b5cf6',
        icon: record.get('icon'),
        category: 'domain',
        val: 30,
        x: radius * Math.cos(angle),
        y: radius * Math.sin(angle),
        subdomainCount: toNumber(record.get('subdomainCount')),
        skillCount: toNumber(record.get('skillCount')),
        market_growth: record.get('market_growth'),
        avg_salary_range: record.get('avg_salary_range')
      };
    });

    res.json({ nodes, links: [] });
  } catch (error) {
    console.error('Error fetching initial graph:', error);
    res.status(500).json({ error: 'Failed to fetch graph data' });
  } finally {
    await session.close();
  }
});

// Expand a node to show its children
app.post('/api/graph/expand', async (req, res) => {
  const { nodeId } = req.body;
  const session = driver.session();
  
  try {
    // Determine node type
    const nodeTypeResult = await session.run(
      `MATCH (n) WHERE n.id = $nodeId RETURN labels(n) as labels, n`,
      { nodeId }
    );

    if (nodeTypeResult.records.length === 0) {
      return res.status(404).json({ error: 'Node not found' });
    }

    const labels = nodeTypeResult.records[0].get('labels');
    const nodeType = labels[0];
    const nodes = [];
    const links = [];

    if (nodeType === 'Domain') {
      // Get subdomains and their skills
      const result = await session.run(`
        MATCH (d:Domain {id: $nodeId})-[:CONTAINS]->(sd:SubDomain)
        OPTIONAL MATCH (sd)-[:CONTAINS]->(s:Skill)
        WITH sd, collect(DISTINCT {
          id: s.id,
          name: s.name,
          difficulty_level: s.difficulty_level,
          estimated_hours: s.estimated_hours,
          demand_score: s.demand_score,
          category: s.category
        }) as skills
        RETURN sd.id as id, sd.name as name, sd.description as description,
               sd.order as order, skills
        ORDER BY sd.order, sd.name
      `, { nodeId });

      result.records.forEach((record, index) => {
        const subdomainId = record.get('id');
        
        // Position subdomains around the parent
        const angle = (index * 2 * Math.PI) / result.records.length;
        const radius = 100;
        
        nodes.push({
          id: subdomainId,
          name: record.get('name'),
          description: record.get('description'),
          category: 'subdomain',
          val: 20,
          color: '#3b82f6',
          parentId: nodeId
        });

        links.push({
          source: nodeId,
          target: subdomainId,
          value: 2
        });

        // Add first 3 skills as preview
        const skills = record.get('skills').filter(s => s && s.id);
        skills.slice(0, 3).forEach((skill, skillIndex) => {
          if (!nodes.find(n => n.id === skill.id)) {
            nodes.push({
              id: skill.id,
              name: skill.name,
              category: 'skill',
              difficulty_level: skill.difficulty_level,
              estimated_hours: toNumber(skill.estimated_hours),
              demand_score: toNumber(skill.demand_score),
              val: 10,
              color: skill.difficulty_level === 'beginner' ? '#10b981' :
                     skill.difficulty_level === 'intermediate' ? '#f59e0b' : '#ef4444',
              parentId: subdomainId
            });

            links.push({
              source: subdomainId,
              target: skill.id,
              value: 1
            });
          }
        });
      });
    } else if (nodeType === 'SubDomain') {
      // Get all skills for this subdomain
      const result = await session.run(`
        MATCH (sd:SubDomain {id: $nodeId})-[:CONTAINS]->(s:Skill)
        OPTIONAL MATCH (s)-[:REQUIRES]->(prereq:Skill)
        WITH s, collect(DISTINCT prereq.id) as prerequisites
        RETURN s.id as id, s.name as name, 
               s.difficulty_level as difficulty_level,
               s.estimated_hours as estimated_hours,
               s.demand_score as demand_score,
               s.category as category,
               prerequisites
        ORDER BY s.difficulty_level, s.name
      `, { nodeId });

      result.records.forEach((record, index) => {
        const skillId = record.get('id');
        
        nodes.push({
          id: skillId,
          name: record.get('name'),
          category: 'skill',
          difficulty_level: record.get('difficulty_level'),
          estimated_hours: toNumber(record.get('estimated_hours')),
          demand_score: toNumber(record.get('demand_score')),
          prerequisites: record.get('prerequisites'),
          val: 10,
          color: record.get('difficulty_level') === 'beginner' ? '#10b981' :
                 record.get('difficulty_level') === 'intermediate' ? '#f59e0b' : '#ef4444',
          parentId: nodeId
        });

        links.push({
          source: nodeId,
          target: skillId,
          value: 1
        });
      });
    } else if (nodeType === 'Skill') {
      // Get related skills and prerequisites
      const result = await session.run(`
        MATCH (s:Skill {id: $nodeId})
        OPTIONAL MATCH (s)-[:REQUIRES]->(prereq:Skill)
        OPTIONAL MATCH (s)-[:LEADS_TO]->(next:Skill)
        WITH collect(DISTINCT prereq) as prerequisites,
             collect(DISTINCT next) as nextSkills
        RETURN prerequisites, nextSkills
      `, { nodeId });

      const record = result.records[0];
      
      // Add prerequisite skills
      record.get('prerequisites').forEach(skill => {
        if (skill && skill.properties) {
          const props = skill.properties;
          nodes.push({
            id: props.id,
            name: props.name,
            category: 'skill',
            difficulty_level: props.difficulty_level,
            estimated_hours: toNumber(props.estimated_hours),
            demand_score: toNumber(props.demand_score),
            val: 8,
            color: '#6b7280'
          });
          
          links.push({
            source: props.id,
            target: nodeId,
            value: 1,
            type: 'prerequisite'
          });
        }
      });
      
      // Add next skills
      record.get('nextSkills').forEach(skill => {
        if (skill && skill.properties) {
          const props = skill.properties;
          nodes.push({
            id: props.id,
            name: props.name,
            category: 'skill',
            difficulty_level: props.difficulty_level,
            estimated_hours: toNumber(props.estimated_hours),
            demand_score: toNumber(props.demand_score),
            val: 10,
            color: '#a855f7'
          });
          
          links.push({
            source: nodeId,
            target: props.id,
            value: 1,
            type: 'leads_to'
          });
        }
      });
    }

    res.json({ nodes, links });
  } catch (error) {
    console.error('Error expanding node:', error);
    res.status(500).json({ error: 'Failed to expand node' });
  } finally {
    await session.close();
  }
});

// Enhanced search - finds skills, domains, certifications
app.get('/api/search', async (req, res) => {
  const { query = '', difficulty = 'all', type = 'all' } = req.query;
  
  if (!query.trim()) {
    return res.json([]);
  }
  
  const session = driver.session();

  try {
    // Search across multiple node types including certifications
    let cypher = `
      MATCH (n)
      WHERE (n:Skill OR n:Domain OR n:SubDomain OR n:Certification)
        AND (toLower(n.name) CONTAINS toLower($query) 
             OR toLower(n.description) CONTAINS toLower($query))
    `;

    const params = { query: query.trim() };

    // Apply difficulty filter only to skills
    if (difficulty && difficulty !== 'all') {
      cypher += ` AND (NOT n:Skill OR n.difficulty_level = $difficulty)`;
      params.difficulty = difficulty;
    }

    // Apply type filter
    if (type && type !== 'all') {
      cypher += ` AND labels(n)[0] = $type`;
      params.type = type;
    }

    cypher += `
      OPTIONAL MATCH (n)-[:HAS_RESOURCE]->(r:Resource)
      OPTIONAL MATCH (n)<-[:CONTAINS]-(parent)
      WITH n, labels(n)[0] as nodeType, parent,
           collect(DISTINCT {
             title: r.title,
             url: r.url,
             type: r.type
           }) as resources
      RETURN n.id as id, 
             n.name as name, 
             nodeType,
             n.difficulty_level as difficulty_level,
             n.estimated_hours as estimated_hours,
             n.demand_score as demand_score,
             n.description as description,
             parent.name as parentName,
             resources
      ORDER BY 
        CASE 
          WHEN toLower(n.name) = toLower($query) THEN 0
          WHEN toLower(n.name) STARTS WITH toLower($query) THEN 1
          WHEN toLower(n.name) CONTAINS toLower($query) THEN 2
          ELSE 3
        END,
        n.name
      LIMIT 50
    `;

    const result = await session.run(cypher, params);

    const searchResults = result.records.map(record => ({
      id: record.get('id'),
      name: record.get('name'),
      type: record.get('nodeType'),
      difficulty_level: record.get('difficulty_level'),
      estimated_hours: toNumber(record.get('estimated_hours')),
      demand_score: toNumber(record.get('demand_score')),
      description: record.get('description'),
      parentName: record.get('parentName'),
      resources: (record.get('resources') || []).filter(r => r.title !== null).slice(0, 3),
      category: record.get('nodeType').toLowerCase(),
      val: record.get('nodeType') === 'Domain' ? 30 : 
           record.get('nodeType') === 'SubDomain' ? 20 : 10,
      color: record.get('nodeType') === 'Certification' ? '#ec4899' :
             record.get('nodeType') === 'Domain' ? '#8b5cf6' :
             record.get('nodeType') === 'SubDomain' ? '#3b82f6' :
             record.get('difficulty_level') === 'beginner' ? '#10b981' :
             record.get('difficulty_level') === 'intermediate' ? '#f59e0b' : '#ef4444'
    }));

    res.json(searchResults);
  } catch (error) {
    console.error('Error searching:', error);
    res.status(500).json({ error: 'Search failed' });
  } finally {
    await session.close();
  }
});

// Get node details (works for any node type)
app.get('/api/node/:id', async (req, res) => {
  const { id } = req.params;
  const session = driver.session();

  try {
    const result = await session.run(`
      MATCH (n {id: $id})
      OPTIONAL MATCH (n)-[:REQUIRES]->(prereq)
      OPTIONAL MATCH (n)-[:LEADS_TO]->(next)
      OPTIONAL MATCH (n)-[:HAS_RESOURCE]->(r:Resource)
      OPTIONAL MATCH (n)<-[:CONTAINS]-(parent)
      OPTIONAL MATCH (n)-[:CONTAINS]->(child)
      WITH n, labels(n)[0] as nodeType,
           collect(DISTINCT prereq) as prerequisites,
           collect(DISTINCT next) as nextItems,
           collect(DISTINCT r) as resources,
           collect(DISTINCT child) as children,
           parent
      RETURN n as node, nodeType, prerequisites, nextItems, 
             resources, children, parent
    `, { id });

    if (result.records.length === 0) {
      return res.status(404).json({ error: 'Item not found' });
    }

    const record = result.records[0];
    const node = record.get('node').properties;
    const nodeType = record.get('nodeType');
    const parent = record.get('parent');
    
    // Convert Neo4j integers
    if (node.estimated_hours) node.estimated_hours = toNumber(node.estimated_hours);
    if (node.demand_score) node.demand_score = toNumber(node.demand_score);
    if (node.subdomainCount) node.subdomainCount = toNumber(node.subdomainCount);
    if (node.skillCount) node.skillCount = toNumber(node.skillCount);
    
    // Get or generate resources for skills
    let resources = record.get('resources').map(r => r.properties);
    
    if (resources.length < 2 && nodeType === 'Skill' && GEMINI_API_KEY) {
      const aiPrompt = `Generate 3 learning resources for "${node.name}". Format as JSON array: [{"title":"...","type":"video|tutorial|course","url":"real URL","provider":"...","description":"brief"}]`;
      
      try {
        const aiResponse = await callGemini(aiPrompt);
        if (aiResponse) {
          const jsonMatch = aiResponse.match(/\[[\s\S]*\]/);
          if (jsonMatch) {
            const aiResources = JSON.parse(jsonMatch[0]);
            resources = [...resources, ...aiResources];
          }
        }
      } catch (aiError) {
        console.error('AI resource generation failed:', aiError);
      }
    }

    res.json({
      ...node,
      nodeType,
      parentName: parent ? parent.properties.name : null,
      parentId: parent ? parent.properties.id : null,
      prerequisites: record.get('prerequisites').map(p => {
        const props = p.properties;
        if (props.estimated_hours) props.estimated_hours = toNumber(props.estimated_hours);
        if (props.demand_score) props.demand_score = toNumber(props.demand_score);
        return props;
      }),
      nextItems: record.get('nextItems').map(n => {
        const props = n.properties;
        if (props.estimated_hours) props.estimated_hours = toNumber(props.estimated_hours);
        if (props.demand_score) props.demand_score = toNumber(props.demand_score);
        return props;
      }),
      children: record.get('children').map(c => {
        const props = c.properties;
        if (props.estimated_hours) props.estimated_hours = toNumber(props.estimated_hours);
        return props;
      }),
      resources: resources.slice(0, 5)
    });
  } catch (error) {
    console.error('Error fetching details:', error);
    res.status(500).json({ error: 'Failed to fetch details' });
  } finally {
    await session.close();
  }
});

// Generate study plan
app.post('/api/study-plan', async (req, res) => {
  const { skills, hoursPerWeek = 10, learningStyle = 'mixed' } = req.body;
  
  if (!skills || skills.length === 0) {
    return res.status(400).json({ error: 'No skills provided' });
  }
  
  try {
    const skillNames = skills.map(s => s.name).join(', ');
    const totalHours = skills.reduce((sum, skill) => 
      sum + (skill.estimated_hours || skill.hours || 20), 0
    );
    const weeks = Math.ceil(totalHours / hoursPerWeek);
    
    let studyPlan;
    
    if (GEMINI_API_KEY) {
      const prompt = `Create a detailed ${weeks}-week study plan for learning: ${skillNames}. 
        Total hours: ${totalHours}, ${hoursPerWeek} hours/week, ${learningStyle} style.
        Include week-by-week breakdown with specific goals, resources, and milestones.
        Format as structured markdown.`;

      studyPlan = await callGemini(prompt);
    }
    
    if (!studyPlan) {
      // Detailed fallback plan
      studyPlan = `# 📚 Personalized Study Plan

## Overview
**Skills to Master:** ${skillNames}
**Total Duration:** ${weeks} weeks
**Weekly Commitment:** ${hoursPerWeek} hours
**Total Hours:** ${totalHours}
**Learning Style:** ${learningStyle}

## Weekly Schedule

${skills.map((skill, index) => {
  const skillWeeks = Math.ceil((skill.estimated_hours || 20) / hoursPerWeek);
  const startWeek = index === 0 ? 1 : 
    skills.slice(0, index).reduce((sum, s) => 
      sum + Math.ceil((s.estimated_hours || 20) / hoursPerWeek), 1);
  
  return `### 📌 Weeks ${startWeek}-${startWeek + skillWeeks - 1}: ${skill.name}
**Hours:** ${skill.estimated_hours || 20}
**Difficulty:** ${skill.difficulty_level || 'intermediate'}

#### Week ${startWeek} - Foundation
- [ ] Set up development environment
- [ ] Review prerequisites and fundamentals
- [ ] Complete introductory tutorials
- [ ] Join relevant communities/forums

#### Week ${startWeek + Math.floor(skillWeeks/2)} - Core Concepts
- [ ] Deep dive into main concepts
- [ ] Build sample projects
- [ ] Practice with exercises
- [ ] Document learnings

#### Week ${startWeek + skillWeeks - 1} - Mastery
- [ ] Complete capstone project
- [ ] Review and fill knowledge gaps
- [ ] Prepare for certification (if applicable)
- [ ] Update portfolio with projects
`;
}).join('\n')}

## 🎯 Milestones
- **Week 1:** Environment setup and learning plan review
- **Week ${Math.floor(weeks/4)}:** First skill checkpoint
- **Week ${Math.floor(weeks/2)}:** Mid-point review and adjustment
- **Week ${Math.floor(3*weeks/4)}:** Integration project
- **Week ${weeks}:** Final project and skills assessment

## 📚 Recommended Resources
1. Official documentation for each technology
2. Interactive coding platforms (Codecademy, freeCodeCamp)
3. Video courses (YouTube, Udemy, Coursera)
4. Books and technical blogs
5. Open source projects for practice

## ✅ Success Tips
- **Consistency:** Maintain daily practice, even if just 30 minutes
- **Projects:** Build real projects to solidify learning
- **Community:** Join Discord/Slack communities for support
- **Documentation:** Keep a learning journal
- **Balance:** Take breaks to avoid burnout
- **Review:** Regularly revisit previous topics

## 📊 Progress Tracking
- Weekly self-assessments
- Project completions
- Peer code reviews
- Knowledge checks
- Portfolio updates
`;
    }

    res.json({
      plan: studyPlan,
      totalHours,
      estimatedWeeks: weeks,
      skills
    });
  } catch (error) {
    console.error('Error generating study plan:', error);
    res.status(500).json({ error: 'Failed to generate study plan' });
  }
});

// Filter graph by difficulty level
app.post('/api/graph/filter', async (req, res) => {
  const { difficulty = 'all' } = req.body;
  const session = driver.session();
  
  try {
    let cypher;
    const params = {};
    
    if (difficulty === 'all') {
      // Return domains for 'all' filter
      cypher = `
        MATCH (d:Domain)
        RETURN d.id as id, d.name as name, d.color as color,
               d.description as description, 'domain' as category
      `;
    } else {
      // Return skills matching difficulty
      cypher = `
        MATCH (s:Skill {difficulty_level: $difficulty})
        OPTIONAL MATCH (s)<-[:CONTAINS]-(sd:SubDomain)<-[:CONTAINS]-(d:Domain)
        RETURN s.id as id, s.name as name, 
               s.difficulty_level as difficulty_level,
               s.estimated_hours as estimated_hours,
               'skill' as category,
               sd.id as subdomainId, sd.name as subdomainName,
               d.id as domainId, d.name as domainName
        LIMIT 100
      `;
      params.difficulty = difficulty;
    }
    
    const result = await session.run(cypher, params);
    
    const nodes = [];
    const links = [];
    const addedNodes = new Set();
    
    result.records.forEach(record => {
      const nodeId = record.get('id');
      const category = record.get('category');
      
      if (!addedNodes.has(nodeId)) {
        addedNodes.add(nodeId);
        
        if (category === 'domain') {
          nodes.push({
            id: nodeId,
            name: record.get('name'),
            category: 'domain',
            description: record.get('description'),
            color: record.get('color') || '#8b5cf6',
            val: 30
          });
        } else {
          // Add skill
          nodes.push({
            id: nodeId,
            name: record.get('name'),
            category: 'skill',
            difficulty_level: record.get('difficulty_level'),
            estimated_hours: toNumber(record.get('estimated_hours')),
            color: difficulty === 'beginner' ? '#10b981' :
                   difficulty === 'intermediate' ? '#f59e0b' : '#ef4444',
            val: 10
          });
          
          // Add parent nodes if they exist
          const subdomainId = record.get('subdomainId');
          const domainId = record.get('domainId');
          
          if (subdomainId && !addedNodes.has(subdomainId)) {
            addedNodes.add(subdomainId);
            nodes.push({
              id: subdomainId,
              name: record.get('subdomainName'),
              category: 'subdomain',
              color: '#3b82f6',
              val: 20
            });
          }
          
          if (domainId && !addedNodes.has(domainId)) {
            addedNodes.add(domainId);
            nodes.push({
              id: domainId,
              name: record.get('domainName'),
              category: 'domain',
              color: '#8b5cf6',
              val: 30
            });
          }
          
          // Add links
          if (subdomainId) {
            links.push({
              source: subdomainId,
              target: nodeId,
              value: 1
            });
            
            if (domainId) {
              links.push({
                source: domainId,
                target: subdomainId,
                value: 2
              });
            }
          }
        }
      }
    });
    
    res.json({ nodes, links });
  } catch (error) {
    console.error('Error filtering graph:', error);
    res.status(500).json({ error: 'Failed to filter graph' });
  } finally {
    await session.close();
  }
});

// Health check endpoint
app.get('/api/health', async (req, res) => {
  const neo4jConnected = await testConnection();
  res.json({
    status: 'ok',
    neo4j: neo4jConnected,
    gemini: !!GEMINI_API_KEY,
    timestamp: new Date().toISOString()
  });
});

// Serve React app for all non-API routes in production
if (process.env.NODE_ENV === 'production') {
  app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, '../public', 'index.html'));
  });
}

// Start server
app.listen(PORT, async () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`📝 Environment: ${process.env.NODE_ENV || 'development'}`);
  await testConnection();
  if (GEMINI_API_KEY) {
    console.log(`🤖 Gemini AI enabled with model: ${GEMINI_MODEL}`);
  } else {
    console.log('⚠️ Gemini AI not configured (optional)');
  }
});

// Graceful shutdown
process.on('SIGINT', async () => {
  console.log('\nShutting down gracefully...');
  await driver.close();
  process.exit(0);
});
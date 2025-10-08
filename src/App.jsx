import React, { useState, useEffect, useRef } from 'react';
import CytoscapeComponent from 'react-cytoscapejs';
import Cytoscape from 'cytoscape';
import dagre from 'cytoscape-dagre';
import axios from 'axios';
import StudyPlanViewer from './StudyPlanViewer';
import './App.css';

// Register the dagre layout
Cytoscape.use(dagre);

const API_URL = import.meta.env.VITE_API_URL || '/api';

// ====================================
// BREADCRUMB COMPONENT (OUTSIDE APP)
// ====================================
const Breadcrumb = ({ path, onNavigate }) => {
  if (!path || path.length === 0) return null;

  return (
    <div className="breadcrumb">
      <span className="breadcrumb-item" onClick={() => onNavigate(0)}>
        🏠 Home
      </span>
      {path.map((item, index) => (
        <React.Fragment key={`${item.id}-${index}`}>
          <span className="breadcrumb-separator">›</span>
          <span 
            className="breadcrumb-item"
            onClick={() => onNavigate(index + 1)}
          >
            {item.name}
          </span>
        </React.Fragment>
      ))}
    </div>
  );
};

// ====================================
// LANDING PAGE COMPONENT (OUTSIDE APP)
// ====================================
const LandingPage = ({ onGetStarted }) => (
  <div className="landing-container">
    <nav className="landing-nav">
      <div className="logo">⚡ SkillPath Navigator</div>
      <div className="nav-links">
        <a className="nav-link" onClick={onGetStarted}>Launch App</a>
        <a className="nav-link" href="#features">Features</a>
        <a className="nav-link" href="https://github.com/stahir80td/skillgraph" target="_blank" rel="noopener noreferrer">GitHub</a>
      </div>
    </nav>
    
    <section className="hero-section">
      <h1 className="hero-title">Navigate Your Tech Career</h1>
      <p className="hero-subtitle">
        Explore skills, build learning paths, and track your progress with intelligent skill navigation system (Neo4j + Gemini + React + Node.js)
      </p>
      <button className="cta-button" onClick={onGetStarted}>
        Get Started →
      </button>
    </section>
    
    <section id="features" className="features-grid">
      <div className="feature-card">
        <div className="feature-icon">🗺️</div>
        <h3>Interactive Exploration</h3>
        <p>Visualize skill relationships and prerequisites in an intuitive graph view</p>
      </div>
      <div className="feature-card">
        <div className="feature-icon">🔍</div>
        <h3>Smart Search</h3>
        <p>Find skills and certifications quickly with powerful filtering options</p>
      </div>
      <div className="feature-card">
        <div className="feature-icon">📚</div>
        <h3>Learning Paths</h3>
        <p>Build custom learning paths and get AI-generated study plans</p>
      </div>
      <div className="feature-card">
        <div className="feature-icon">📊</div>
        <h3>Progress Tracking</h3>
        <p>Monitor your learning journey with detailed progress analytics</p>
      </div>
    </section>
  </div>
);

// ====================================
// MAIN APP COMPONENT (OUTSIDE APP)
// ====================================
const MainApp = ({ 
  currentView, 
  setCurrentView,
  graphElements,
  handleNodeClick,
  selectedItem,
  setSelectedItem,
  searchQuery,
  setSearchQuery,
  handleSearch,
  learningPath,
  addToPath,
  removeFromPath,
  completedSkills,
  markComplete,
  loading,
  filters,
  setFilters,
  searchResults,
  totalPathHours,
  hoursPerWeek,
  setHoursPerWeek,
  generateStudyPlan,
  studyPlanModal,
  setStudyPlanModal,
  detailsPanelItem,
  setDetailsPanelItem,
  openDetailsPanel,
  navigationPath,
  handleBreadcrumbClick,
  onBackToLanding,
  cyRef
}) => (
  <div className="app-container">
    {/* Header */}
    <header className="app-header">
      <div className="header-left">
        <div className="logo" onClick={onBackToLanding}>
          ⚡ SkillPath
        </div>
        <nav className="view-tabs">
          <button 
            className={`view-tab ${currentView === 'explore' ? 'active' : ''}`}
            onClick={() => setCurrentView('explore')}
          >
            <span className="tab-icon">🗺️</span>
            Explore
          </button>
          <button 
            className={`view-tab ${currentView === 'search' ? 'active' : ''}`}
            onClick={() => setCurrentView('search')}
          >
            <span className="tab-icon">🔍</span>
            Search
          </button>
          <button 
            className={`view-tab ${currentView === 'path' ? 'active' : ''}`}
            onClick={() => setCurrentView('path')}
          >
            <span className="tab-icon">📚</span>
            My Path
          </button>
        </nav>
      </div>
      
      <div className="header-right">
        <div className="search-bar">
          <input
            type="text"
            placeholder="Search skills, certifications..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && handleSearch()}
            className="search-input"
          />
          <button onClick={handleSearch} className="search-button">
            Search
          </button>
        </div>
        <div className="path-indicator">
          <span className="path-count">{learningPath.length}</span>
          <span className="path-label">in path</span>
        </div>
      </div>
    </header>

    {/* Main Content Area */}
    <div className="main-content">
      {loading && (
        <div className="loading-overlay">
          <div className="spinner"></div>
          <p>Loading...</p>
        </div>
      )}

      {/* Explore View */}
      {currentView === 'explore' && (
        <div className="explore-view">
          {console.log('🟣 RENDERING EXPLORE VIEW, selectedItem:', selectedItem)}
          <div className="graph-container">
            {/* Breadcrumb Navigation */}
            <Breadcrumb path={navigationPath} onNavigate={handleBreadcrumbClick} />
            
            <CytoscapeComponent
              elements={graphElements}
              style={{ width: '100%', height: '100%' }}
              cy={(cy) => {
                cyRef.current = cy;
                cy.on('tap', 'node', (evt) => handleNodeClick(evt.target));
              }}
              layout={{ 
                name: 'concentric',
                concentric: (node) => {
                  const category = node.data('category');
                  return category === 'domain' ? 3 : category === 'subdomain' ? 2 : 1;
                },
                levelWidth: () => 1,
                padding: 50,
                animate: true,
                animationDuration: 500
              }}
              stylesheet={[
                {
                  selector: 'node',
                  style: {
                    'label': 'data(label)',
                    'text-valign': 'center',
                    'text-halign': 'center',
                    'background-color': 'data(color)',
                    'color': '#ffffff',
                    'text-outline-color': '#000000',
                    'text-outline-width': 2,
                    'width': (ele) => {
                      const cat = ele.data('category');
                      return cat === 'domain' ? 80 : cat === 'subdomain' ? 60 : 40;
                    },
                    'height': (ele) => {
                      const cat = ele.data('category');
                      return cat === 'domain' ? 80 : cat === 'subdomain' ? 60 : 40;
                    },
                    'font-size': (ele) => {
                      const cat = ele.data('category');
                      return cat === 'domain' ? '14px' : cat === 'subdomain' ? '12px' : '10px';
                    },
                    'font-weight': 'bold'
                  }
                },
                {
                  selector: 'edge',
                  style: {
                    'width': 2,
                    'line-color': '#71717a',
                    'target-arrow-color': '#71717a',
                    'target-arrow-shape': 'triangle',
                    'curve-style': 'bezier'
                  }
                },
                {
                  selector: 'node:selected',
                  style: {
                    'border-width': 4,
                    'border-color': '#8b5cf6'
                  }
                }
              ]}
            />
          </div>
          
          {/* Right Panel - Selected Item Details */}
          {selectedItem && (
            <div className="detail-sidebar">
              <div className="detail-header">
                <h2>{selectedItem.name || selectedItem.label}</h2>
                <button 
                  className="close-btn"
                  onClick={() => setSelectedItem(null)}
                >×</button>
              </div>
              <div className="detail-content">
                {selectedItem.category && (
                  <p className="detail-type">{selectedItem.category}</p>
                )}
                {selectedItem.description && (
                  <p className="detail-description">{selectedItem.description}</p>
                )}
                {selectedItem.estimated_hours && (
                  <p className="detail-info">
                    <strong>Duration:</strong> {selectedItem.estimated_hours} hours
                  </p>
                )}
                {selectedItem.difficulty_level && (
                  <p className="detail-info">
                    <strong>Difficulty:</strong> {selectedItem.difficulty_level}
                  </p>
                )}
                {selectedItem.demand_score && (
                  <p className="detail-info">
                    <strong>Demand Score:</strong> {selectedItem.demand_score}/10
                  </p>
                )}
                
                <div className="detail-actions">
                  <button 
                    className="btn-primary"
                    onClick={() => addToPath(selectedItem)}
                    disabled={learningPath.find(i => i.id === selectedItem.id)}
                  >
                    {learningPath.find(i => i.id === selectedItem.id)
                      ? 'Added to Path' 
                      : 'Add to Path'}
                  </button>
                  {selectedItem.category === 'skill' && (
                    <button 
                      className={`btn-secondary ${completedSkills.includes(selectedItem.id) ? 'completed' : ''}`}
                      onClick={() => markComplete(selectedItem.id)}
                    >
                      {completedSkills.includes(selectedItem.id) 
                        ? '✓ Completed' 
                        : 'Mark Complete'}
                    </button>
                  )}
                </div>
              </div>
            </div>
          )}
        </div>
      )}

      {/* Search View */}
      {currentView === 'search' && (
        <div className="search-view">
          <div className="search-filters">
            <select 
              value={filters.category}
              onChange={(e) => setFilters({...filters, category: e.target.value})}
              className="filter-select"
            >
              <option value="all">All Categories</option>
              <option value="Skill">Skills</option>
              <option value="Certification">Certifications</option>
              <option value="Domain">Domains</option>
            </select>
            
            <select 
              value={filters.difficulty}
              onChange={(e) => setFilters({...filters, difficulty: e.target.value})}
              className="filter-select"
            >
              <option value="all">All Levels</option>
              <option value="beginner">Beginner</option>
              <option value="intermediate">Intermediate</option>
              <option value="expert">Expert</option>
            </select>
            
            <select 
              value={filters.sortBy}
              onChange={(e) => setFilters({...filters, sortBy: e.target.value})}
              className="filter-select"
            >
              <option value="relevance">Relevance</option>
              <option value="hours">Duration</option>
              <option value="difficulty">Difficulty</option>
              <option value="demand">Demand</option>
            </select>
          </div>
          
          <div className="search-results-grid">
            {searchResults.length === 0 && !loading ? (
              <div className="empty-results">
                <p>No results found. Try a different search term.</p>
              </div>
            ) : (
              searchResults
                .filter(item => filters.category === 'all' || item.type === filters.category)
                .sort((a, b) => {
                  if (filters.sortBy === 'hours') return (a.estimated_hours || 0) - (b.estimated_hours || 0);
                  if (filters.sortBy === 'demand') return (b.demand_score || 0) - (a.demand_score || 0);
                  return 0;
                })
                .map(item => (
                  <div key={item.id} className="result-card">
                    <div className="card-header">
                      <h3>{item.name}</h3>
                      <span className={`type-badge ${item.type}`}>{item.type}</span>
                    </div>
                    <p className="card-description">{item.description}</p>
                    <div className="card-meta">
                      {item.difficulty_level && (
                        <span className={`difficulty-badge ${item.difficulty_level}`}>
                          {item.difficulty_level}
                        </span>
                      )}
                      {item.estimated_hours && (
                        <span className="hours-badge">
                          {item.estimated_hours}h
                        </span>
                      )}
                      {item.demand_score && (
                        <span className="demand-badge">
                          Demand: {item.demand_score}/10
                        </span>
                      )}
                    </div>
                    <div className="card-actions">
                      <button 
                        className="btn-add"
                        onClick={() => addToPath(item)}
                        disabled={learningPath.find(i => i.id === item.id)}
                      >
                        {learningPath.find(i => i.id === item.id) ? '✓ Added' : '+ Add to Path'}
                      </button>
                      <button 
                        className="btn-details"
                        onClick={() => openDetailsPanel(item)}
                      >
                        Details
                      </button>
                    </div>
                  </div>
                ))
            )}
          </div>
        </div>
      )}

      {/* Path View */}
      {currentView === 'path' && (
        <div className="path-view">
          <div className="path-header">
            <h2>My Learning Path</h2>
            <div className="path-summary">
              <span>{learningPath.length} skills</span>
              <span>{totalPathHours} total hours</span>
              <span>{Math.ceil(totalPathHours / hoursPerWeek)} weeks @ {hoursPerWeek}h/week</span>
            </div>
          </div>
          
          {learningPath.length === 0 ? (
            <div className="empty-path">
              <p>Your learning path is empty</p>
              <button 
                className="btn-primary"
                onClick={() => setCurrentView('search')}
              >
                Browse Skills
              </button>
            </div>
          ) : (
            <>
              <div className="path-timeline">
                {learningPath.map((item, index) => (
                  <div key={item.id} className="timeline-item">
                    <div className="timeline-marker">{index + 1}</div>
                    <div className="timeline-content">
                      <h3>{item.name}</h3>
                      <div className="timeline-meta">
                        <span>{item.hours}h</span>
                        {item.difficulty_level && (
                          <span className={`difficulty-badge ${item.difficulty_level}`}>
                            {item.difficulty_level}
                          </span>
                        )}
                      </div>
                      <div className="timeline-actions">
                        <button 
                          className={`btn-complete ${completedSkills.includes(item.id) ? 'completed' : ''}`}
                          onClick={() => markComplete(item.id)}
                        >
                          {completedSkills.includes(item.id) ? '✓' : '○'}
                        </button>
                        <button 
                          className="btn-remove"
                          onClick={() => removeFromPath(item.id)}
                        >
                          Remove
                        </button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
              
              <div className="path-actions">
                <div className="hours-input-group">
                  <label>Hours per week:</label>
                  <input
                    type="number"
                    min="1"
                    max="40"
                    value={hoursPerWeek}
                    onChange={(e) => setHoursPerWeek(parseInt(e.target.value) || 10)}
                  />
                </div>
                <button 
                  className="btn-generate"
                  onClick={generateStudyPlan}
                >
                  Generate Study Plan
                </button>
              </div>
            </>
          )}
        </div>
      )}
    </div>

    {/* Study Plan Modal */}
    {studyPlanModal && (
      <StudyPlanViewer 
        studyPlanData={studyPlanModal} 
        onClose={() => setStudyPlanModal(null)} 
      />
    )}
  </div>
);

// ====================================
// MAIN APP FUNCTION
// ====================================
function App() {
  const [currentPage, setCurrentPage] = useState('landing');
  const [currentView, setCurrentView] = useState('explore');
  const [graphElements, setGraphElements] = useState([]);
  const [searchResults, setSearchResults] = useState([]);
  const [selectedItem, setSelectedItem] = useState(null);
  const [searchQuery, setSearchQuery] = useState('');
  const [learningPath, setLearningPath] = useState([]);
  const [loading, setLoading] = useState(false);
  const [filters, setFilters] = useState({
    difficulty: 'all',
    category: 'all',
    sortBy: 'relevance'
  });
  const [completedSkills, setCompletedSkills] = useState(() => {
    const saved = localStorage.getItem('completedSkills');
    return saved ? JSON.parse(saved) : [];
  });
  const [studyPlanModal, setStudyPlanModal] = useState(null);
  const [hoursPerWeek, setHoursPerWeek] = useState(10);
  const [detailsPanelItem, setDetailsPanelItem] = useState(null);
  
  // Navigation state - FIXED
  const [navigationPath, setNavigationPath] = useState([]); // [{id, name, type}]
  
  const cyRef = useRef(null);

  // Load domains on app start
  useEffect(() => {
    if (currentPage === 'app' && currentView === 'explore' && navigationPath.length === 0) {
      loadDomains();
    }
  }, [currentPage, currentView]);

  const loadDomains = async () => {
    setLoading(true);
    try {
      const response = await axios.get(`${API_URL}/graph/initial`);
      const nodes = response.data.nodes.map(node => ({
        data: { 
          id: node.id, 
          label: node.name,
          name: node.name,
          category: 'domain',
          color: node.color || '#8b5cf6',
          description: node.description,
          ...node 
        }
      }));
      
      setGraphElements(nodes);
      setNavigationPath([]);
      setSelectedItem(null);
    } catch (error) {
      console.error('Failed to load domains:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleNodeClick = async (node) => {
    const nodeData = node.data();
    
    console.log('🔵 NODE CLICKED:', nodeData);
    
    // ALWAYS show details for ANY node click - FIXED
    const itemData = {
      id: nodeData.id,
      name: nodeData.name || nodeData.label,
      label: nodeData.label || nodeData.name,
      category: nodeData.category,
      description: nodeData.description,
      estimated_hours: nodeData.estimated_hours,
      difficulty_level: nodeData.difficulty_level,
      demand_score: nodeData.demand_score
    };
    
    console.log('🟢 SETTING SELECTED ITEM:', itemData);
    setSelectedItem(itemData);
    
    // If it's a domain or subdomain, ALSO expand it
    if (nodeData.category === 'domain' || nodeData.category === 'subdomain') {
      setLoading(true);
      try {
        const response = await axios.post(`${API_URL}/graph/expand`, { 
          nodeId: nodeData.id 
        });
        
        // REPLACE graph elements
        const newNodes = response.data.nodes.map(n => ({
          data: { 
            id: n.id, 
            label: n.name,
            name: n.name,
            category: n.category,
            color: n.color || '#8b5cf6',
            description: n.description,
            difficulty_level: n.difficulty_level,
            estimated_hours: n.estimated_hours,
            demand_score: n.demand_score,
            ...n 
          }
        }));
        
        // FIXED: Only add to path if not already there
        const isAlreadyInPath = navigationPath.some(item => item.id === nodeData.id);
        
        if (!isAlreadyInPath) {
          const newPath = [...navigationPath, {
            id: nodeData.id,
            name: nodeData.name || nodeData.label,
            type: nodeData.category
          }];
          setNavigationPath(newPath);
        }
        
        setGraphElements(newNodes);
        
        // Re-run layout
        if (cyRef.current) {
          setTimeout(() => {
            cyRef.current.layout({ 
              name: 'concentric',
              concentric: (node) => {
                const category = node.data('category');
                return category === 'domain' ? 3 : category === 'subdomain' ? 2 : 1;
              },
              levelWidth: () => 1,
              padding: 50,
              animate: true,
              animationDuration: 500
            }).run();
          }, 100);
        }
      } catch (error) {
        console.error('Failed to expand node:', error);
      } finally {
        setLoading(false);
      }
    }
  };

  const handleBreadcrumbClick = async (level) => {
    if (level === 0) {
      // Back to domains
      loadDomains();
    } else {
      // Navigate back to specific level
      const targetPath = navigationPath.slice(0, level);
      const targetNode = navigationPath[level - 1];
      
      if (targetNode) {
        setLoading(true);
        try {
          const response = await axios.post(`${API_URL}/graph/expand`, { 
            nodeId: targetNode.id 
          });
          
          const newNodes = response.data.nodes.map(n => ({
            data: { 
              id: n.id, 
              label: n.name,
              name: n.name,
              category: n.category,
              color: n.color || '#8b5cf6',
              description: n.description,
              difficulty_level: n.difficulty_level,
              estimated_hours: n.estimated_hours,
              demand_score: n.demand_score,
              ...n 
            }
          }));
          
          setGraphElements(newNodes);
          setNavigationPath(targetPath);
          setSelectedItem(null);
          
          if (cyRef.current) {
            setTimeout(() => {
              cyRef.current.layout({ 
                name: 'concentric',
                concentric: (node) => {
                  const category = node.data('category');
                  return category === 'domain' ? 3 : category === 'subdomain' ? 2 : 1;
                },
                levelWidth: () => 1,
                padding: 50,
                animate: true,
                animationDuration: 500
              }).run();
            }, 100);
          }
        } catch (error) {
          console.error('Failed to navigate:', error);
        } finally {
          setLoading(false);
        }
      }
    }
  };

  const handleSearch = async () => {
    if (!searchQuery.trim()) return;
    
    setLoading(true);
    setCurrentView('search');
    
    try {
      const response = await axios.get(`${API_URL}/search`, {
        params: { 
          query: searchQuery.trim(),
          difficulty: filters.difficulty !== 'all' ? filters.difficulty : undefined
        }
      });
      
      setSearchResults(response.data);
    } catch (error) {
      console.error('Search failed:', error);
      setSearchResults([]);
    } finally {
      setLoading(false);
    }
  };

  const addToPath = (item) => {
    if (!learningPath.find(i => i.id === item.id)) {
      setLearningPath([...learningPath, {
        ...item,
        hours: item.estimated_hours || 20
      }]);
    }
  };

  const removeFromPath = (itemId) => {
    setLearningPath(learningPath.filter(i => i.id !== itemId));
  };

  const generateStudyPlan = async () => {
    if (learningPath.length === 0) {
      alert('Please add skills to your learning path first');
      return;
    }
    
    setLoading(true);
    try {
      const response = await axios.post(`${API_URL}/study-plan`, {
        skills: learningPath,
        hoursPerWeek,
        learningStyle: 'mixed'
      });
      setStudyPlanModal({
        ...response.data,
        skills: learningPath // Pass the skills array to the viewer
      });
    } catch (error) {
      console.error('Failed to generate study plan:', error);
    } finally {
      setLoading(false);
    }
  };

  const markComplete = (skillId) => {
    const updated = completedSkills.includes(skillId)
      ? completedSkills.filter(id => id !== skillId)
      : [...completedSkills, skillId];
    setCompletedSkills(updated);
    localStorage.setItem('completedSkills', JSON.stringify(updated));
  };

  const openDetailsPanel = async (item) => {
    setSelectedItem(item);
    setCurrentView('explore');
  };

  const totalPathHours = learningPath.reduce((sum, item) => sum + (item.hours || 0), 0);

  return currentPage === 'landing' ? (
    <LandingPage onGetStarted={() => setCurrentPage('app')} />
  ) : (
    <MainApp 
      currentView={currentView}
      setCurrentView={setCurrentView}
      graphElements={graphElements}
      handleNodeClick={handleNodeClick}
      selectedItem={selectedItem}
      setSelectedItem={setSelectedItem}
      searchQuery={searchQuery}
      setSearchQuery={setSearchQuery}
      handleSearch={handleSearch}
      learningPath={learningPath}
      addToPath={addToPath}
      removeFromPath={removeFromPath}
      completedSkills={completedSkills}
      markComplete={markComplete}
      loading={loading}
      filters={filters}
      setFilters={setFilters}
      searchResults={searchResults}
      totalPathHours={totalPathHours}
      hoursPerWeek={hoursPerWeek}
      setHoursPerWeek={setHoursPerWeek}
      generateStudyPlan={generateStudyPlan}
      studyPlanModal={studyPlanModal}
      setStudyPlanModal={setStudyPlanModal}
      detailsPanelItem={detailsPanelItem}
      setDetailsPanelItem={setDetailsPanelItem}
      openDetailsPanel={openDetailsPanel}
      navigationPath={navigationPath}
      handleBreadcrumbClick={handleBreadcrumbClick}
      onBackToLanding={() => setCurrentPage('landing')}
      cyRef={cyRef}
    />
  );
}

export default App;
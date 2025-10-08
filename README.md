# 🎯 SkillGraph Navigator

<div align="center">
  
  ![SkillGraph Banner](https://img.shields.io/badge/SkillGraph-Interactive%20Skill%20Visualization-8b5cf6?style=for-the-badge)
  
  [![Node.js](https://img.shields.io/badge/Node.js-18+-339933?style=flat-square&logo=node.js&logoColor=white)](https://nodejs.org)
  [![React](https://img.shields.io/badge/React-18+-61DAFB?style=flat-square&logo=react&logoColor=black)](https://reactjs.org)
  [![Neo4j](https://img.shields.io/badge/Neo4j-5+-008CC1?style=flat-square&logo=neo4j&logoColor=white)](https://neo4j.com)
  [![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](LICENSE)
  
  **Navigate your tech career path with an intelligent, interactive skill visualization system**
  
  [Demo](#-demo) • [Features](#-features) • [Installation](#-installation) • [Tech Stack](#-tech-stack) • [API](#-api-endpoints)
  
</div>

---

## 🌟 Overview

SkillGraph Navigator is a comprehensive learning path visualization platform that transforms how developers explore, plan, and track their technical skill development. Built with Neo4j graph database, React, and Node.js, it provides an interactive 3D visualization of skills, their relationships, prerequisites, and learning progressions across multiple tech domains.

### 🎬 Demo

<div align="center">
  
  ![SkillGraph Demo](https://img.shields.io/badge/Live%20Demo-Coming%20Soon-orange?style=for-the-badge)
  
</div>

## ✨ Features

### 🗺️ **Interactive Skill Exploration**
- **3D Graph Visualization**: Navigate through 250+ interconnected skills using Cytoscape.js
- **Domain-Based Navigation**: Explore skills organized into 7 major tech domains:
  - 🤖 AI & Machine Learning
  - ☁️ Cloud & Infrastructure  
  - ♾️ DevOps & Platform Engineering
  - 📊 Data Engineering
  - 💻 Software Engineering
  - 🔐 Security & Compliance
  - 🚀 Site Reliability Engineering

### 🔍 **Smart Search & Discovery**
- **Multi-faceted Search**: Find skills by name, difficulty, domain, or technology
- **Intelligent Filtering**: Filter by difficulty level (Beginner, Intermediate, Expert)
- **Resource Discovery**: Access curated learning resources for each skill

### 📚 **Learning Path Management**
- **Custom Path Builder**: Create personalized learning paths tailored to your goals
- **AI-Powered Study Plans**: Generate detailed study plans using Google Gemini AI
- **Progress Tracking**: Mark skills as completed and track your learning journey
- **Time Estimation**: Get realistic time estimates for skill acquisition

### 🎯 **Advanced Features**
- **Prerequisite Mapping**: Understand skill dependencies and optimal learning sequences
- **Certification Tracking**: Connect skills to industry certifications (AWS, Azure, GCP, etc.)
- **Resource Aggregation**: Access documentation, courses, and tutorials for each skill
- **Breadcrumb Navigation**: Never lose your place in the skill graph

## 🛠️ Tech Stack

### Backend
- **Node.js & Express**: RESTful API server
- **Neo4j**: Graph database for skill relationships
- **Google Gemini AI**: AI-powered study plan generation
- **Cypher**: Graph query language

### Frontend  
- **React 18**: Component-based UI
- **Cytoscape.js**: Graph visualization library
- **Vite**: Build tool and dev server
- **CSS3**: Modern styling with custom animations

### Data Layer
- **250+ Skills**: Comprehensive skill database
- **50+ Certifications**: Industry certification mappings
- **200+ Resources**: Curated learning materials
- **Complex Relationships**: Prerequisites, progressions, and cross-domain applications

## 📦 Installation

### Prerequisites
- Node.js 18+ and npm/yarn
- Neo4j Database (v5+)
- Google Gemini API key (optional, for AI features)

### 🚀 Quick Start

1. **Clone the repository**
```bash
git clone https://github.com/stahir80td/skillgraph.git
cd skillgraph
```

2. **Set up the backend**
```bash
# Install dependencies
npm install

# Configure environment variables
cp .env.example .env
```

Edit `.env` with your configuration:
```env
NEO4J_URI=neo4j://localhost:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=your_password
GEMINI_API_KEY=your_gemini_api_key (optional)
PORT=3001
```

3. **Set up the database**
```bash
# Import the schema and seed data into Neo4j
# Run the schema-seed.cypher file in Neo4j Browser or cypher-shell
```

4. **Set up the frontend**
```bash
cd frontend
npm install

# Configure API endpoint
echo "VITE_API_URL=http://localhost:3001/api" > .env.local
```

5. **Start the application**
```bash
# Terminal 1: Start the backend
npm run dev

# Terminal 2: Start the frontend
cd frontend
npm run dev
```

6. **Access the application**
- Frontend: http://localhost:5173
- Backend API: http://localhost:3001/api

## 📡 API Endpoints

### Graph Operations
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/graph/initial` | Get initial domain-level graph |
| POST | `/api/graph/expand` | Expand a node to show children |
| POST | `/api/graph/filter` | Filter graph by difficulty |

### Search & Discovery
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/search` | Search skills with filters |
| GET | `/api/node/:id` | Get detailed node information |

### Learning Path
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/study-plan` | Generate AI-powered study plan |

### System
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/health` | Health check endpoint |

## 🗂️ Project Structure

```
skillgraph/
├── index.js                 # Express server & API routes
├── schema-seed.cypher      # Neo4j database schema & data
├── frontend/
│   ├── src/
│   │   ├── App.jsx         # Main React component
│   │   ├── App.css         # Application styles
│   │   ├── StudyPlanViewer.jsx  # Study plan component
│   │   └── main.jsx        # React entry point
│   └── package.json
├── .env.example            # Environment variables template
└── package.json
```

## 🎨 Key Components

### 1. **Interactive Graph Visualization**
- Cytoscape.js integration for smooth graph rendering
- Color-coded nodes by difficulty and domain
- Expandable/collapsible node hierarchy
- Real-time graph updates

### 2. **Study Plan Generator**
- AI-powered plan generation using Google Gemini
- Week-by-week breakdown with milestones
- Resource recommendations
- Progress tracking integration

### 3. **Neo4j Graph Schema**
- **Nodes**: Skills, Domains, SubDomains, Certifications, Resources, Concepts
- **Relationships**: CONTAINS, REQUIRES, LEADS_TO, HAS_RESOURCE, APPLIES_IN
- **Properties**: Difficulty levels, time estimates, demand scores

## 🔧 Configuration

### Database Schema
The Neo4j database uses a comprehensive graph model:
- **7 Domains** with subdomains
- **250+ Skills** with prerequisites and progressions
- **50+ Certifications** linked to skills
- **200+ Learning Resources**

### Environment Variables
| Variable | Description | Required |
|----------|-------------|----------|
| `NEO4J_URI` | Neo4j connection URI | Yes |
| `NEO4J_USER` | Neo4j username | Yes |
| `NEO4J_PASSWORD` | Neo4j password | Yes |
| `GEMINI_API_KEY` | Google Gemini API key | No |
| `PORT` | Server port (default: 3001) | No |

## 📈 Performance Optimization

- **Lazy Loading**: Nodes expand on-demand to minimize initial load
- **Efficient Queries**: Optimized Cypher queries with proper indexing
- **Caching**: Client-side caching of expanded nodes
- **Debounced Search**: Reduces API calls during typing

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 🐛 Known Issues

- Graph visualization may be performance-intensive with all nodes expanded
- Some mobile browsers may have limited graph interaction capabilities
- AI study plan generation requires Gemini API key

## 🗺️ Roadmap

- [ ] User authentication and personal progress saving
- [ ] Social features (share learning paths, achievements)
- [ ] Mobile app development
- [ ] Additional AI features (skill recommendations, gap analysis)
- [ ] Integration with learning platforms (Coursera, Udemy, etc.)
- [ ] Real-time collaboration on learning paths
- [ ] Gamification elements (badges, streaks, leaderboards)

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Neo4j for the powerful graph database
- Cytoscape.js for graph visualization
- React and Vite communities
- All contributors and testers

## 📧 Contact

[@stahir80td](https://github.com/stahir80td)

Project Link: [https://github.com/stahir80td/skillgraph](https://github.com/stahir80td/skillgraph)


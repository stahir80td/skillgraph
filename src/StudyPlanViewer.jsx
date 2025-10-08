import React, { useState } from 'react';
import './StudyPlanViewer.css';

const StudyPlanViewer = ({ studyPlanData, onClose }) => {
  const [expandedSections, setExpandedSections] = useState({});
  
  if (!studyPlanData) return null;

  const { plan, totalHours, estimatedWeeks, skills } = studyPlanData;

  // Enhanced markdown rendering with proper multiple list support
  const renderMarkdown = (text) => {
    if (!text) return null;
    
    let html = text
      .replace(/^### (.*$)/gim, '<h3>$1</h3>')
      .replace(/^## (.*$)/gim, '<h2>$1</h2>')
      .replace(/^# (.*$)/gim, '<h1>$1</h1>')
      .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')
      .replace(/\*(.+?)\*/g, '<em>$1</em>')
      .replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2" target="_blank" rel="noopener noreferrer">$1</a>')
      .replace(/\n\n/g, '</p><p>')
      .replace(/\n/g, '<br/>');

    // Handle unordered and ordered lists
    html = html
      // Convert markdown list syntax into HTML list items
      .replace(/(^|\n)(\*|-|\d+\.) (.+?)(?=\n|$)/g, '$1<li>$3</li>')
      // Wrap consecutive <li> items in <ul> or <ol>
      .replace(/(<li>.*?<\/li>)/gs, (match) => {
        // Count numeric list markers to detect ordered lists
        const isOrdered = /\d+\./.test(match);
        return isOrdered ? `<ol>${match}</ol>` : `<ul>${match}</ul>`;
      });

    if (!html.startsWith('<')) html = `<p>${html}</p>`;
    
    return <div className="markdown-content" dangerouslySetInnerHTML={{ __html: html }} />;
  };

  // Parse markdown sections
  const parseStudyPlan = (markdown) => {
    const sections = [];
    const lines = markdown.split('\n');
    let currentSection = null;
    let currentContent = [];

    lines.forEach(line => {
      if (line.startsWith('## ')) {
        if (currentSection) {
          sections.push({
            ...currentSection,
            content: currentContent.join('\n')
          });
        }
        currentSection = {
          title: line.replace('## ', '').trim(),
          level: 2
        };
        currentContent = [];
      } else {
        currentContent.push(line);
      }
    });

    if (currentSection) {
      sections.push({
        ...currentSection,
        content: currentContent.join('\n')
      });
    }

    return sections;
  };

  const sections = parseStudyPlan(plan);

  const toggleSection = (index) => {
    setExpandedSections(prev => ({
      ...prev,
      [index]: !prev[index]
    }));
  };

  const getIconForSection = (title) => {
    if (title.includes('Overview')) return '📋';
    if (title.includes('Schedule')) return '📅';
    if (title.includes('Milestones')) return '🎯';
    if (title.includes('Resources')) return '📚';
    if (title.includes('Tips')) return '💡';
    if (title.includes('Tracking')) return '📊';
    return '📌';
  };

  const getDifficultyColor = (difficulty) => {
    if (!difficulty) return '#8b5cf6';
    const level = difficulty.toLowerCase();
    if (level.includes('beginner')) return '#10b981';
    if (level.includes('intermediate')) return '#f59e0b';
    if (level.includes('expert') || level.includes('advanced')) return '#ef4444';
    return '#8b5cf6';
  };

  return (
    <div className="study-plan-overlay">
      <div className="study-plan-container">
        {/* Header */}
        <div className="study-plan-header no-print">
          <div className="header-content">
            <h1>📚 Your Personalized Study Plan</h1>
            <div className="header-stats">
              <div className="stat-item">
                <span className="stat-value">{estimatedWeeks}</span>
                <span className="stat-label">Weeks</span>
              </div>
              <div className="stat-item">
                <span className="stat-value">{totalHours}</span>
                <span className="stat-label">Hours</span>
              </div>
              <div className="stat-item">
                <span className="stat-value">{skills.length}</span>
                <span className="stat-label">Skills</span>
              </div>
            </div>
          </div>
          <button className="btn-close-plan" onClick={onClose}>
            ✕
          </button>
        </div>

        {/* Print Header */}
        <div className="print-only print-header">
          <h1>📚 Personalized Study Plan</h1>
          <div className="print-stats">
            <span>{estimatedWeeks} Weeks</span> • 
            <span>{totalHours} Hours</span> • 
            <span>{skills.length} Skills</span>
          </div>
        </div>

        {/* Add notice component if it exists */}
        {studyPlanData.noticeComponent && (
          <div style={{ padding: '0 2rem' }}>
            {studyPlanData.noticeComponent}
          </div>
        )}

        {/* Skills Overview */}
        <div className="skills-overview">
          <h2>🎯 Skills You'll Master</h2>
          <div className="skills-grid">
            {skills.map((skill, index) => (
              <div 
                key={skill.id} 
                className="skill-card"
                style={{ borderLeft: `4px solid ${getDifficultyColor(skill.difficulty_level)}` }}
              >
                <div className="skill-header">
                  <span className="skill-number">{index + 1}</span>
                  <h3>{skill.name}</h3>
                </div>
                <div className="skill-meta">
                  <span className={`difficulty-tag ${skill.difficulty_level || 'intermediate'}`}>
                    {skill.difficulty_level || 'intermediate'}
                  </span>
                  <span className="hours-tag">{skill.hours || skill.estimated_hours || 20}h</span>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Study Plan Content */}
        <div className="study-plan-content">
          {sections.map((section, index) => {
            const isExpanded = expandedSections[index] !== false;
            const icon = getIconForSection(section.title);

            return (
              <div key={index} className="plan-section">
                <div className="section-header" onClick={() => toggleSection(index)}>
                  <div className="section-title">
                    <span className="section-icon">{icon}</span>
                    <h2>{section.title}</h2>
                  </div>
                  <button className="toggle-btn no-print">
                    {isExpanded ? '▼' : '▶'}
                  </button>
                </div>

                {isExpanded && (
                  <div className="section-content">
                    {renderMarkdown(section.content)}
                  </div>
                )}
              </div>
            );
          })}
        </div>

        {/* Footer */}
        <div className="study-plan-footer">
          <p>💪 Stay consistent, track your progress, and celebrate small wins!</p>
          <p className="footer-note">Generated by SkillPath Navigator</p>
        </div>
      </div>
    </div>
  );
};

export default StudyPlanViewer;

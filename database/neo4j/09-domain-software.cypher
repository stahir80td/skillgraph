// ========================================
// SKILL PATH NAVIGATOR - SOFTWARE ENGINEERING DOMAIN
// ========================================
// Run AFTER base domains script
// Creates complete Software Engineering skill tree with Frontend, Backend, Mobile, and Full-Stack

// ========================================
// 1. CREATE SUBDOMAINS
// ========================================

CREATE (frontend:SubDomain {
    id: 'sub-frontend',
    name: 'Frontend Development',
    description: 'React, Vue, Angular, UI/UX, responsive design',
    order: 1
});

CREATE (backend:SubDomain {
    id: 'sub-backend',
    name: 'Backend Development',
    description: 'APIs, databases, server-side logic, microservices',
    order: 2
});

CREATE (mobile:SubDomain {
    id: 'sub-mobile',
    name: 'Mobile Development',
    description: 'iOS, Android, React Native, Flutter',
    order: 3
});

CREATE (fullstack:SubDomain {
    id: 'sub-fullstack',
    name: 'Full-Stack Development',
    description: 'End-to-end application development',
    order: 4
});

CREATE (architecture:SubDomain {
    id: 'sub-architecture',
    name: 'Software Architecture',
    description: 'System design, patterns, microservices, event-driven',
    order: 5
});

// Connect to domain
MATCH (software:Domain {id: 'domain-software'}), (frontend:SubDomain {id: 'sub-frontend'})
CREATE (software)-[:CONTAINS]->(frontend);

MATCH (software:Domain {id: 'domain-software'}), (backend:SubDomain {id: 'sub-backend'})
CREATE (software)-[:CONTAINS]->(backend);

MATCH (software:Domain {id: 'domain-software'}), (mobile:SubDomain {id: 'sub-mobile'})
CREATE (software)-[:CONTAINS]->(mobile);

MATCH (software:Domain {id: 'domain-software'}), (fullstack:SubDomain {id: 'sub-fullstack'})
CREATE (software)-[:CONTAINS]->(fullstack);

MATCH (software:Domain {id: 'domain-software'}), (architecture:SubDomain {id: 'sub-architecture'})
CREATE (software)-[:CONTAINS]->(architecture);

// ========================================
// 2. CREATE FRONTEND SKILLS
// ========================================

CREATE (html_css:Skill {
    id: 'skill-html-css',
    name: 'HTML & CSS',
    description: 'Semantic HTML, CSS3, Flexbox, Grid, responsive design',
    difficulty_level: 'beginner',
    estimated_hours: 40,
    demand_score: 8,
    category: 'frontend',
    last_updated: date('2025-01-15')
});

CREATE (javascript:Skill {
    id: 'skill-javascript',
    name: 'JavaScript',
    description: 'ES6+, DOM manipulation, async/await, modules',
    difficulty_level: 'beginner',
    estimated_hours: 100,
    demand_score: 10,
    category: 'frontend',
    market_insights: 'Foundation for all modern web development',
    last_updated: date('2025-01-15')
});

CREATE (typescript:Skill {
    id: 'skill-typescript',
    name: 'TypeScript',
    description: 'Type-safe JavaScript, interfaces, generics',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 9,
    category: 'frontend',
    market_insights: 'Industry standard for large-scale apps',
    last_updated: date('2025-01-15')
});

CREATE (react:Skill {
    id: 'skill-react',
    name: 'React',
    description: 'Components, hooks, state management, React Router',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 10,
    category: 'frontend',
    market_insights: 'Most popular frontend framework',
    last_updated: date('2025-01-15')
});

CREATE (nextjs:Skill {
    id: 'skill-nextjs',
    name: 'Next.js',
    description: 'Full-stack React framework, SSR, SSG, API routes',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 9,
    category: 'frontend',
    market_insights: 'Leading React meta-framework',
    last_updated: date('2025-01-15')
});

CREATE (vue:Skill {
    id: 'skill-vue',
    name: 'Vue.js',
    description: 'Reactive components, Composition API, Vuex',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 7,
    category: 'frontend',
    last_updated: date('2025-01-15')
});

CREATE (angular:Skill {
    id: 'skill-angular',
    name: 'Angular',
    description: 'TypeScript framework, RxJS, dependency injection',
    difficulty_level: 'intermediate',
    estimated_hours: 70,
    demand_score: 7,
    category: 'frontend',
    last_updated: date('2025-01-15')
});

CREATE (tailwind:Skill {
    id: 'skill-tailwind',
    name: 'Tailwind CSS',
    description: 'Utility-first CSS framework',
    difficulty_level: 'beginner',
    estimated_hours: 15,
    demand_score: 8,
    category: 'frontend',
    market_insights: 'Rapidly growing adoption',
    last_updated: date('2025-01-15')
});

CREATE (frontend_testing:Skill {
    id: 'skill-frontend-testing',
    name: 'Frontend Testing',
    description: 'Jest, React Testing Library, Cypress, E2E testing',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'frontend',
    last_updated: date('2025-01-15')
});

// ========================================
// 3. CREATE BACKEND SKILLS
// ========================================

CREATE (nodejs:Skill {
    id: 'skill-nodejs',
    name: 'Node.js',
    description: 'JavaScript runtime, npm, event loop, streams',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 9,
    category: 'backend',
    last_updated: date('2025-01-15')
});

CREATE (express:Skill {
    id: 'skill-express',
    name: 'Express.js',
    description: 'Node.js web framework, middleware, routing',
    difficulty_level: 'beginner',
    estimated_hours: 25,
    demand_score: 8,
    category: 'backend',
    last_updated: date('2025-01-15')
});

CREATE (golang:Skill {
    id: 'skill-golang',
    name: 'Go (Golang)',
    description: 'Concurrent programming, goroutines, channels',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 8,
    category: 'backend',
    market_insights: 'Popular for cloud-native and microservices',
    last_updated: date('2025-01-15')
});

CREATE (java_spring:Skill {
    id: 'skill-java-spring',
    name: 'Java Spring Boot',
    description: 'Enterprise Java, dependency injection, Spring ecosystem',
    difficulty_level: 'intermediate',
    estimated_hours: 80,
    demand_score: 8,
    category: 'backend',
    market_insights: 'Enterprise standard',
    last_updated: date('2025-01-15')
});

CREATE (dotnet:Skill {
    id: 'skill-dotnet',
    name: '.NET Core/C#',
    description: 'ASP.NET Core, Entity Framework, LINQ',
    difficulty_level: 'intermediate',
    estimated_hours: 80,
    demand_score: 8,
    category: 'backend',
    last_updated: date('2025-01-15')
});

CREATE (rust:Skill {
    id: 'skill-rust',
    name: 'Rust',
    description: 'Systems programming, memory safety, concurrency',
    difficulty_level: 'advanced',
    estimated_hours: 100,
    demand_score: 7,
    category: 'backend',
    market_insights: 'Growing for performance-critical systems',
    last_updated: date('2025-01-15')
});

CREATE (api_design:Skill {
    id: 'skill-api-design',
    name: 'API Design',
    description: 'REST, GraphQL, gRPC, OpenAPI, versioning',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 9,
    category: 'backend',
    last_updated: date('2025-01-15')
});

CREATE (databases:Skill {
    id: 'skill-databases',
    name: 'Database Design',
    description: 'PostgreSQL, MySQL, MongoDB, Redis, migrations',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 9,
    category: 'backend',
    last_updated: date('2025-01-15')
});

// ========================================
// 4. CREATE MOBILE SKILLS
// ========================================

CREATE (react_native:Skill {
    id: 'skill-react-native',
    name: 'React Native',
    description: 'Cross-platform mobile with React, Expo',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 8,
    category: 'mobile',
    market_insights: 'Popular for cross-platform development',
    last_updated: date('2025-01-15')
});

CREATE (flutter:Skill {
    id: 'skill-flutter',
    name: 'Flutter',
    description: 'Dart language, Material Design, cross-platform',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 8,
    category: 'mobile',
    market_insights: 'Growing rapidly, backed by Google',
    last_updated: date('2025-01-15')
});

CREATE (swift:Skill {
    id: 'skill-swift',
    name: 'Swift & iOS',
    description: 'SwiftUI, UIKit, Xcode, App Store deployment',
    difficulty_level: 'intermediate',
    estimated_hours: 80,
    demand_score: 8,
    category: 'mobile',
    last_updated: date('2025-01-15')
});

CREATE (kotlin:Skill {
    id: 'skill-kotlin',
    name: 'Kotlin & Android',
    description: 'Jetpack Compose, Android Studio, Play Store',
    difficulty_level: 'intermediate',
    estimated_hours: 80,
    demand_score: 7,
    category: 'mobile',
    last_updated: date('2025-01-15')
});

CREATE (mobile_testing:Skill {
    id: 'skill-mobile-testing',
    name: 'Mobile Testing',
    description: 'Appium, XCTest, Espresso, device testing',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 7,
    category: 'mobile',
    last_updated: date('2025-01-15')
});

// ========================================
// 5. CREATE FULL-STACK & ARCHITECTURE SKILLS
// ========================================

CREATE (fullstack_frameworks:Skill {
    id: 'skill-fullstack-frameworks',
    name: 'Full-Stack Frameworks',
    description: 'Next.js, Nuxt, SvelteKit, Remix',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 8,
    category: 'fullstack',
    last_updated: date('2025-01-15')
});

CREATE (websockets:Skill {
    id: 'skill-websockets',
    name: 'Real-time Communication',
    description: 'WebSockets, Socket.io, WebRTC, SSE',
    difficulty_level: 'intermediate',
    estimated_hours: 35,
    demand_score: 7,
    category: 'fullstack',
    last_updated: date('2025-01-15')
});

CREATE (microservices:Skill {
    id: 'skill-microservices',
    name: 'Microservices Architecture',
    description: 'Service decomposition, API gateway, service mesh',
    difficulty_level: 'advanced',
    estimated_hours: 80,
    demand_score: 8,
    category: 'architecture',
    last_updated: date('2025-01-15')
});

CREATE (event_driven:Skill {
    id: 'skill-event-driven',
    name: 'Event-Driven Architecture',
    description: 'Message queues, event sourcing, CQRS',
    difficulty_level: 'advanced',
    estimated_hours: 60,
    demand_score: 7,
    category: 'architecture',
    last_updated: date('2025-01-15')
});

CREATE (system_design:Skill {
    id: 'skill-system-design',
    name: 'System Design',
    description: 'Scalability, reliability, distributed systems',
    difficulty_level: 'advanced',
    estimated_hours: 100,
    demand_score: 9,
    category: 'architecture',
    market_insights: 'Critical for senior roles',
    last_updated: date('2025-01-15')
});

CREATE (design_patterns:Skill {
    id: 'skill-design-patterns',
    name: 'Design Patterns',
    description: 'GoF patterns, SOLID principles, clean architecture',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 8,
    category: 'architecture',
    last_updated: date('2025-01-15')
});

// ========================================
// 6. CONNECT SKILLS TO SUBDOMAINS
// ========================================

// Frontend connections
MATCH (frontend:SubDomain {id: 'sub-frontend'}), (html_css:Skill {id: 'skill-html-css'})
CREATE (frontend)-[:CONTAINS]->(html_css);

MATCH (frontend:SubDomain {id: 'sub-frontend'}), (javascript:Skill {id: 'skill-javascript'})
CREATE (frontend)-[:CONTAINS]->(javascript);

MATCH (frontend:SubDomain {id: 'sub-frontend'}), (typescript:Skill {id: 'skill-typescript'})
CREATE (frontend)-[:CONTAINS]->(typescript);

MATCH (frontend:SubDomain {id: 'sub-frontend'}), (react:Skill {id: 'skill-react'})
CREATE (frontend)-[:CONTAINS]->(react);

MATCH (frontend:SubDomain {id: 'sub-frontend'}), (nextjs:Skill {id: 'skill-nextjs'})
CREATE (frontend)-[:CONTAINS]->(nextjs);

MATCH (frontend:SubDomain {id: 'sub-frontend'}), (vue:Skill {id: 'skill-vue'})
CREATE (frontend)-[:CONTAINS]->(vue);

MATCH (frontend:SubDomain {id: 'sub-frontend'}), (angular:Skill {id: 'skill-angular'})
CREATE (frontend)-[:CONTAINS]->(angular);

MATCH (frontend:SubDomain {id: 'sub-frontend'}), (tailwind:Skill {id: 'skill-tailwind'})
CREATE (frontend)-[:CONTAINS]->(tailwind);

MATCH (frontend:SubDomain {id: 'sub-frontend'}), (frontend_testing:Skill {id: 'skill-frontend-testing'})
CREATE (frontend)-[:CONTAINS]->(frontend_testing);

// Backend connections
MATCH (backend:SubDomain {id: 'sub-backend'}), (nodejs:Skill {id: 'skill-nodejs'})
CREATE (backend)-[:CONTAINS]->(nodejs);

MATCH (backend:SubDomain {id: 'sub-backend'}), (express:Skill {id: 'skill-express'})
CREATE (backend)-[:CONTAINS]->(express);

MATCH (backend:SubDomain {id: 'sub-backend'}), (golang:Skill {id: 'skill-golang'})
CREATE (backend)-[:CONTAINS]->(golang);

MATCH (backend:SubDomain {id: 'sub-backend'}), (java_spring:Skill {id: 'skill-java-spring'})
CREATE (backend)-[:CONTAINS]->(java_spring);

MATCH (backend:SubDomain {id: 'sub-backend'}), (dotnet:Skill {id: 'skill-dotnet'})
CREATE (backend)-[:CONTAINS]->(dotnet);

MATCH (backend:SubDomain {id: 'sub-backend'}), (rust:Skill {id: 'skill-rust'})
CREATE (backend)-[:CONTAINS]->(rust);

MATCH (backend:SubDomain {id: 'sub-backend'}), (api_design:Skill {id: 'skill-api-design'})
CREATE (backend)-[:CONTAINS]->(api_design);

MATCH (backend:SubDomain {id: 'sub-backend'}), (databases:Skill {id: 'skill-databases'})
CREATE (backend)-[:CONTAINS]->(databases);

// Mobile connections
MATCH (mobile:SubDomain {id: 'sub-mobile'}), (react_native:Skill {id: 'skill-react-native'})
CREATE (mobile)-[:CONTAINS]->(react_native);

MATCH (mobile:SubDomain {id: 'sub-mobile'}), (flutter:Skill {id: 'skill-flutter'})
CREATE (mobile)-[:CONTAINS]->(flutter);

MATCH (mobile:SubDomain {id: 'sub-mobile'}), (swift:Skill {id: 'skill-swift'})
CREATE (mobile)-[:CONTAINS]->(swift);

MATCH (mobile:SubDomain {id: 'sub-mobile'}), (kotlin:Skill {id: 'skill-kotlin'})
CREATE (mobile)-[:CONTAINS]->(kotlin);

MATCH (mobile:SubDomain {id: 'sub-mobile'}), (mobile_testing:Skill {id: 'skill-mobile-testing'})
CREATE (mobile)-[:CONTAINS]->(mobile_testing);

// Full-stack connections
MATCH (fullstack:SubDomain {id: 'sub-fullstack'}), (fullstack_frameworks:Skill {id: 'skill-fullstack-frameworks'})
CREATE (fullstack)-[:CONTAINS]->(fullstack_frameworks);

MATCH (fullstack:SubDomain {id: 'sub-fullstack'}), (websockets:Skill {id: 'skill-websockets'})
CREATE (fullstack)-[:CONTAINS]->(websockets);

// Architecture connections
MATCH (architecture:SubDomain {id: 'sub-architecture'}), (microservices:Skill {id: 'skill-microservices'})
CREATE (architecture)-[:CONTAINS]->(microservices);

MATCH (architecture:SubDomain {id: 'sub-architecture'}), (event_driven:Skill {id: 'skill-event-driven'})
CREATE (architecture)-[:CONTAINS]->(event_driven);

MATCH (architecture:SubDomain {id: 'sub-architecture'}), (system_design:Skill {id: 'skill-system-design'})
CREATE (architecture)-[:CONTAINS]->(system_design);

MATCH (architecture:SubDomain {id: 'sub-architecture'}), (design_patterns:Skill {id: 'skill-design-patterns'})
CREATE (architecture)-[:CONTAINS]->(design_patterns);

// ========================================
// 7. CREATE SKILL PREREQUISITES
// ========================================

// Frontend prerequisites
MATCH (javascript:Skill {id: 'skill-javascript'}), (html_css:Skill {id: 'skill-html-css'})
CREATE (javascript)-[:REQUIRES]->(html_css);

MATCH (typescript:Skill {id: 'skill-typescript'}), (javascript:Skill {id: 'skill-javascript'})
CREATE (typescript)-[:REQUIRES]->(javascript);

MATCH (react:Skill {id: 'skill-react'}), (javascript:Skill {id: 'skill-javascript'})
CREATE (react)-[:REQUIRES]->(javascript);

MATCH (nextjs:Skill {id: 'skill-nextjs'}), (react:Skill {id: 'skill-react'})
CREATE (nextjs)-[:REQUIRES]->(react);

MATCH (vue:Skill {id: 'skill-vue'}), (javascript:Skill {id: 'skill-javascript'})
CREATE (vue)-[:REQUIRES]->(javascript);

MATCH (angular:Skill {id: 'skill-angular'}), (typescript:Skill {id: 'skill-typescript'})
CREATE (angular)-[:REQUIRES]->(typescript);

MATCH (tailwind:Skill {id: 'skill-tailwind'}), (html_css:Skill {id: 'skill-html-css'})
CREATE (tailwind)-[:REQUIRES]->(html_css);

MATCH (frontend_testing:Skill {id: 'skill-frontend-testing'}), (javascript:Skill {id: 'skill-javascript'})
CREATE (frontend_testing)-[:REQUIRES]->(javascript);

// Backend prerequisites
MATCH (nodejs:Skill {id: 'skill-nodejs'}), (javascript:Skill {id: 'skill-javascript'})
CREATE (nodejs)-[:REQUIRES]->(javascript);

MATCH (express:Skill {id: 'skill-express'}), (nodejs:Skill {id: 'skill-nodejs'})
CREATE (express)-[:REQUIRES]->(nodejs);

MATCH (databases:Skill {id: 'skill-databases'}), (sql:Skill {id: 'skill-sql'})
CREATE (databases)-[:REQUIRES]->(sql);

MATCH (api_design:Skill {id: 'skill-api-design'}), (nodejs:Skill {id: 'skill-nodejs'})
CREATE (api_design)-[:REQUIRES]->(nodejs);

// Mobile prerequisites
MATCH (react_native:Skill {id: 'skill-react-native'}), (react:Skill {id: 'skill-react'})
CREATE (react_native)-[:REQUIRES]->(react);

MATCH (flutter:Skill {id: 'skill-flutter'}), (html_css:Skill {id: 'skill-html-css'})
CREATE (flutter)-[:REQUIRES]->(html_css);

// Architecture prerequisites
MATCH (microservices:Skill {id: 'skill-microservices'}), (api_design:Skill {id: 'skill-api-design'})
CREATE (microservices)-[:REQUIRES]->(api_design);

MATCH (microservices:Skill {id: 'skill-microservices'}), (docker:Skill {id: 'skill-docker'})
CREATE (microservices)-[:REQUIRES]->(docker);

MATCH (event_driven:Skill {id: 'skill-event-driven'}), (kafka:Skill {id: 'skill-kafka'})
WHERE exists((kafka))
CREATE (event_driven)-[:REQUIRES]->(kafka);

MATCH (system_design:Skill {id: 'skill-system-design'}), (databases:Skill {id: 'skill-databases'})
CREATE (system_design)-[:REQUIRES]->(databases);

MATCH (system_design:Skill {id: 'skill-system-design'}), (api_design:Skill {id: 'skill-api-design'})
CREATE (system_design)-[:REQUIRES]->(api_design);

// ========================================
// 8. CREATE SKILL PROGRESSIONS
// ========================================

MATCH (html_css:Skill {id: 'skill-html-css'}), (javascript:Skill {id: 'skill-javascript'})
CREATE (html_css)-[:LEADS_TO]->(javascript);

MATCH (javascript:Skill {id: 'skill-javascript'}), (typescript:Skill {id: 'skill-typescript'})
CREATE (javascript)-[:LEADS_TO]->(typescript);

MATCH (javascript:Skill {id: 'skill-javascript'}), (react:Skill {id: 'skill-react'})
CREATE (javascript)-[:LEADS_TO]->(react);

MATCH (react:Skill {id: 'skill-react'}), (nextjs:Skill {id: 'skill-nextjs'})
CREATE (react)-[:LEADS_TO]->(nextjs);

MATCH (react:Skill {id: 'skill-react'}), (react_native:Skill {id: 'skill-react-native'})
CREATE (react)-[:LEADS_TO]->(react_native);

MATCH (nodejs:Skill {id: 'skill-nodejs'}), (express:Skill {id: 'skill-express'})
CREATE (nodejs)-[:LEADS_TO]->(express);

MATCH (express:Skill {id: 'skill-express'}), (api_design:Skill {id: 'skill-api-design'})
CREATE (express)-[:LEADS_TO]->(api_design);

MATCH (api_design:Skill {id: 'skill-api-design'}), (microservices:Skill {id: 'skill-microservices'})
CREATE (api_design)-[:LEADS_TO]->(microservices);

MATCH (design_patterns:Skill {id: 'skill-design-patterns'}), (system_design:Skill {id: 'skill-system-design'})
CREATE (design_patterns)-[:LEADS_TO]->(system_design);

// ========================================
// 9. CREATE CERTIFICATIONS
// ========================================

CREATE (meta_frontend:Certification {
    id: 'cert-meta-frontend',
    name: 'Meta Front-End Developer',
    provider: 'Meta',
    level: 'professional',
    cost: 49,
    validity_period: 'lifetime',
    estimated_prep_hours: 120,
    difficulty_rating: 5,
    market_value: 'medium',
    url: 'https://www.coursera.org/professional-certificates/meta-front-end-developer',
    exam_format: 'Portfolio projects'
});

CREATE (meta_backend:Certification {
    id: 'cert-meta-backend',
    name: 'Meta Back-End Developer',
    provider: 'Meta',
    level: 'professional',
    cost: 49,
    validity_period: 'lifetime',
    estimated_prep_hours: 120,
    difficulty_rating: 5,
    market_value: 'medium',
    url: 'https://www.coursera.org/professional-certificates/meta-back-end-developer',
    exam_format: 'Portfolio projects'
});

CREATE (google_mobile:Certification {
    id: 'cert-google-mobile',
    name: 'Google Associate Android Developer',
    provider: 'Google',
    level: 'associate',
    cost: 149,
    validity_period: '3 years',
    estimated_prep_hours: 80,
    difficulty_rating: 6,
    market_value: 'medium',
    url: 'https://developers.google.com/certification/associate-android-developer',
    exam_format: 'Performance-based, 8 hours'
});

CREATE (aws_developer:Certification {
    id: 'cert-aws-dev',
    name: 'AWS Certified Developer Associate',
    provider: 'AWS',
    level: 'associate',
    cost: 150,
    validity_period: '3 years',
    estimated_prep_hours: 60,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://aws.amazon.com/certification/certified-developer-associate/',
    exam_format: 'Multiple choice, 130 minutes'
});

CREATE (microsoft_dev:Certification {
    id: 'cert-microsoft-dev',
    name: 'Microsoft Azure Developer Associate',
    provider: 'Microsoft',
    level: 'associate',
    cost: 165,
    validity_period: '1 year',
    estimated_prep_hours: 60,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://learn.microsoft.com/certifications/azure-developer/',
    exam_format: 'Multiple choice, 150 minutes'
});

CREATE (oracle_java:Certification {
    id: 'cert-oracle-java',
    name: 'Oracle Java SE 17 Developer',
    provider: 'Oracle',
    level: 'professional',
    cost: 245,
    validity_period: 'lifetime',
    estimated_prep_hours: 80,
    difficulty_rating: 7,
    market_value: 'high',
    url: 'https://education.oracle.com/java-se-17-developer/pexam_1Z0-829',
    exam_format: 'Multiple choice, 90 minutes'
});

// Connect certifications to skills
MATCH (meta_frontend:Certification {id: 'cert-meta-frontend'}), (react:Skill {id: 'skill-react'})
CREATE (meta_frontend)-[:REQUIRES]->(react);

MATCH (meta_frontend:Certification {id: 'cert-meta-frontend'}), (javascript:Skill {id: 'skill-javascript'})
CREATE (meta_frontend)-[:REQUIRES]->(javascript);

MATCH (meta_backend:Certification {id: 'cert-meta-backend'}), (nodejs:Skill {id: 'skill-nodejs'})
CREATE (meta_backend)-[:REQUIRES]->(nodejs);

MATCH (meta_backend:Certification {id: 'cert-meta-backend'}), (databases:Skill {id: 'skill-databases'})
CREATE (meta_backend)-[:REQUIRES]->(databases);

MATCH (google_mobile:Certification {id: 'cert-google-mobile'}), (kotlin:Skill {id: 'skill-kotlin'})
CREATE (google_mobile)-[:REQUIRES]->(kotlin);

MATCH (aws_developer:Certification {id: 'cert-aws-dev'}), (nodejs:Skill {id: 'skill-nodejs'})
CREATE (aws_developer)-[:REQUIRES]->(nodejs);

MATCH (oracle_java:Certification {id: 'cert-oracle-java'}), (java_spring:Skill {id: 'skill-java-spring'})
CREATE (oracle_java)-[:REQUIRES]->(java_spring);

// Connect certifications to domain
MATCH (meta_frontend:Certification {id: 'cert-meta-frontend'}), (software:Domain {id: 'domain-software'})
CREATE (meta_frontend)-[:RECOMMENDED_FOR]->(software);

MATCH (aws_developer:Certification {id: 'cert-aws-dev'}), (software:Domain {id: 'domain-software'})
CREATE (aws_developer)-[:RECOMMENDED_FOR]->(software);

// ========================================
// 10. CREATE RESOURCES
// ========================================

// JavaScript Resources
CREATE (js_info:Resource {
    id: 'res-js-info',
    title: 'JavaScript.info',
    url: 'https://javascript.info/',
    type: 'tutorial',
    platform: 'JavaScript.info',
    duration: '60 hours',
    rating: 4.9,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'reading'
});

CREATE (mdn:Resource {
    id: 'res-mdn',
    title: 'MDN Web Docs',
    url: 'https://developer.mozilla.org/',
    type: 'doc',
    platform: 'Mozilla',
    duration: 'self-paced',
    rating: 5.0,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

// React Resources
CREATE (react_docs:Resource {
    id: 'res-react-docs',
    title: 'React Documentation',
    url: 'https://react.dev/',
    type: 'doc',
    platform: 'React',
    duration: 'self-paced',
    rating: 5.0,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (react_course:Resource {
    id: 'res-react-course',
    title: 'Complete React Developer',
    url: 'https://www.udemy.com/course/complete-react-developer-zero-to-mastery/',
    type: 'video',
    platform: 'Udemy',
    duration: '40 hours',
    rating: 4.7,
    price: 'paid',
    difficulty_level: 'beginner',
    learning_style: 'visual'
});

// Node.js Resources
CREATE (node_docs:Resource {
    id: 'res-node-docs',
    title: 'Node.js Documentation',
    url: 'https://nodejs.org/docs/',
    type: 'doc',
    platform: 'Node.js',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'reading'
});

CREATE (node_best:Resource {
    id: 'res-node-best',
    title: 'Node.js Best Practices',
    url: 'https://github.com/goldbergyoni/nodebestpractices',
    type: 'guide',
    platform: 'GitHub',
    duration: '20 hours',
    rating: 4.8,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// System Design Resources
CREATE (system_design_primer:Resource {
    id: 'res-system-design-primer',
    title: 'System Design Primer',
    url: 'https://github.com/donnemartin/system-design-primer',
    type: 'guide',
    platform: 'GitHub',
    duration: '40 hours',
    rating: 4.9,
    price: 'free',
    difficulty_level: 'advanced',
    learning_style: 'reading'
});

CREATE (ddia:Resource {
    id: 'res-ddia',
    title: 'Designing Data-Intensive Applications',
    url: 'https://dataintensive.net/',
    type: 'book',
    platform: 'OReilly',
    duration: '40 hours',
    rating: 4.9,
    price: 'paid',
    difficulty_level: 'advanced',
    learning_style: 'reading'
});

// Mobile Resources
CREATE (rn_docs:Resource {
    id: 'res-rn-docs',
    title: 'React Native Documentation',
    url: 'https://reactnative.dev/docs/getting-started',
    type: 'doc',
    platform: 'React Native',
    duration: 'self-paced',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (flutter_docs:Resource {
    id: 'res-flutter-docs',
    title: 'Flutter Documentation',
    url: 'https://flutter.dev/docs',
    type: 'doc',
    platform: 'Flutter',
    duration: 'self-paced',
    rating: 4.6,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

// Architecture Resources
CREATE (clean_code:Resource {
    id: 'res-clean-code',
    title: 'Clean Code',
    url: 'https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882',
    type: 'book',
    platform: 'Prentice Hall',
    duration: '25 hours',
    rating: 4.8,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (patterns_book:Resource {
    id: 'res-patterns-book',
    title: 'Design Patterns: Elements of Reusable OO Software',
    url: 'https://www.amazon.com/Design-Patterns-Elements-Reusable-Object-Oriented/dp/0201633612',
    type: 'book',
    platform: 'Addison-Wesley',
    duration: '30 hours',
    rating: 4.7,
    price: 'paid',
    difficulty_level: 'advanced',
    learning_style: 'reading'
});

// Connect resources to skills
MATCH (javascript:Skill {id: 'skill-javascript'}), (js_info:Resource {id: 'res-js-info'})
CREATE (javascript)-[:HAS_RESOURCE]->(js_info);

MATCH (javascript:Skill {id: 'skill-javascript'}), (mdn:Resource {id: 'res-mdn'})
CREATE (javascript)-[:HAS_RESOURCE]->(mdn);

MATCH (react:Skill {id: 'skill-react'}), (react_docs:Resource {id: 'res-react-docs'})
CREATE (react)-[:HAS_RESOURCE]->(react_docs);

MATCH (react:Skill {id: 'skill-react'}), (react_course:Resource {id: 'res-react-course'})
CREATE (react)-[:HAS_RESOURCE]->(react_course);

MATCH (nodejs:Skill {id: 'skill-nodejs'}), (node_docs:Resource {id: 'res-node-docs'})
CREATE (nodejs)-[:HAS_RESOURCE]->(node_docs);

MATCH (nodejs:Skill {id: 'skill-nodejs'}), (node_best:Resource {id: 'res-node-best'})
CREATE (nodejs)-[:HAS_RESOURCE]->(node_best);

MATCH (system_design:Skill {id: 'skill-system-design'}), (system_design_primer:Resource {id: 'res-system-design-primer'})
CREATE (system_design)-[:HAS_RESOURCE]->(system_design_primer);

MATCH (system_design:Skill {id: 'skill-system-design'}), (ddia:Resource {id: 'res-ddia'})
CREATE (system_design)-[:HAS_RESOURCE]->(ddia);

MATCH (react_native:Skill {id: 'skill-react-native'}), (rn_docs:Resource {id: 'res-rn-docs'})
CREATE (react_native)-[:HAS_RESOURCE]->(rn_docs);

MATCH (flutter:Skill {id: 'skill-flutter'}), (flutter_docs:Resource {id: 'res-flutter-docs'})
CREATE (flutter)-[:HAS_RESOURCE]->(flutter_docs);

MATCH (design_patterns:Skill {id: 'skill-design-patterns'}), (clean_code:Resource {id: 'res-clean-code'})
CREATE (design_patterns)-[:HAS_RESOURCE]->(clean_code);

MATCH (design_patterns:Skill {id: 'skill-design-patterns'}), (patterns_book:Resource {id: 'res-patterns-book'})
CREATE (design_patterns)-[:HAS_RESOURCE]->(patterns_book);

// ========================================
// CROSS-DOMAIN RELATIONSHIPS
// ========================================

// Frontend skills apply to Mobile
MATCH (react:Skill {id: 'skill-react'}), (mobile:SubDomain {id: 'sub-mobile'})
CREATE (react)-[:APPLIES_IN]->(mobile);

// API Design bridges to other domains
MATCH (api_design:Skill {id: 'skill-api-design'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (api_design)-[:APPLIES_IN]->(cloud);

MATCH (api_design:Skill {id: 'skill-api-design'}), (data:Domain {id: 'domain-data'})
CREATE (api_design)-[:APPLIES_IN]->(data);

// Microservices bridges to DevOps and Cloud
MATCH (microservices:Skill {id: 'skill-microservices'}), (devops:Domain {id: 'domain-devops'})
CREATE (microservices)-[:APPLIES_IN]->(devops);

MATCH (microservices:Skill {id: 'skill-microservices'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (microservices)-[:APPLIES_IN]->(cloud);

// System Design bridges to SRE
MATCH (system_design:Skill {id: 'skill-system-design'}), (sre:Domain {id: 'domain-sre'})
CREATE (system_design)-[:APPLIES_IN]->(sre);

// Golang bridges to Cloud and DevOps
MATCH (golang:Skill {id: 'skill-golang'}), (cloud:Domain {id: 'domain-cloud'})
CREATE (golang)-[:APPLIES_IN]->(cloud);

MATCH (golang:Skill {id: 'skill-golang'}), (devops:Domain {id: 'domain-devops'})
CREATE (golang)-[:APPLIES_IN]->(devops);

// ========================================
// VERIFICATION QUERY
// ========================================
// Run to verify Software Engineering domain is loaded:
// MATCH (d:Domain {id: 'domain-software'})-[:CONTAINS]->(sd:SubDomain)-[:CONTAINS]->(s:Skill) 
// RETURN d.name, sd.name, count(s) as skill_count;
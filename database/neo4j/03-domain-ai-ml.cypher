// ========================================
// SKILL PATH NAVIGATOR - AI & MACHINE LEARNING DOMAIN
// ========================================
// Run AFTER base domains script
// Creates complete AI/ML skill tree with current 2024-2025 market focus

// ========================================
// 1. CREATE SUBDOMAINS
// ========================================

CREATE (ml_fundamentals:SubDomain {
    id: 'sub-ml-fundamentals',
    name: 'ML Fundamentals',
    description: 'Core machine learning concepts and algorithms',
    order: 1
});

CREATE (deep_learning:SubDomain {
    id: 'sub-deep-learning', 
    name: 'Deep Learning',
    description: 'Neural networks and deep learning frameworks',
    order: 2
});

CREATE (gen_ai:SubDomain {
    id: 'sub-gen-ai',
    name: 'Generative AI',
    description: 'LLMs, RAG, Prompt Engineering, Fine-tuning - The 2025 Gold Rush',
    order: 3
});

CREATE (mlops:SubDomain {
    id: 'sub-mlops',
    name: 'MLOps',
    description: 'ML in production, model deployment and monitoring',
    order: 4
});

CREATE (computer_vision:SubDomain {
    id: 'sub-computer-vision',
    name: 'Computer Vision',
    description: 'Image processing, object detection, visual AI',
    order: 5
});

CREATE (nlp:SubDomain {
    id: 'sub-nlp',
    name: 'Natural Language Processing',
    description: 'Text processing, language understanding, transformers',
    order: 6
});

// Connect to domain
MATCH (ai:Domain {id: 'domain-ai-ml'}), (ml_fundamentals:SubDomain {id: 'sub-ml-fundamentals'})
CREATE (ai)-[:CONTAINS]->(ml_fundamentals);

MATCH (ai:Domain {id: 'domain-ai-ml'}), (deep_learning:SubDomain {id: 'sub-deep-learning'})
CREATE (ai)-[:CONTAINS]->(deep_learning);

MATCH (ai:Domain {id: 'domain-ai-ml'}), (gen_ai:SubDomain {id: 'sub-gen-ai'})
CREATE (ai)-[:CONTAINS]->(gen_ai);

MATCH (ai:Domain {id: 'domain-ai-ml'}), (mlops:SubDomain {id: 'sub-mlops'})
CREATE (ai)-[:CONTAINS]->(mlops);

MATCH (ai:Domain {id: 'domain-ai-ml'}), (computer_vision:SubDomain {id: 'sub-computer-vision'})
CREATE (ai)-[:CONTAINS]->(computer_vision);

MATCH (ai:Domain {id: 'domain-ai-ml'}), (nlp:SubDomain {id: 'sub-nlp'})
CREATE (ai)-[:CONTAINS]->(nlp);

// ========================================
// 2. CREATE ML FUNDAMENTALS SKILLS
// ========================================

CREATE (ml_basics:Skill {
    id: 'skill-ml-basics',
    name: 'Machine Learning Basics',
    description: 'Supervised, unsupervised learning, model evaluation, feature engineering',
    difficulty_level: 'intermediate',
    estimated_hours: 80,
    demand_score: 9,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

CREATE (statistics:Skill {
    id: 'skill-statistics',
    name: 'Statistics for ML',
    description: 'Probability, distributions, hypothesis testing, Bayesian methods',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 8,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

CREATE (linear_algebra:Skill {
    id: 'skill-linear-algebra',
    name: 'Linear Algebra for ML',
    description: 'Vectors, matrices, eigenvalues, SVD - the math behind ML',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 7,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

CREATE (scikit_learn:Skill {
    id: 'skill-scikit-learn',
    name: 'Scikit-learn',
    description: 'Classical ML algorithms, preprocessing, model selection',
    difficulty_level: 'beginner',
    estimated_hours: 40,
    demand_score: 8,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

CREATE (pandas:Skill {
    id: 'skill-pandas',
    name: 'Pandas',
    description: 'Data manipulation and analysis with Python',
    difficulty_level: 'beginner',
    estimated_hours: 30,
    demand_score: 9,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

CREATE (numpy:Skill {
    id: 'skill-numpy',
    name: 'NumPy',
    description: 'Numerical computing with Python arrays',
    difficulty_level: 'beginner',
    estimated_hours: 20,
    demand_score: 8,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

// ========================================
// 3. CREATE DEEP LEARNING SKILLS
// ========================================

CREATE (deep_learning_skill:Skill {
    id: 'skill-deep-learning',
    name: 'Deep Learning Fundamentals',
    description: 'Neural networks, backpropagation, CNNs, RNNs, Transformers',
    difficulty_level: 'advanced',
    estimated_hours: 120,
    demand_score: 9,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

CREATE (pytorch:Skill {
    id: 'skill-pytorch',
    name: 'PyTorch',
    description: 'Deep learning framework by Meta, dynamic computation graphs',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 10,
    category: 'ai-ml',
    market_insights: 'Preferred by researchers and growing in industry',
    last_updated: date('2025-01-15')
});

CREATE (tensorflow:Skill {
    id: 'skill-tensorflow',
    name: 'TensorFlow',
    description: 'Google\'s deep learning framework, production-ready',
    difficulty_level: 'intermediate',
    estimated_hours: 60,
    demand_score: 8,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

CREATE (keras:Skill {
    id: 'skill-keras',
    name: 'Keras',
    description: 'High-level neural network API, now part of TensorFlow',
    difficulty_level: 'beginner',
    estimated_hours: 30,
    demand_score: 7,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

// ========================================
// 4. CREATE GENERATIVE AI SKILLS (HOT!)
// ========================================

CREATE (llm_engineering:Skill {
    id: 'skill-llm-engineering',
    name: 'LLM Engineering',
    description: 'Working with GPT, Claude, Llama, deployment, optimization',
    difficulty_level: 'advanced',
    estimated_hours: 100,
    demand_score: 10,
    category: 'ai-ml',
    market_insights: 'Highest demand AI skill for 2025',
    last_updated: date('2025-01-15')
});

CREATE (prompt_engineering:Skill {
    id: 'skill-prompt-engineering',
    name: 'Prompt Engineering',
    description: 'Crafting effective prompts, few-shot learning, chain-of-thought',
    difficulty_level: 'beginner',
    estimated_hours: 20,
    demand_score: 8,
    category: 'ai-ml',
    market_insights: 'Essential for anyone working with AI',
    last_updated: date('2025-01-15')
});

CREATE (rag:Skill {
    id: 'skill-rag',
    name: 'RAG (Retrieval Augmented Generation)',
    description: 'Building AI with external knowledge, vector databases, embeddings',
    difficulty_level: 'advanced',
    estimated_hours: 60,
    demand_score: 9,
    category: 'ai-ml',
    market_insights: 'Critical for enterprise AI applications',
    last_updated: date('2025-01-15')
});

CREATE (fine_tuning:Skill {
    id: 'skill-fine-tuning',
    name: 'LLM Fine-tuning',
    description: 'LoRA, QLoRA, PEFT, adapting models for specific tasks',
    difficulty_level: 'advanced',
    estimated_hours: 80,
    demand_score: 8,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

CREATE (langchain:Skill {
    id: 'skill-langchain',
    name: 'LangChain',
    description: 'Framework for building LLM applications, agents, chains',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 9,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

CREATE (vector_databases:Skill {
    id: 'skill-vector-db',
    name: 'Vector Databases',
    description: 'Pinecone, Weaviate, ChromaDB for embeddings and similarity search',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 8,
    category: 'ai-ml',
    last_updated: date('2025-01-15')
});

// ========================================
// 5. CREATE MLOPS SKILLS
// ========================================

CREATE (mlflow:Skill {
    id: 'skill-mlflow',
    name: 'MLflow',
    description: 'ML lifecycle management, experiment tracking, model registry',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'mlops',
    last_updated: date('2025-01-15')
});

CREATE (kubeflow:Skill {
    id: 'skill-kubeflow',
    name: 'Kubeflow',
    description: 'ML workflows on Kubernetes, pipelines, serving',
    difficulty_level: 'advanced',
    estimated_hours: 60,
    demand_score: 7,
    category: 'mlops',
    last_updated: date('2025-01-15')
});

CREATE (model_monitoring:Skill {
    id: 'skill-model-monitoring',
    name: 'Model Monitoring',
    description: 'Drift detection, performance monitoring, A/B testing',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 8,
    category: 'mlops',
    last_updated: date('2025-01-15')
});

// ========================================
// 6. CREATE COMPUTER VISION SKILLS
// ========================================

CREATE (opencv:Skill {
    id: 'skill-opencv',
    name: 'OpenCV',
    description: 'Computer vision library, image processing, object detection',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 7,
    category: 'computer-vision',
    last_updated: date('2025-01-15')
});

CREATE (yolo:Skill {
    id: 'skill-yolo',
    name: 'YOLO',
    description: 'Real-time object detection, YOLOv8 and beyond',
    difficulty_level: 'intermediate',
    estimated_hours: 40,
    demand_score: 7,
    category: 'computer-vision',
    last_updated: date('2025-01-15')
});

// ========================================
// 7. CREATE NLP SKILLS
// ========================================

CREATE (transformers_lib:Skill {
    id: 'skill-transformers',
    name: 'Transformers (HuggingFace)',
    description: 'State-of-the-art NLP models, BERT, GPT, T5',
    difficulty_level: 'intermediate',
    estimated_hours: 50,
    demand_score: 9,
    category: 'nlp',
    last_updated: date('2025-01-15')
});

CREATE (spacy:Skill {
    id: 'skill-spacy',
    name: 'spaCy',
    description: 'Industrial-strength NLP library, NER, POS tagging',
    difficulty_level: 'intermediate',
    estimated_hours: 30,
    demand_score: 7,
    category: 'nlp',
    last_updated: date('2025-01-15')
});

// ========================================
// 8. CONNECT SKILLS TO SUBDOMAINS
// ========================================

// ML Fundamentals connections
MATCH (ml_fundamentals:SubDomain {id: 'sub-ml-fundamentals'}), (ml_basics:Skill {id: 'skill-ml-basics'})
CREATE (ml_fundamentals)-[:CONTAINS]->(ml_basics);

MATCH (ml_fundamentals:SubDomain {id: 'sub-ml-fundamentals'}), (statistics:Skill {id: 'skill-statistics'})
CREATE (ml_fundamentals)-[:CONTAINS]->(statistics);

MATCH (ml_fundamentals:SubDomain {id: 'sub-ml-fundamentals'}), (linear_algebra:Skill {id: 'skill-linear-algebra'})
CREATE (ml_fundamentals)-[:CONTAINS]->(linear_algebra);

MATCH (ml_fundamentals:SubDomain {id: 'sub-ml-fundamentals'}), (scikit_learn:Skill {id: 'skill-scikit-learn'})
CREATE (ml_fundamentals)-[:CONTAINS]->(scikit_learn);

MATCH (ml_fundamentals:SubDomain {id: 'sub-ml-fundamentals'}), (pandas:Skill {id: 'skill-pandas'})
CREATE (ml_fundamentals)-[:CONTAINS]->(pandas);

MATCH (ml_fundamentals:SubDomain {id: 'sub-ml-fundamentals'}), (numpy:Skill {id: 'skill-numpy'})
CREATE (ml_fundamentals)-[:CONTAINS]->(numpy);

// Deep Learning connections
MATCH (deep_learning:SubDomain {id: 'sub-deep-learning'}), (deep_learning_skill:Skill {id: 'skill-deep-learning'})
CREATE (deep_learning)-[:CONTAINS]->(deep_learning_skill);

MATCH (deep_learning:SubDomain {id: 'sub-deep-learning'}), (pytorch:Skill {id: 'skill-pytorch'})
CREATE (deep_learning)-[:CONTAINS]->(pytorch);

MATCH (deep_learning:SubDomain {id: 'sub-deep-learning'}), (tensorflow:Skill {id: 'skill-tensorflow'})
CREATE (deep_learning)-[:CONTAINS]->(tensorflow);

MATCH (deep_learning:SubDomain {id: 'sub-deep-learning'}), (keras:Skill {id: 'skill-keras'})
CREATE (deep_learning)-[:CONTAINS]->(keras);

// Generative AI connections
MATCH (gen_ai:SubDomain {id: 'sub-gen-ai'}), (llm_engineering:Skill {id: 'skill-llm-engineering'})
CREATE (gen_ai)-[:CONTAINS]->(llm_engineering);

MATCH (gen_ai:SubDomain {id: 'sub-gen-ai'}), (prompt_engineering:Skill {id: 'skill-prompt-engineering'})
CREATE (gen_ai)-[:CONTAINS]->(prompt_engineering);

MATCH (gen_ai:SubDomain {id: 'sub-gen-ai'}), (rag:Skill {id: 'skill-rag'})
CREATE (gen_ai)-[:CONTAINS]->(rag);

MATCH (gen_ai:SubDomain {id: 'sub-gen-ai'}), (fine_tuning:Skill {id: 'skill-fine-tuning'})
CREATE (gen_ai)-[:CONTAINS]->(fine_tuning);

MATCH (gen_ai:SubDomain {id: 'sub-gen-ai'}), (langchain:Skill {id: 'skill-langchain'})
CREATE (gen_ai)-[:CONTAINS]->(langchain);

MATCH (gen_ai:SubDomain {id: 'sub-gen-ai'}), (vector_databases:Skill {id: 'skill-vector-db'})
CREATE (gen_ai)-[:CONTAINS]->(vector_databases);

// MLOps connections
MATCH (mlops:SubDomain {id: 'sub-mlops'}), (mlflow:Skill {id: 'skill-mlflow'})
CREATE (mlops)-[:CONTAINS]->(mlflow);

MATCH (mlops:SubDomain {id: 'sub-mlops'}), (kubeflow:Skill {id: 'skill-kubeflow'})
CREATE (mlops)-[:CONTAINS]->(kubeflow);

MATCH (mlops:SubDomain {id: 'sub-mlops'}), (model_monitoring:Skill {id: 'skill-model-monitoring'})
CREATE (mlops)-[:CONTAINS]->(model_monitoring);

// Computer Vision connections
MATCH (computer_vision:SubDomain {id: 'sub-computer-vision'}), (opencv:Skill {id: 'skill-opencv'})
CREATE (computer_vision)-[:CONTAINS]->(opencv);

MATCH (computer_vision:SubDomain {id: 'sub-computer-vision'}), (yolo:Skill {id: 'skill-yolo'})
CREATE (computer_vision)-[:CONTAINS]->(yolo);

// NLP connections
MATCH (nlp:SubDomain {id: 'sub-nlp'}), (transformers_lib:Skill {id: 'skill-transformers'})
CREATE (nlp)-[:CONTAINS]->(transformers_lib);

MATCH (nlp:SubDomain {id: 'sub-nlp'}), (spacy:Skill {id: 'skill-spacy'})
CREATE (nlp)-[:CONTAINS]->(spacy);

// ========================================
// 9. CREATE SKILL PREREQUISITES
// ========================================

// Python is prerequisite for all ML
MATCH (ml_basics:Skill {id: 'skill-ml-basics'}), (python:Skill {id: 'skill-python'})
CREATE (ml_basics)-[:REQUIRES]->(python);

MATCH (pandas:Skill {id: 'skill-pandas'}), (python:Skill {id: 'skill-python'})
CREATE (pandas)-[:REQUIRES]->(python);

MATCH (numpy:Skill {id: 'skill-numpy'}), (python:Skill {id: 'skill-python'})
CREATE (numpy)-[:REQUIRES]->(python);

// ML basics hierarchy
MATCH (scikit_learn:Skill {id: 'skill-scikit-learn'}), (numpy:Skill {id: 'skill-numpy'})
CREATE (scikit_learn)-[:REQUIRES]->(numpy);

MATCH (scikit_learn:Skill {id: 'skill-scikit-learn'}), (pandas:Skill {id: 'skill-pandas'})
CREATE (scikit_learn)-[:REQUIRES]->(pandas);

MATCH (ml_basics:Skill {id: 'skill-ml-basics'}), (statistics:Skill {id: 'skill-statistics'})
CREATE (ml_basics)-[:REQUIRES]->(statistics);

// Deep learning prerequisites
MATCH (deep_learning_skill:Skill {id: 'skill-deep-learning'}), (ml_basics:Skill {id: 'skill-ml-basics'})
CREATE (deep_learning_skill)-[:REQUIRES]->(ml_basics);

MATCH (deep_learning_skill:Skill {id: 'skill-deep-learning'}), (linear_algebra:Skill {id: 'skill-linear-algebra'})
CREATE (deep_learning_skill)-[:REQUIRES]->(linear_algebra);

MATCH (pytorch:Skill {id: 'skill-pytorch'}), (numpy:Skill {id: 'skill-numpy'})
CREATE (pytorch)-[:REQUIRES]->(numpy);

MATCH (tensorflow:Skill {id: 'skill-tensorflow'}), (numpy:Skill {id: 'skill-numpy'})
CREATE (tensorflow)-[:REQUIRES]->(numpy);

MATCH (keras:Skill {id: 'skill-keras'}), (tensorflow:Skill {id: 'skill-tensorflow'})
CREATE (keras)-[:REQUIRES]->(tensorflow);

// LLM prerequisites
MATCH (llm_engineering:Skill {id: 'skill-llm-engineering'}), (deep_learning_skill:Skill {id: 'skill-deep-learning'})
CREATE (llm_engineering)-[:REQUIRES]->(deep_learning_skill);

MATCH (rag:Skill {id: 'skill-rag'}), (llm_engineering:Skill {id: 'skill-llm-engineering'})
CREATE (rag)-[:REQUIRES]->(llm_engineering);

MATCH (rag:Skill {id: 'skill-rag'}), (vector_databases:Skill {id: 'skill-vector-db'})
CREATE (rag)-[:REQUIRES]->(vector_databases);

MATCH (fine_tuning:Skill {id: 'skill-fine-tuning'}), (llm_engineering:Skill {id: 'skill-llm-engineering'})
CREATE (fine_tuning)-[:REQUIRES]->(llm_engineering);

MATCH (langchain:Skill {id: 'skill-langchain'}), (python:Skill {id: 'skill-python'})
CREATE (langchain)-[:REQUIRES]->(python);

// MLOps prerequisites
MATCH (mlflow:Skill {id: 'skill-mlflow'}), (ml_basics:Skill {id: 'skill-ml-basics'})
CREATE (mlflow)-[:REQUIRES]->(ml_basics);

MATCH (kubeflow:Skill {id: 'skill-kubeflow'}), (kubernetes:Skill {id: 'skill-kubernetes'})
CREATE (kubeflow)-[:REQUIRES]->(kubernetes);

MATCH (kubeflow:Skill {id: 'skill-kubeflow'}), (ml_basics:Skill {id: 'skill-ml-basics'})
CREATE (kubeflow)-[:REQUIRES]->(ml_basics);

// ========================================
// 10. CREATE SKILL PROGRESSIONS
// ========================================

MATCH (python:Skill {id: 'skill-python'}), (numpy:Skill {id: 'skill-numpy'})
CREATE (python)-[:LEADS_TO]->(numpy);

MATCH (numpy:Skill {id: 'skill-numpy'}), (pandas:Skill {id: 'skill-pandas'})
CREATE (numpy)-[:LEADS_TO]->(pandas);

MATCH (pandas:Skill {id: 'skill-pandas'}), (ml_basics:Skill {id: 'skill-ml-basics'})
CREATE (pandas)-[:LEADS_TO]->(ml_basics);

MATCH (ml_basics:Skill {id: 'skill-ml-basics'}), (deep_learning_skill:Skill {id: 'skill-deep-learning'})
CREATE (ml_basics)-[:LEADS_TO]->(deep_learning_skill);

MATCH (deep_learning_skill:Skill {id: 'skill-deep-learning'}), (llm_engineering:Skill {id: 'skill-llm-engineering'})
CREATE (deep_learning_skill)-[:LEADS_TO]->(llm_engineering);

MATCH (prompt_engineering:Skill {id: 'skill-prompt-engineering'}), (llm_engineering:Skill {id: 'skill-llm-engineering'})
CREATE (prompt_engineering)-[:LEADS_TO]->(llm_engineering);

MATCH (llm_engineering:Skill {id: 'skill-llm-engineering'}), (rag:Skill {id: 'skill-rag'})
CREATE (llm_engineering)-[:LEADS_TO]->(rag);

// ========================================
// 11. CREATE CERTIFICATIONS
// ========================================

CREATE (aws_ml:Certification {
    id: 'cert-aws-ml',
    name: 'AWS Machine Learning Specialty',
    provider: 'AWS',
    level: 'specialty',
    cost: 300,
    validity_period: '3 years',
    estimated_prep_hours: 100,
    difficulty_rating: 8,
    market_value: 'very-high',
    url: 'https://aws.amazon.com/certification/certified-machine-learning-specialty/',
    exam_format: 'Multiple choice, 180 minutes'
});

CREATE (gcp_ml:Certification {
    id: 'cert-gcp-ml',
    name: 'Google Cloud Professional ML Engineer',
    provider: 'Google',
    level: 'professional',
    cost: 200,
    validity_period: '2 years',
    estimated_prep_hours: 100,
    difficulty_rating: 8,
    market_value: 'very-high',
    url: 'https://cloud.google.com/certification/machine-learning-engineer',
    exam_format: 'Multiple choice, 120 minutes'
});

CREATE (ai_900:Certification {
    id: 'cert-ai-900',
    name: 'Azure AI Fundamentals',
    provider: 'Microsoft',
    level: 'foundational',
    cost: 99,
    validity_period: 'lifetime',
    estimated_prep_hours: 25,
    difficulty_rating: 3,
    market_value: 'medium',
    url: 'https://learn.microsoft.com/certifications/azure-ai-fundamentals/',
    exam_format: 'Multiple choice, 60 minutes'
});

CREATE (ai_102:Certification {
    id: 'cert-ai-102',
    name: 'Azure AI Engineer Associate',
    provider: 'Microsoft',
    level: 'associate',
    cost: 165,
    validity_period: '1 year',
    estimated_prep_hours: 60,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://learn.microsoft.com/certifications/azure-ai-engineer/',
    exam_format: 'Multiple choice, 120 minutes'
});

CREATE (tensorflow_cert:Certification {
    id: 'cert-tensorflow',
    name: 'TensorFlow Developer Certificate',
    provider: 'Google',
    level: 'professional',
    cost: 100,
    validity_period: '3 years',
    estimated_prep_hours: 60,
    difficulty_rating: 6,
    market_value: 'high',
    url: 'https://www.tensorflow.org/certificate',
    exam_format: 'Coding exam, 5 hours'
});

// Connect certifications to skills
MATCH (aws_ml:Certification {id: 'cert-aws-ml'}), (ml_basics:Skill {id: 'skill-ml-basics'})
CREATE (aws_ml)-[:REQUIRES]->(ml_basics);

MATCH (gcp_ml:Certification {id: 'cert-gcp-ml'}), (ml_basics:Skill {id: 'skill-ml-basics'})
CREATE (gcp_ml)-[:REQUIRES]->(ml_basics);

MATCH (tensorflow_cert:Certification {id: 'cert-tensorflow'}), (tensorflow:Skill {id: 'skill-tensorflow'})
CREATE (tensorflow_cert)-[:REQUIRES]->(tensorflow);

MATCH (ai_102:Certification {id: 'cert-ai-102'}), (ml_basics:Skill {id: 'skill-ml-basics'})
CREATE (ai_102)-[:REQUIRES]->(ml_basics);

// Certification progressions
MATCH (ai_900:Certification {id: 'cert-ai-900'}), (ai_102:Certification {id: 'cert-ai-102'})
CREATE (ai_900)-[:LEADS_TO]->(ai_102);

// Connect to domain
MATCH (aws_ml:Certification {id: 'cert-aws-ml'}), (ai:Domain {id: 'domain-ai-ml'})
CREATE (aws_ml)-[:RECOMMENDED_FOR]->(ai);

MATCH (gcp_ml:Certification {id: 'cert-gcp-ml'}), (ai:Domain {id: 'domain-ai-ml'})
CREATE (gcp_ml)-[:RECOMMENDED_FOR]->(ai);

// ========================================
// 12. CREATE RESOURCES
// ========================================

// ML Fundamentals Resources
CREATE (ml_coursera:Resource {
    id: 'res-ml-coursera',
    title: 'Machine Learning by Andrew Ng',
    url: 'https://www.coursera.org/learn/machine-learning',
    type: 'video',
    platform: 'Coursera',
    duration: '60 hours',
    rating: 4.9,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'visual'
});

CREATE (fastai:Resource {
    id: 'res-fastai',
    title: 'Fast.ai Practical Deep Learning',
    url: 'https://www.fast.ai/',
    type: 'video',
    platform: 'Fast.ai',
    duration: '30 hours',
    rating: 4.8,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'hands-on'
});

CREATE (deeplearning_ai:Resource {
    id: 'res-deeplearning-ai',
    title: 'Deep Learning Specialization',
    url: 'https://www.deeplearning.ai/courses/deep-learning-specialization/',
    type: 'course',
    platform: 'DeepLearning.AI',
    duration: '120 hours',
    rating: 4.8,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'visual'
});

// PyTorch Resources
CREATE (pytorch_docs:Resource {
    id: 'res-pytorch-docs',
    title: 'PyTorch Official Tutorials',
    url: 'https://pytorch.org/tutorials/',
    type: 'doc',
    platform: 'PyTorch',
    duration: 'self-paced',
    rating: 4.7,
    price: 'free',
    difficulty_level: 'all',
    learning_style: 'hands-on'
});

CREATE (pytorch_udemy:Resource {
    id: 'res-pytorch-udemy',
    title: 'PyTorch for Deep Learning',
    url: 'https://www.udemy.com/course/pytorch-for-deep-learning/',
    type: 'video',
    platform: 'Udemy',
    duration: '45 hours',
    rating: 4.6,
    price: 'paid',
    difficulty_level: 'intermediate',
    learning_style: 'visual'
});

// LLM Resources
CREATE (llm_course:Resource {
    id: 'res-llm-course',
    title: 'LLM University by Cohere',
    url: 'https://docs.cohere.com/docs/llmu',
    type: 'course',
    platform: 'Cohere',
    duration: '20 hours',
    rating: 4.5,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'mixed'
});

CREATE (langchain_docs:Resource {
    id: 'res-langchain-docs',
    title: 'LangChain Documentation',
    url: 'https://python.langchain.com/',
    type: 'doc',
    platform: 'LangChain',
    duration: 'self-paced',
    rating: 4.4,
    price: 'free',
    difficulty_level: 'intermediate',
    learning_style: 'reading'
});

CREATE (prompt_guide:Resource {
    id: 'res-prompt-guide',
    title: 'Prompt Engineering Guide',
    url: 'https://www.promptingguide.ai/',
    type: 'guide',
    platform: 'DAIR.AI',
    duration: '10 hours',
    rating: 4.6,
    price: 'free',
    difficulty_level: 'beginner',
    learning_style: 'reading'
});

// Connect resources to skills
MATCH (ml_basics:Skill {id: 'skill-ml-basics'}), (ml_coursera:Resource {id: 'res-ml-coursera'})
CREATE (ml_basics)-[:HAS_RESOURCE]->(ml_coursera);

MATCH (deep_learning_skill:Skill {id: 'skill-deep-learning'}), (fastai:Resource {id: 'res-fastai'})
CREATE (deep_learning_skill)-[:HAS_RESOURCE]->(fastai);

MATCH (deep_learning_skill:Skill {id: 'skill-deep-learning'}), (deeplearning_ai:Resource {id: 'res-deeplearning-ai'})
CREATE (deep_learning_skill)-[:HAS_RESOURCE]->(deeplearning_ai);

MATCH (pytorch:Skill {id: 'skill-pytorch'}), (pytorch_docs:Resource {id: 'res-pytorch-docs'})
CREATE (pytorch)-[:HAS_RESOURCE]->(pytorch_docs);

MATCH (pytorch:Skill {id: 'skill-pytorch'}), (pytorch_udemy:Resource {id: 'res-pytorch-udemy'})
CREATE (pytorch)-[:HAS_RESOURCE]->(pytorch_udemy);

MATCH (llm_engineering:Skill {id: 'skill-llm-engineering'}), (llm_course:Resource {id: 'res-llm-course'})
CREATE (llm_engineering)-[:HAS_RESOURCE]->(llm_course);

MATCH (langchain:Skill {id: 'skill-langchain'}), (langchain_docs:Resource {id: 'res-langchain-docs'})
CREATE (langchain)-[:HAS_RESOURCE]->(langchain_docs);

MATCH (prompt_engineering:Skill {id: 'skill-prompt-engineering'}), (prompt_guide:Resource {id: 'res-prompt-guide'})
CREATE (prompt_engineering)-[:HAS_RESOURCE]->(prompt_guide);

// ========================================
// VERIFICATION QUERY
// ========================================
// Run to verify AI/ML domain is loaded:
// MATCH (d:Domain {id: 'domain-ai-ml'})-[:CONTAINS]->(sd:SubDomain)-[:CONTAINS]->(s:Skill) 
// RETURN d.name, sd.name, count(s) as skill_count;
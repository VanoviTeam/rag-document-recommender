# 🧠 Automated Document-Based AI Recommendation System (RAG) - [Local Demo]

## 📌 Project Overview
This project is a **local** demonstration version of a document-based AI recommendation system. It uses advanced **RAG (Retrieval-Augmented Generation)** techniques to search for information in a vector database and generate recommendations strictly based on the hosted documents. All of this is orchestrated through automated workflows in n8n and integrated in a modular and scalable way using Docker.

This version is adapted to run easily on any local machine using containers, guaranteeing privacy and security (Self-hosted AI) by keeping all logic and AI processing *on-premise*, without relying on paid external APIs.

---

## ⚙️ Prerequisites

### Hardware Requirements
- **RAM:** Minimum 16 GB (recommended 32 GB or more) due to local execution of LLM models.
- **Storage:** At least 20 GB of free space for Docker images, the vector database, and AI models.
- **CPU/GPU:** The project is configured and optimized by default to run on **pure CPU**, allowing guaranteed universal deployment (ideal for traditional hardware or free Cloud instances without dedicated graphics). If you have a native graphics card and wish to use it to accelerate the LLM, you must [change the GPU passthrough in `docker-compose.yml`](https://docs.docker.com/compose/gpu-support/) according to Docker's official documentation.

### Software Requirements
- **Docker** and **Docker Compose** installed on your system.
- **Git** (to clone the repository).
- (Optional) Linux/WSL2-based OS if you need to manage resources like memory swap.

---

## 🛠 Architecture & Tech Stack
- **Automation and Orchestration:** n8n (Main workflow engine).
- **Artificial Intelligence & NLP:** Local models executed using **Ollama** (Llama 3.2, nomic-embed-text-v2-moe).
- **Vector Database:** Qdrant (Storage and semantic search for documents).
- **Relational Databases & Cache:** PostgreSQL, Redis.
- **Container Infrastructure:** Docker and Docker Compose.
- **Caddy Server:** Reverse Proxy.

---

## ☁️ Tested Environments

Although this is an adapted version for a local demonstration, the entire architecture has been **successfully tested and validated** on the following environments:

### 1. Oracle Cloud (OCI)
Tested on an Oracle OCI virtual machine, with a special focus on leveraging the "Always Free" tier with ARM Ampere A1 instances, allocating up to 24GB of RAM.

### 2. Local Windows Machine (Modest Hardware)
This demonstrates the project's ability to run locally using purely CPU configuration and swap memory:
- **Processor:** Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz 2.50 GHz
- **Installed RAM:** 20.0 GB (19.9 GB usable)
- **Storage:** 238 GB SSD.
- **Graphics Card:** Intel(R) HD Graphics 520 (128 MB)
- **System Type:** 64-bit operating system, x64-based processor

---

## 🚀 Local Installation and Deployment

1. **Clone the repository:**
   ```bash
   git clone https://github.com/VanoviTeam/rag-document-recommender.git rag-document-recomender
   cd rag-document-recomender
   ```

2. **Initial setup:**
   - Copy the environment variables example file and adjust it to your default needs:
   ```bash
   cp .env.example .env
   ```
   - *(Optional for Linux)* If you are on a Linux environment with low RAM or running the project on a limited VPS, you can run the provided swap script to **add 8GB of Swap** and ensure the stability of the LLM model. This step is **not necessary** if your local machine has plenty of memory (16GB+).
   ```bash
   chmod +x setup_swap.sh
   sudo ./setup_swap.sh
   ```
   - *(Optional for Windows)* If you use Windows and Docker Desktop (based on WSL2) with limited RAM, you can run the specific PowerShell script to automatically **allocate 8GB of Swap** to the Docker subsystem and prevent Ollama from crashing:
   ```powershell
   .\setup_swap.ps1
   ```

3. **Start the infrastructure (and automatically download AI Models):**
   Start all services using Docker Compose. The first time will take some time while the images are downloaded. **Default Configuration**: This demo is configured so the containers automatically download the local AI models (**`llama3.2:latest`** for text and **`nomic-embed-text-v2-moe`** for embeddings). 
   
   *Note: If you do not wish to download these AIs or prefer using others, you must modify or remove the `ollama-pull-llm` and `ollama-pull-embedding` services in the `docker-compose.yml` file accordingly.*
   ```bash
   docker-compose up -d
   ```

---

## 💻 How to Use this Demo

1. **Access n8n:**
   Open your browser and navigate to `http://localhost:5678` (or the port you configured). Follow the n8n instructions to create your initial local account.
2. **Import Demo Credentials and Workflows:**
   In the `n8n/demo-data` folder you will find the pre-configured workflow and connection credentials for the containerized Qdrant and Ollama services used in this project. Import them into your n8n environment to have your agent ready in seconds.
3. **Configure Email Credentials (IMPERATIVE):**
   To successfully send out the AI recommendations via email at the end of the workflow, it is imperative that you create and configure your SMTP email credentials within n8n. Ensure these are correctly linked in the respective email sending node of your workflow.
4. **Ingestion Pipeline (Data Upload):**
   *Note: By default, the Qdrant RAG vector database starts completely empty.* Activate the workflow responsible for processing and vectorizing files to populate it. In the root of this project you will find the example file **`Sample Book Catalog - [Local Demo].pdf`**; this book catalog is an ideal file to upload to the RAG database and run your first tests.
5. **Interact with the AI Agent:**
   Use the Form workflow or hit the n8n test Webhook to receive recommendations based on the uploaded catalog.

---

## 🌟 Main Features
- **Centralized Orchestration:** Coordinated management of n8n, qdrant, dbs, and AI (Ollama) from a single `docker-compose.yml`.
- **Ultra Fast RAG Engine:** Logical text extraction and semantic search with the combined power of Llama 3.2 and Qdrant.
- **Dynamic Agent:** "AI Agent" setup in n8n that makes autonomous decisions on when to access the document database before crafting its response.
- **Private Environment:** Robust *Self-hosted* alternative to the massive use of centralized cloud services.

---

## ⚖️ Legal & Third-Party Licenses

The infrastructure code, configuration files (such as `docker-compose.yml`), automation scripts, and n8n workflow templates provided in this repository are licensed under the **MIT License**. You are free to use, modify, and distribute them as you see fit.

However, please note that this project acts as an orchestrator for several third-party software components and AI models. When deploying this infrastructure, you must comply with their respective licenses:

* **[n8n](https://n8n.io/):** Operates under a Sustainable Use License (Fair-code). It is free for internal use and demonstrations, but you cannot use it to offer n8n as a managed service (SaaS) to third parties.
* **[Llama 3.2 Models (via Meta)](https://ai.meta.com/llama/license/):** The AI models downloaded automatically by this demo are subject to the Llama 3.2 Community License Agreement, which includes specific attribution requirements and commercial restrictions for large-scale deployments.
* **Ollama, Qdrant, PostgreSQL, Redis & Caddy:** These tools are open-source and operate under their own permissive licenses (such as Apache 2.0 or MIT). 

*By starting the containers and downloading the AI models, you agree to the terms and conditions of these third-party providers.*

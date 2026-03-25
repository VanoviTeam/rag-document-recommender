# 🧠 Sistema automatizado de recomendaciones con IA basado en Documentos (RAG) - [Local Demo]

## 📌 Descripción General del Proyecto
Este proyecto es una versión de demostración **local** de un sistema de recomendaciones con IA basado en documentos. Utiliza técnicas avanzadas de **RAG (Retrieval-Augmented Generation)** para buscar información en una base de datos vectorial y generar recomendaciones basadas estrictamente en los documentos alojados. Todo esto está orquestado mediante flujos de trabajo automatizados en n8n e integrado de manera modular.

Esta versión está adaptada para ejecutarse fácilmente en cualquier máquina local mediante contenedores, garantizando privacidad y seguridad (Self-hosted AI) al mantener todo el procesamiento lógico y de IA *on-premise*, sin depender de APIs de pago externas.

---

## ⚙️ Requisitos Previos

### Requisitos de Hardware
- **Memoria RAM:** Mínimo 16 GB (recomendado 32 GB o más) debido a la ejecución local de modelos LLM.
- **Almacenamiento:** Al menos 20 GB de espacio libre para las imágenes de Docker, la base de datos vectorial y los modelos de IA.
- **CPU/GPU:** Procesador multinúcleo moderno. Se recomienda encarecidamente una GPU compatible para acelerar la inferencia en Ollama.

### Requisitos de Software
- **Docker** y **Docker Compose** instalados en el sistema.
- **Git** (para clonar el repositorio).
- (Opcional) SO basado en Linux/WSL2 si se van a administrar recursos como el memory swap.

---

## 🛠 Arquitectura y Stack Tecnológico
- **Automatización y Orquestación:** n8n (Motor principal de workflows).
- **Inteligencia Artificial y NLP:** Modelos locales ejecutados con **Ollama** (Llama 3.2, nomic-embed-text-v2-moe).
- **Base de Datos Vectorial:** Qdrant (Almacenamiento y búsqueda semántica de documentos).
- **Bases de Datos Relacionales y Caché:** PostgreSQL, Redis.
- **Infraestructura de Contenedores:** Docker y Docker Compose.
- *(Opcional/Avanzado)* Integración con **Authentik** (IAM) y **Caddy Server** (Proxy Inverso) para entornos que requieran replicar la capa de seguridad y Zero-Trust.

---

## ☁️ Testeado y Desplegado en Oracle Cloud (OCI)
Aunque esta es una versión adaptada para demostración local, toda la arquitectura original ha sido **probada y validada exitosamente en una máquina virtual de Oracle OCI** (con un enfoque especial en aprovechar el "Always Free" tier con instancias ARM Ampere A1, asignando hasta 24GB de RAM).

---

## 🚀 Instalación y Despliegue Local

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/tu-usuario/tu-repositorio.git
   cd tu-repositorio
   ```

2. **Configuración inicial:**
   - Copia el archivo de ejemplo de variables de entorno y ajústalo según tus necesidades predeterminadas:
   ```bash
   cp .env.example .env
   ```
   - *(En Linux)* Ejecuta el script de swap si necesitas asegurar estabilidad de memoria para el LLM:
   ```bash
   chmod +x setup_swap.sh
   sudo ./setup_swap.sh
   ```

3. **Levantar la infraestructura:**
   Inicia todos los servicios con Docker Compose. La primera vez tomará algo de tiempo mientras se descargan las imágenes y los modelos de Ollama.
   ```bash
   docker-compose up -d
   ```

---

## 💻 Cómo Usar esta Demo

1. **Acceder a n8n:**
   Abre tu navegador y dirígete a `http://localhost:5678` (o el puerto que hayas configurado). Sigue las instrucciones de n8n para crear tu cuenta local inicial.
2. **Revisar Credenciales y Conexiones:**
   Asegúrate de que n8n esté conectado correctamente a tus contenedores de Qdrant y Ollama.
3. **Pipeline de Ingesta:**
   Activa y ejecuta el workflow encargado de procesar y vectorizar tus archivos PDF hacia Qdrant.
4. **Interactuar con el Agente AI:**
   Utiliza el workflow de Chatbot/Formulario o consulta el Webhook de prueba de n8n para enviar mensajes y recibir las recomendaciones documentales.

---

## 🌟 Características Destacadas
- **Orquestación Centralizada:** Gestión coordinada de n8n, qdrant, dbs y AI (Ollama) desde un único `docker-compose.yml`.
- **Motor RAG Ultra Rápido:** Extracción lógica de texto y búsqueda semántica con la potencia combinada de Llama 3.2 y Qdrant.
- **Agente Dinámico:** Setup del "AI Agent" en n8n que toma decisiones autónomas sobre cuándo acceder a la base de datos documental antes de elaborar su respuesta.
- **Entorno Privado:** Alternativa robusta *Self-hosted* al uso masivo de servicios cloud centralizados.

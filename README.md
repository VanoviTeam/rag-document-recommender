# 🧠 Sistema automatizado de recomendaciones con IA basado en Documentos (RAG) - [Local Demo]

## 📌 Descripción General del Proyecto
Este proyecto es una versión de demostración **local** de un sistema de recomendaciones con IA basado en documentos. Utiliza técnicas avanzadas de **RAG (Retrieval-Augmented Generation)** para buscar información en una base de datos vectorial y generar recomendaciones basadas estrictamente en los documentos alojados. Todo esto está orquestado mediante flujos de trabajo automatizados en n8n e integrado de manera modular y escalable mediante Docker.

Esta versión está adaptada para ejecutarse fácilmente en cualquier máquina local mediante contenedores, garantizando privacidad y seguridad (Self-hosted AI) al mantener todo el procesamiento lógico y de IA *on-premise*, sin depender de APIs de pago externas.

---

## ⚙️ Requisitos Previos

### Requisitos de Hardware
- **Memoria RAM:** Mínimo 16 GB (recomendado 32 GB o más) debido a la ejecución local de modelos LLM.
- **Almacenamiento:** Al menos 20 GB de espacio libre para las imágenes de Docker, la base de datos vectorial y los modelos de IA.
- **CPU/GPU:** El proyecto viene configurado y optimizado por defecto para ejecutarse en **CPU pura**, lo que permite un despliegue universal garantizado (ideal para hardware tradicional o instancias gratuitas de Cloud sin gráficas). Si dispones de una tarjeta gráfica nativa y deseas aprovecharla para acelerar el LLM, deberás [modificar el passthrough de la GPU en el `docker-compose.yml`](https://docs.docker.com/compose/gpu-support/) según la documentación oficial de Docker.

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
- **Caddy Server:** Proxy Inverso.

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
   - *(Opcional para Linux)* Si te encuentras en un entorno Linux con poca memoria RAM o si vas a levantar el proyecto en un VPS limitado, puedes ejecutar el script de swap adjunto para **añadir 8GB de Swap** y asegurar la estabilidad del modelo LLM. Este paso **no es necesario** si tu máquina local tiene memoria de sobra (16GB+).
   ```bash
   chmod +x setup_swap.sh
   sudo ./setup_swap.sh
   ```
   - *(Opcional para Windows)* Si usas Windows y Docker Desktop (basado en WSL2) con RAM limitada, puedes ejecutar el script específico en PowerShell para **asignar 8GB de Swap** automáticamente al subsistema Docker y evitar que Ollama crashee:
   ```powershell
   .\setup_swap.ps1
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
   Utiliza el workflow de Formulario o consulta el Webhook de prueba de n8n para enviar mensajes y recibir las recomendaciones documentales.

---

## 🌟 Características Destacadas
- **Orquestación Centralizada:** Gestión coordinada de n8n, qdrant, dbs y AI (Ollama) desde un único `docker-compose.yml`.
- **Motor RAG Ultra Rápido:** Extracción lógica de texto y búsqueda semántica con la potencia combinada de Llama 3.2 y Qdrant.
- **Agente Dinámico:** Setup del "AI Agent" en n8n que toma decisiones autónomas sobre cuándo acceder a la base de datos documental antes de elaborar su respuesta.
- **Entorno Privado:** Alternativa robusta *Self-hosted* al uso masivo de servicios cloud centralizados.

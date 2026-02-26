# 🐳 Multi-Stage Dockerfile Guide

## 📖 Overview

A **Multi-Stage Dockerfile** allows you to use multiple `FROM` statements in a single Dockerfile.

Each `FROM` instruction starts a new stage.  
You can copy artifacts from one stage to another using:

```dockerfile
COPY --from=<stage-name>
```

This approach helps create **smaller, secure, and production-ready Docker images**.

---

## 🎯 Why Use Multi-Stage Builds?

### Problems with Single-Stage Build

- Large image size
- Includes build tools in production
- Higher security risk
- Slower deployment

### Benefits of Multi-Stage Build

- Smaller image size
- Removes unnecessary dependencies
- More secure
- Optimized for production
- Faster container startup

---

## 🏗️ Example: Node.js Multi-Stage Dockerfile

```dockerfile
# ---------- Stage 1: Build Stage ----------
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install all dependencies (including dev dependencies)
RUN npm install

# Copy application source code
COPY . .

# Build the application
RUN npm run build


# ---------- Stage 2: Production Stage ----------
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy only built files from builder stage
COPY --from=builder /app/dist ./dist

# Copy dependency files
COPY package*.json ./

# Install only production dependencies
RUN npm install --only=production

# Expose application port
EXPOSE 3000

# Start the application
CMD ["node", "dist/index.js"]
```

---

## 🔎 Step-by-Step Explanation

### 🔹 Stage 1: Builder Stage
- Uses full Node.js environment
- Installs all dependencies (including dev)
- Builds the application
- Contains build tools

### 🔹 Stage 2: Production Stage
- Starts from a clean base image
- Copies only compiled output (`dist`)
- Installs only production dependencies
- Excludes:
  - Dev dependencies
  - Source files
  - Build tools

Result → Lightweight and secure production image ✅

---

## 📦 Build the Docker Image

```bash
docker build -t my-app .
```

---

## ▶️ Run the Container

```bash
docker run -d -p 3000:3000 my-app
```

Now access the application at:

```
http://localhost:3000
```

---

## 🧠 Key Concepts

- `FROM` → Starts a new stage
- `AS builder` → Names a stage
- `COPY --from=builder` → Copies artifacts from another stage
- Final stage → Becomes the actual Docker image

---

## 📊 Image Size Comparison (Conceptual)

| Build Type        | Contains Build Tools | Image Size | Production Ready |
|------------------|---------------------|------------|------------------|
| Single-Stage     | Yes                 | Large      | ❌ No            |
| Multi-Stage      | No                  | Small      | ✅ Yes           |

---

## 🚀 Summary

Multi-stage Docker builds separate:

- **Build-time environment**
- **Runtime environment**

This ensures:
- Clean architecture
- Smaller images
- Better security
- Production optimization

---

### 💡 One-Liner

 Multi-stage builds reduce Docker image size by separating build dependencies from runtime using multiple FROM instructions.

---

# 🐳 What is Docker Compose?

Docker Compose is a tool used to define and run multi-container Docker applications using a single YAML file (`docker-compose.yml`).

Instead of running multiple `docker run` commands, you define everything in one file and start it with:

```bash
docker compose up -d
```

---

# 📌 Why Use Docker Compose?

- Manage multiple containers easily  
- Define networks automatically  
- Configure volumes  
- Pass environment variables  
- Start everything with one command  

---

# 🧱 Basic YAML Sections Explained

## 1️⃣ version

Specifies Compose file version.

```yaml
version: "3.8"
```

---

## 2️⃣ services

Defines the containers.

```yaml
services:
  web:
  db:
```

Each service = one container.

---

## 3️⃣ image

Specifies the Docker image.

```yaml
image: mysql:8
```

---

## 4️⃣ build

Build image from Dockerfile.

```yaml
build: .
```

---

## 5️⃣ ports

Maps container port to host port.

```yaml
ports:
  - "3000:3000"
```

Format:

```
HOST:CONTAINER
```

---

## 6️⃣ environment

Pass environment variables.

```yaml
environment:
  DB_HOST: db
  DB_USER: root
```

---

## 7️⃣ volumes

Used for persistent storage.

```yaml
volumes:
  - db_data:/var/lib/mysql
```

---

## 8️⃣ networks

Defines custom networks.

```yaml
networks:
  appnet:
```

---

# 🎯 Summary

Docker Compose allows you to:

- Define multiple containers
- Configure networking
- Manage volumes
- Pass environment variables
- Run everything with a single command

All using one `docker-compose.yml` file.

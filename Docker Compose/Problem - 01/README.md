# 🚀 Node.js + MySQL Using Docker Compose

This project demonstrates how to run a Node.js application and MySQL database using Docker Compose with:

- Multi-stage Dockerfile
- `.env` file for configuration
- Named volumes for data persistence
- Custom bridge network

---

# 📂 Project Structure

```
.
├── Dockerfile
├── docker-compose.yml
├── .env
```

---

# 📦 .env File

The `.env` file stores environment variables used by both the application and MySQL container.

```env
DB_HOST=mysqldb
DB_USER=root
DB_PASSWORD=rootpass
DB_NAME=mydb

MYSQL_ROOT_PASSWORD=rootpass
MYSQL_DATABASE=mydb
APP_PORT=3000
```

⚠️ Do not commit `.env` to public repositories.

---

# 🐳 Dockerfile (Multi-Stage Build)

```dockerfile
FROM alpine/git AS clone
WORKDIR /app
RUN git clone https://github.com/Code-with-Shravani25/HTMLform_NodeApp.git

FROM node:18
WORKDIR /app
COPY --from=clone /app/HTMLform_NodeApp/. .
RUN npm install
CMD ["npm","start"]
```

This Dockerfile:

- Clones application source code
- Uses Node.js 18 runtime
- Installs dependencies
- Starts the application

---

# ⚙️ docker-compose.yml

```yaml
version: "3.8"

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "${APP_PORT}:3000"
    env_file:
      - .env
    depends_on:
      - mysqldb
    networks:
      - appnetwork

  mysqldb:
    image: mysql:8
    restart: always
    env_file:
      - .env
    volumes:
      - db_data:/var/lib/mysql
    networks:
      - appnetwork

volumes:
  db_data:

networks:
  appnetwork:
    driver: bridge
```

---

# 🔎 Explanation

## Services

### app
- Builds image from Dockerfile
- Uses environment variables from `.env`
- Exposes port `${APP_PORT}` to host
- Depends on MySQL container
- Connected to custom network

### mysqldb
- Uses official MySQL 8 image
- Uses environment variables from `.env`
- Persists data using named volume
- Connected to same custom network

---

## Volumes

```
db_data
```

Used to persist MySQL data even if container is removed.

---

## Networks

```
appnetwork
```

Custom bridge network for communication between containers.

The application connects to MySQL using:

```
DB_HOST=mysqldb
```

Because Docker Compose automatically creates internal DNS.

---

# ▶️ How to Run

Build and start containers:

```bash
docker compose up --build -d
```

Check running containers:

```bash
docker compose ps
```

Stop containers:

```bash
docker compose down
```

---

# 🌐 Access Application

Open browser:

```
http://<server-ip>:3000
```

---

# 🛢 Verify MySQL Data

Enter MySQL container:

```bash
docker exec -it <mysqldb_container_name> mysql -uroot -p
```

Inside MySQL:

```sql
SHOW DATABASES;
USE mydb;
SHOW TABLES;
SELECT * FROM users;
```

---

# 🎯 Features

- Multi-container setup
- Environment-based configuration
- Persistent database storage
- Custom networking
- Clean project structure

---

# 👩‍💻 Author

Shravani Budharam

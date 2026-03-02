# 🚀 Node.js + MySQL Docker Networking Project

This project demonstrates how to link a Node.js application container with a MySQL database container using a custom Docker network.

The application stores form data inside a MySQL database running in another container.

---

## 📌 Architecture

```
User Browser
      ↓
Node.js Container (webapp2)
      ↓
MySQL Container (mysqldb)
```

Both containers communicate using a Docker network.

---

# 🐳 Step 1: Create Dockerfile

```bash
vi Dockerfile
```

Add the following content:

```dockerfile
# Stage 1: Clone Application Code
FROM alpine/git AS clone
WORKDIR /app
RUN git clone https://github.com/Code-with-Shravani25/HTMLform_NodeApp.git

# Stage 2: Build & Run Node App
FROM node:18
WORKDIR /app
COPY --from=clone /app/HTMLform_NodeApp/. .
RUN npm install
CMD ["npm","start"]
```

Save and exit.

---

# 🔨 Step 2: Build Docker Image

```bash
sudo docker build -t nodeapp .
```

---

# 🌐 Step 3: Create Docker Network

```bash
sudo docker network create appnet
```

This network allows containers to communicate using container names.

---

# 🛢 Step 4: Run MySQL Container

```bash
sudo docker run -d \
--name mysqldb \
--network appnet \
-e MYSQL_ROOT_PASSWORD=rootpass \
-e MYSQL_DATABASE=mydb \
mysql:8
```

Environment Variables Used:

- `MYSQL_ROOT_PASSWORD=rootpass`
- `MYSQL_DATABASE=mydb`

---

# 🌍 Step 5: Run Node.js Application Container

```bash
sudo docker run -d \
--name webapp2 \
--network appnet \
-p 3000:3000 \
-e DB_HOST=mysqldb \
-e DB_USER=root \
-e DB_PASSWORD=rootpass \
-e DB_NAME=mydb \
nodeapp
```

Application Environment Variables:

- `DB_HOST=mysqldb`
- `DB_USER=root`
- `DB_PASSWORD=rootpass`
- `DB_NAME=mydb`

Because both containers are in the same Docker network, `mysqldb` works as the hostname.

---

# 🌐 Step 6: Access the Application

Open your browser:

```
http://<Your-Server-IP>:3000
```

Fill the form and submit.

The submitted data will be stored inside the MySQL database.

---

# 🛢 Step 7: Verify Data Inside MySQL Container

Enter into MySQL container:

```bash
sudo docker exec -it mysqldb mysql -uroot -p
```

Enter password when prompted:

```
rootpass
```

Now run the following commands inside MySQL:

```sql
SHOW DATABASES;
USE mydb;
SHOW TABLES;
SELECT * FROM users;
```

You should see the submitted form data in the `users` table.

---

# 🔍 Useful Docker Commands

Check running containers:

```bash
sudo docker ps
```

List Docker networks:

```bash
sudo docker network ls
```

Inspect the network:

```bash
sudo docker network inspect appnet
```

Stop containers:

```bash
sudo docker stop webapp2 mysqldb
```

Remove containers:

```bash
sudo docker rm webapp2 mysqldb
```

---

# 🏁 Summary

- Created multi-stage Dockerfile
- Built Node.js image
- Created custom Docker network
- Ran MySQL container
- Linked application container with database container
- Verified stored data in MySQL

---

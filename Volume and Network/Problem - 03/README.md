# 🐬 Run MySQL Container with Persistent Storage (Docker)

## 📌 Objective

Run a MySQL container using Docker with persistent storage so that:
- Data is not lost when the container is removed
- Database files are stored in a Docker named volume

---

# 🔹 Step 1: Create a Named Volume

```bash
sudo docker volume create mysql-data
```

Verify:

```bash
sudo docker volume ls
```

You should see:

```
mysql-data
```

---

# 🔹 Step 2: Run MySQL Container with Persistent Storage

```bash
sudo docker run -d \
  --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -e MYSQL_DATABASE=mydb \
  -e MYSQL_USER=myuser \
  -e MYSQL_PASSWORD=mypassword \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  mysql:8
```

---

## 🔎 Explanation

- `-d` → Run container in detached mode  
- `--name mysql-container` → Container name  
- `-e MYSQL_ROOT_PASSWORD` → Set root password  
- `-e MYSQL_DATABASE` → Create default database  
- `-e MYSQL_USER` → Create new user  
- `-e MYSQL_PASSWORD` → Password for new user  
- `-p 3306:3306` → Map MySQL port  
- `-v mysql-data:/var/lib/mysql` → Mount volume for persistent storage  
- `mysql:8` → Official MySQL image  

---

# 🔹 Step 3: Verify Container is Running

```bash
sudo docker ps
```

---

# 🔹 Step 4: Connect to MySQL Container

```bash
sudo docker exec -it mysql-container mysql -u root -p
```

Enter password:

```
root123
```

---

# 🔹 Step 5: Create Table and Insert Data

Inside MySQL:

```sql
SHOW DATABASES;
USE mydb;
CREATE TABLE users (id INT, name VARCHAR(50));
INSERT INTO users VALUES (1, 'Docker User');
SELECT * FROM users;
```

Exit:

```sql
exit
```

---

# 🔹 Step 6: Test Data Persistence

Remove container:

```bash
sudo docker rm -f mysql-container
```

Re-run container with SAME volume:

```bash
sudo docker run -d \
  --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  mysql:8
```

Connect again:

```bash
sudo docker exec -it mysql-container mysql -u root -p
```

Check data:

```sql
USE mydb;
SELECT * FROM users;
```

You will see:

```
1 | Docker User
```

✅ Data is preserved even after container deletion.

---

# 🎯 Why Persistent Storage Is Important

- Prevents data loss
- Required for production databases
- Container lifecycle is separate from data lifecycle
- Enables backup & restore
- Supports server migration

---

# 🧠 Interview Points

- MySQL stores data inside:
  ```
  /var/lib/mysql
  ```
- Why use named volume instead of bind mount?
- What happens if volume is deleted?
- How to backup MySQL volume?
- Difference between container data vs volume data

---

# ✅ Cleanup (Optional)

```bash
sudo docker rm -f mysql-container
sudo docker volume rm mysql-data
```

---

🚀 MySQL with Persistent Storage Setup Completed Successfully.

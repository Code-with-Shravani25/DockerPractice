# 📦 Using .env File in Docker

This guide explains how to use a `.env` file to store environment variables and pass them to a Docker container.

---

## 📌 What is a .env File?

A `.env` file is used to store environment variables such as:

- Database passwords  
- API keys  
- Port numbers  
- Configuration values  

Instead of hardcoding them inside Docker commands or application code.

---

# ✅ Step 1: Create `.env` File

Create a new `.env` file:

```bash
vi .env
```

Add the following variables:

```env
PORT=3000
DB_HOST=mysqldb
DB_USER=root
DB_PASSWORD=rootpass
DB_NAME=mydb
```

Save and exit.

---

# ✅ Step 2: Use `.env` in Docker Run Command

Run the container using the `--env-file` option:

```bash
docker run -d \
--name webapp \
--env-file .env \
-p 3000:3000 \
nodeapp
```

✔ All variables inside `.env` are automatically passed to the container.  
✔ The application can access them using `process.env.VARIABLE_NAME`.

---

# 🧠 How It Works

- Docker reads the `.env` file  
- Injects all variables into container environment  
- Your application accesses them at runtime  


---

# 🎯 Summary

- `.env` stores configuration variables
- Keeps sensitive data separate from code
- Passed to container using `--env-file`
- Improves security and maintainability

---

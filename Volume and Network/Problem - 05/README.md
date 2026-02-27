# 🌍 Run Docker Container Using Host Network Mode

## 📌 Objective

- Run a container using host network mode
- Understand how host networking works
- Test application access using localhost or public IP

---

# 🔹 What is Host Network Mode?

In **host network mode**:

- The container shares the host’s network stack
- No separate container IP address
- No port mapping (`-p`) required
- Container uses host machine’s IP directly

---

# 🔹 Step 1: Run Nginx Container in Host Network Mode

```bash
sudo docker run -d --name mynginx --network host nginx
```

---

# 🔎 Important Notes

- Do NOT use `-p` with `--network host`
- Container will bind directly to port 80 on the host
- If port 80 is already in use, container will fail

---

# 🔹 Step 2: Verify Container is Running

```bash
sudo docker ps
```

---

# 🔹 Step 3: Test Application Access

### ✅ From the Same Server

```bash
curl localhost
```

OR

```bash
curl http://127.0.0.1
```

---

### ✅ From Browser (If Running on Cloud / Public Server)

Open browser:

```
http://<your-public-ip>
```

Example:

```
http://13.233.XX.XX
```

You should see the default Nginx welcome page.

---

# 🎯 How Host Networking Works

- Container does NOT get isolated bridge network
- It directly uses host network interfaces
- Faster networking (no NAT)
- Useful for high-performance or monitoring tools

---

# 🧠 Interview Points

- Difference between `bridge` and `host` network
- Why port mapping is not required in host mode
- Security concerns of host networking
- Host mode works only on Linux (not supported the same way on Docker Desktop)

---

# 🔎 Check Listening Port

```bash
sudo ss -tulnp | grep 80
```

You will see nginx process bound to host port 80.

---

# ✅ Cleanup

```bash
sudo docker rm -f mynginx
```

---

🚀 Docker Host Network Mode Demonstration Completed Successfully.

# 🌐 Docker Custom Network – Container Communication Demo

## 📌 Objective

- Create a custom Docker network
- Run two containers in the same network
- Verify communication between containers using container name
- This is an example to expose a container internally but not to the host, as we are not connecting to host port.

---

# 🔹 Step 1: Create a Docker Network

```bash
sudo docker network create mynetwork
```

---

# 🔹 Step 2: Verify Network Creation

```bash
sudo docker network ls
```

You should see:

```
mynetwork
```

---

# 🔹 Step 3: Run First Container in Custom Network

```bash
sudo docker run -dit --name container1 --network mynetwork nginx
```

---

# 🔹 Step 4: Run Second Container in Same Network

```bash
sudo docker run -dit --name container2 --network mynetwork nginx
```

---

# 🔹 Step 5: Verify Containers are Running

```bash
sudo docker ps
```

---

# 🔹 Step 6: Verify Communication Between Containers

Enter first container:

```bash
sudo docker exec -it container1 /bin/bash
```

Install curl (if not available):

```bash
apt update && apt install -y curl
```

Test communication:

```bash
curl container2
```

If successful, you will see the default Nginx HTML page.

---

# 🎯 How It Works

- Docker custom network provides built-in DNS.
- Containers can communicate using container names.
- No need to expose ports externally.
- Communication happens internally within Docker network.

---

# 🧠 Interview Points

- Default network type created is `bridge`.
- Difference between default bridge and user-defined bridge.
- User-defined networks support automatic DNS resolution.
- Containers in different networks cannot communicate unless connected manually.

---

# 🔎 Optional: Inspect Network

```bash
sudo docker network inspect mynetwork
```

---

# ✅ Cleanup (Optional)

```bash
sudo docker rm -f container1 container2
sudo docker network rm mynetwork
```

---

🚀 Docker Custom Network Communication Successfully Completed.

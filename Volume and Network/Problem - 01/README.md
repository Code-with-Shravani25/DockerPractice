# 🐳 Docker Named Volume – Data Persistence Demo

## 📌 Problem Statement

Create a named volume and mount it to a container.  
Verify that data persists even after deleting the container.

---

## 🔹 Step 1: Create a Named Volume

```bash
sudo docker volume create myvolume
```

### ✅ Verify Volume Creation

```bash
sudo docker volume ls
```

You should see `myvolume` listed.

---

## 🔹 Step 2: Run a Container and Mount the Volume

```bash
sudo docker run -dit --name mycontainer -v myvolume:/data ubuntu
```

### 🔎 Explanation

- `-d` → Run container in detached mode  
- `-i` → Interactive mode  
- `-t` → Allocate terminal  
- `--name mycontainer` → Assign container name  
- `-v myvolume:/data` → Mount named volume to `/data` inside container  

---

## 🔹 Step 3: Enter the Container

```bash
sudo docker exec -it mycontainer /bin/bash
```

---

## 🔹 Step 4: Create a File Inside the Volume

```bash
echo "Hello Docker" > /data/file.txt
```

Verify file:

```bash
ls /data
```

Exit container:

```bash
exit
```

---

## 🔹 Step 5: Delete the Container

```bash
sudo docker rm -f mycontainer
```

⚠️ This deletes the container but NOT the volume.

---

## 🔹 Step 6: Create a New Container Using the Same Volume

```bash
sudo docker run -dit --name newcontainer -v myvolume:/data ubuntu
```

---

## 🔹 Step 7: Enter the New Container

```bash
sudo docker exec -it newcontainer /bin/bash
```

---

## 🔹 Step 8: Verify Data Persistence

```bash
ls /data
```

You should see:

```
file.txt
```

Check file content:

```bash
cat /data/file.txt
```

Output:

```
Hello Docker
```

---

# 🎯 Conclusion

- Named volumes store data outside the container filesystem.
- Deleting a container does NOT delete the volume.
- Data persists across multiple containers.
- Docker manages volumes under `/var/lib/docker/volumes/`.

---

# 🧠 Interview Points

- Difference between Named Volume and Bind Mount
- How to inspect a volume:

```bash
sudo docker volume inspect myvolume
```

- How to remove a volume:

```bash
sudo docker volume rm myvolume
```

---

# ✅ Cleanup (Optional)

```bash
sudo docker rm -f newcontainer
sudo docker volume rm myvolume
```

---

🚀 Docker Volume Data Persistence Demonstration Completed Successfully.

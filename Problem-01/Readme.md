# 🐳 Docker Installation and Basic Commands

This document contains Docker installation steps and commonly used Docker commands for DevOps and interview practice.

---

## 1️⃣ Install and Verify Docker

```bash
sudo apt update
sudo apt install docker.io -y
docker --version
```

### Add User to Docker Group (Not Recommended for Production)

```bash
sudo usermod -aG docker <username>
```

⚠️ In production environments, direct Docker access is not allowed.
We use CI/CD pipelines and container orchestration tools.
Access is controlled via IAM and RBAC. Only limited admin users have Docker privileges.

---

## 2️⃣ Verify Docker Daemon is Running

### Method 1

```bash
systemctl status docker
```

### Method 2

```bash
sudo docker info
```

### Method 3

```bash
ps -ef | grep dockerd
```

---

## 3️⃣ Pull and Run a Container

```bash
sudo docker pull ubuntu
sudo docker run ubuntu
```

---

## 4️⃣ Run Nginx Container in Detached Mode

```bash
sudo docker run -d --name web -p 8080:80 nginx
```

Access in browser:

```
http://<public-ip>:8080
```

**Explanation:**

* `-d` → Run in detached mode
* `--name` → Assign container name
* `-p 8080:80` → Map host port 8080 to container port 80

---

## 5️⃣ List, Stop, and Remove Containers

### List running containers

```bash
sudo docker ps
```

### List all containers (including stopped)

```bash
sudo docker ps -a
```

### Stop a container

```bash
sudo docker stop <container_name/id>
```

### Remove a stopped container

```bash
sudo docker rm <container_name/id>
```

### Remove all stopped containers

```bash
sudo docker container prune
```

### Remove unused images

```bash
sudo docker image prune
```

### Remove running container

**Method 1 (Stop then Remove):**

```bash
sudo docker stop <container_name/id>
sudo docker rm <container_name/id>
```

**Method 2 (Force Remove):**

```bash
sudo docker rm -f <container_name/id>
```

---

## 6️⃣ Image Commands

### Remove image

```bash
sudo docker rmi <image_name/id>
```

### Pull image

```bash
sudo docker pull <image_name/id>
```

### List images

```bash
sudo docker images
```

---

## 7️⃣ Inspect a Container

```bash
sudo docker inspect <container_name/id>
```

---

## 8️⃣ Run Interactive Container

**Ubuntu:**

```bash
sudo docker run -it ubuntu /bin/bash
```

**Alpine (does not have bash):**

```bash
sudo docker run -it alpine sh
```
*Alpine doesn’t include bash by default because it is designed to be minimal and lightweight. It uses BusyBox and /bin/sh instead of bash to keep the image size small, reduce dependencies, and improve security. If needed, bash can be installed manually using apk add bash.

---

## 9️⃣ Execute Shell Inside Running Container

```bash
sudo docker exec -it <container_name> /bin/bash
```

---

## 🔟 Rename a Running Container

```bash
sudo docker rename <old_container_name> <new_container_name>
```

---

# 📌 Production Notes

* Avoid giving direct Docker access to users.
* Use CI/CD pipelines for deployments.
* Use container orchestration tools.
* Control access using IAM and RBAC.
* Follow the principle of least privilege.

---

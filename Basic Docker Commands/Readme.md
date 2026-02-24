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

```bash
systemctl status docker //Method1
sudo docker info //Method2
ps -ef | grep dockerd //Method3
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

### Custom Webpage

```bash
sudo docker cp index.html web:/usr/share/nginx/html/index.html
```

Access:

```
http://<public-ip>:8080
```

---

## 5️⃣ Container Management

```bash
sudo docker ps
sudo docker ps -a
sudo docker stop <container>
sudo docker rm <container>
sudo docker rm -f <container>
sudo docker container prune
sudo docker image prune
```

---

## 6️⃣ Image Commands

```bash
sudo docker images
sudo docker pull <image>
sudo docker rmi <image>
```

---

## 7️⃣ Inspect Container & Get IP

```bash
sudo docker inspect <container>
```

Get only IP:

```bash
sudo docker inspect <container> --format '{{.NetworkSettings.IPAddress}}'
```

---

## 8️⃣ Interactive Container

```bash
sudo docker run -it ubuntu /bin/bash
sudo docker run -it alpine sh
sudo docker exec -it <container> /bin/bash
```

---

## 9️⃣ Logs

```bash
sudo docker logs <container>
sudo docker logs -f <container>
sudo docker logs --tail 50 <container>
```

---

## 🔟 Resource Limits

### Memory Limit

```bash
sudo docker run -m 256m nginx
sudo docker run --memory=256m nginx
```

### CPU + Memory Limit

```bash
sudo docker run -d --name nginxlimited -p 8080:80 --memory="256m" --cpus="0.5" nginx
```

Check usage (live streaming view):

```bash
sudo docker stats
```

To view one-time resource usage:

```bash
docker stats --no-stream <container_name/id>
```

---

## 1️⃣1️⃣ Restart Policies

```bash
sudo docker run -d --name webapp -p 8080:80 --restart=always nginx
```

Test restart:

```bash
sudo systemctl restart docker
docker ps
```

Restart options:

```
--restart=no                # Default, no restart
--restart=on-failure        # Restart only on non-zero exit
--restart=on-failure:5      # Maximum 5 retries
--restart=unless-stopped    # Restart unless manually stopped
--restart=always            # Always restart
```

---

## 1️⃣2️⃣ Copy Files

### Host → Container

```bash
sudo docker cp <host_path> <container>:<container_path>
```

### Container → Host

```bash
sudo docker cp <container>:<container_path> <host_path>
```

---

## 1️⃣3️⃣ Docker Hub Login & Push

```bash
sudo docker login -u <username>
sudo docker tag <image>:<tag> <username>/<image>:<tag>
sudo docker push <username>/<image>:<tag>
```

Pull private image:

```bash
sudo docker login -u <username>
sudo docker pull <username>/<image>:<tag>
```

---

## 1️⃣4️⃣ Export & Import (Container Level)

### Export Container (No History, No Layers)

```bash
sudo docker container export <container> -o image.tar
```

### Import as Image

```bash
sudo docker image import image.tar newimage
```

Run container from imported image:

```bash
sudo docker run --name mycontainer newimage
```

### Explanation

* `docker export` exports a container’s filesystem (current state) into a `.tar` file.
* `docker import` creates a new image from that exported `.tar` file.
* Works on **containers**, not images.
* Does **not** preserve image layers, history, metadata (environment variables, CMD, ENTRYPOINT, tags).
* Useful for:

  * Sharing container’s current state
  * Moving container filesystem to another host
  * Taking container filesystem backup

---

## 1️⃣5️⃣ Save & Load (Image Level)

### Save Image (With Layers & History)

```bash
sudo docker save -o image.tar imagename:tag
```

### Transfer to Another Server

Generate SSH key and copy to target server’s `authorized_keys`.

```bash
scp image.tar user@privateip:/home/user
```

Ensure Docker is installed on the target server.

### Load Image on Target Server

```bash
sudo docker load -i image.tar
```

### Explanation

* `docker save` saves a Docker image into a `.tar` file.
* `docker load` loads the image back from the `.tar` file.
* Works on **images**, not running containers.
* Preserves:

  * Image layers
  * Tags
  * History
* Perfect for transferring images exactly as they are.

---

# 🔍 Difference: Export vs Save

| Feature            | docker export               | docker save             |
| ------------------ | --------------------------- | ----------------------- |
| Works On           | Container                   | Image                   |
| Keeps Layers       | ❌ No                        | ✅ Yes                   |
| Keeps History      | ❌ No                        | ✅ Yes                   |
| Preserves Metadata | ❌ No                        | ✅ Yes                   |
| Use Case           | Container filesystem backup | Image backup & transfer |

`docker import` is used with `export`
`docker load` is used with `save`

---

# 🧹 Dangling Images

Dangling images are Docker images that:

* Have `<none>` as repository and tag
* Are not used by any container
* Usually created during builds (intermediate layers)
* Consume disk space but are not useful for running containers

Check dangling images:

```bash
sudo docker images -f dangling=true
```

Remove dangling images:

```bash
sudo docker image prune
```

---

# 📌 Production Notes

* Avoid direct Docker access
* Use CI/CD pipelines
* Use orchestration tools
* Follow IAM & RBAC
* Apply least privilege principle

---

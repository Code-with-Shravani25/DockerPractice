# 📦 ARG vs ENV in Dockerfile

Understanding the difference between `ARG` and `ENV` in a Dockerfile is essential for writing secure, flexible, and production-ready container images.

---

# 🔹 What is ARG in Dockerfile?

`ARG` is a **build-time variable**.

It allows you to pass variables during the image build process using the `docker build` command.

## ✅ Key Characteristics of ARG

- Available **only during image build**
- Not available inside the running container (unless explicitly passed to ENV)
- Can be overridden using `--build-arg`
- Does NOT persist in the final container
- Mainly used for:
  - Version numbers
  - Base image selection
  - Build-time configuration

---

## 📌 Example of ARG

```dockerfile
FROM ubuntu

ARG APP_VERSION=1.0
RUN echo "Building version $APP_VERSION"
```

---

# 🔄 How to Change ARG at Build Time

Use the `--build-arg` flag:

```bash
docker build -t myapp --build-arg APP_VERSION=2.0 .
```

✔ This overrides the default value `1.0`  
✔ The value is used only during build  
❌ The value is NOT available when the container runs  

---

# 🔹 What is ENV in Dockerfile?

`ENV` is a **runtime environment variable**.

It sets environment variables that are available:

- During build (after declaration)
- Inside the running container
- Persist in the final image

---

## 📌 Example of ENV

```dockerfile
FROM ubuntu

ENV APP_ENV=production
CMD ["sh", "-c", "echo $APP_ENV"]
```

Run container:

```bash
docker run myimage
```

Output:
```
production
```

✔ Available at runtime  
✔ Available inside container  

---

# 🔄 How to Change ENV at Runtime

You can override `ENV` variables using the `-e` flag with `docker run`.

```bash
docker run -e APP_ENV=development myimage
```

Now the output will be:
```
development
```

✔ Runtime value overrides Dockerfile value  
✔ Does not modify the image permanently  

---

# 🔁 ARG vs ENV – Key Differences

| Feature | ARG | ENV |
|----------|------|------|
| Available during build | ✅ Yes | ✅ Yes |
| Available during runtime | ❌ No | ✅ Yes |
| Can be overridden | ✅ `--build-arg` | ✅ `-e` at runtime |
| Persists in final image | ❌ No | ✅ Yes |
| Used for | Build configuration | Runtime configuration |

---

# 🎯 When to Use ARG?

Use `ARG` when:

- You need values only during image build
- You want to parameterize:
  - Base image versions
  - Application version
  - Temporary build settings
- You do NOT want the value to exist inside the running container

### Example: Dynamic Base Image

```dockerfile
ARG BASE_IMAGE=ubuntu
FROM ${BASE_IMAGE}
```

---

# 🎯 When to Use ENV?

Use `ENV` when:

- You need variables inside the running container
- You want to configure application behavior
- You need environment variables accessible by the application

### Example:

```dockerfile
ENV NODE_ENV=production
```

Override at runtime:

```bash
docker run -e NODE_ENV=development myimage
```

---

# 🔁 Using ARG and ENV Together

You can combine both:

```dockerfile
FROM ubuntu

ARG APP_VERSION=1.0
ENV APP_VERSION=${APP_VERSION}

CMD ["sh", "-c", "echo $APP_VERSION"]
```

Now:

- `APP_VERSION` can be passed during build
- It is also available during runtime

Build with custom value:

```bash
docker build -t myapp --build-arg APP_VERSION=2.0 .
```

Run container:

```bash
docker run myapp
```

Output:
```
2.0
```

---

# 🧠 Best Practice Recommendations

- Use `ARG` for build-time configuration.
- Use `ENV` for runtime configuration.
- Do NOT store secrets in `ARG` or `ENV`.
- Keep build variables separate from runtime variables.
- Use `-e` flag or `.env` files for environment-specific deployments.

---

# 📌 Summary

- `ARG` → Build-time only
- `ENV` → Runtime + build-time
- Change `ARG` → `--build-arg`
- Change `ENV` → `-e` at runtime
- Choose based on when the variable is needed

---

## 🚀 Final Rule of Thumb

If the variable is needed **only while building the image** → Use `ARG`  
If the variable is needed **when the container runs** → Use `ENV`

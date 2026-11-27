# 🐳 Chapter 11: Container Technologies: Docker and Docker Compose

📓 **Interactive Lab:** [chapter_11_containers_docker.ipynb](chapter_11_containers_docker.ipynb)  
📚 **Book Reference:** Chapter 11, *Container Technologies: Docker and Docker Compose* (pp. 430–465)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
Containers eliminate "works on my machine" drift by packaging your app, Python runtime, and OS libraries into immutable images. Understanding multi-stage `Dockerfile`s, `docker compose` v2, non-root users, and `sops` secrets is mandatory for modern DevOps.

> **🎯 Key idea:** Multi-stage `python:3.12-slim` Dockerfiles, non-root `USER`, `HEALTHCHECK`, and `docker compose` v2 deliver fast, secure, portable containers.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_11_containers_docker.ipynb](chapter_11_containers_docker.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 435–460 | Chapters 4, 10 | Intermediate |

## 🎯 Learning Objectives
- Explain Linux namespaces, cgroups, and UnionFS vs. full hypervisor VMs.
- Author modern multi-stage `Dockerfile`s (`python:3.12-slim`, non-root `USER`, `HEALTHCHECK`, `.dockerignore`).
- Orchestrate multi-container stacks (`app`, `db`, `redis`) with **`docker compose`** (v2, no `version:` key).
- Manage secrets safely with `sops` + PGP/KMS.

## 🧱 Prerequisites
- [Chapter 4 — Linux Utilities](../04_linux_utilities/README.md) & [Chapter 10 — Infrastructure as Code](../10_infrastructure_as_code/README.md).

## ⚙️ Modern Docker Artifacts (Then ~2020 vs. Now)

### Commented Multi-Stage `Dockerfile`
> **Then (book, ~2020) vs. Now:** The book uses `python:3.7.3-alpine` and `docker-compose` (v1). Today, **`-slim`** (`python:3.12-slim`) is preferred over `-alpine` because musl libc lacks prebuilt wheels for many Python packages (like `pandas`/`numpy`), and **`docker compose`** (v2) drops the hyphen and top-level `version:` key.

```dockerfile
# Stage 1: Builder (compiles wheels without bloating final image)
FROM python:3.12-slim AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt

# Stage 2: Minimal runtime image
FROM python:3.12-slim
WORKDIR /app
RUN useradd --create-home appuser      # Create non-root user
COPY --from=builder /wheels /wheels
RUN pip install --no-cache-dir /wheels/* && rm -rf /wheels
COPY . .
USER appuser                           # Drop root privileges
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=3s CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000/health')"
CMD ["python", "app.py"]
```

### Commented `compose.yaml` (Docker Compose v2)
```yaml
services:                              # No top-level 'version:' key in Compose v2
  app:
    build: .
    ports:
      - "5000:5000"
    depends_on:
      db:
        condition: service_healthy
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_PASSWORD: ${DBPASS}     # Injected via sops/env, never hardcoded
    volumes:
      - dbdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      retries: 5
volumes:
  dbdata:
```

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Binding `127.0.0.1` in container | Connection refused on `localhost:5000` | Bind Flask/uvicorn to `0.0.0.0` |
| Missing `.dockerignore` | Copies `.git/` & `.env` into image | Exclude `.git`, `.venv`, `.env` |
| Exit code `137` | Container OOMKilled (`SIGKILL`) | Increase memory limit or optimize RAM |

### Notes
- **Binding `127.0.0.1` inside a container**: Unreachable from host `-p 5000:5000`; always bind `0.0.0.0`.
- **Missing `.dockerignore`**: Copies `.git/`, `.venv/`, and `.env` secrets into the build context.
- **Exit code `137`**: Container was OOMKilled (`SIGKILL`); raise memory limits.

## 🔗 Related Chapters
- **Previous:** [Chapter 10 — Infrastructure as Code](../10_infrastructure_as_code/README.md)
- **Next:** [Chapter 12 — Kubernetes](../12_kubernetes/README.md)

## 📝 Skipped Book Topics
- Skipped: `docker push` to Docker Hub and EC2 Ubuntu provisioning.

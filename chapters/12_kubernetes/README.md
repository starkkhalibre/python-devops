# ☸️ Chapter 12: Container Orchestration: Kubernetes

📓 **Interactive Lab:** [chapter_12_kubernetes.ipynb](chapter_12_kubernetes.ipynb)  
📚 **Book Reference:** Chapter 12, *Container Orchestration: Kubernetes* (pp. 466–511)  
⏱️ **Estimated Study Time:** 3 hours

## 📖 Why This Chapter Matters
Docker Compose runs on one machine; Kubernetes schedules, heals, and scales containers across a cluster declaratively. Mastering Pods, Deployments (`apps/v1`), Services, PVCs, Secrets, and Helm 3 is core to production cloud-native DevOps.

> **🎯 Key idea:** Kubernetes (`apps/v1` Deployments, Services, Probes, and Helm 3) schedules and self-heals containers across multi-node clusters.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_12_kubernetes.ipynb](chapter_12_kubernetes.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 470–507 | Chapter 11 | Advanced |

## 🎯 Learning Objectives
- Explain Nodes, Pods, `initContainers`, Deployments (`apps/v1`), Services, PVCs, and Secrets.
- Author and validate Deployment/Service YAML manifests (`resources.limits`, `readinessProbe`, `livenessProbe`).
- Deploy locally with `kind` or `minikube`, and install Prometheus/Grafana using **Helm 3**.
- Troubleshoot `CrashLoopBackOff`, `ImagePullBackOff`, and GKE `lost+found` PVC errors.

## 🧱 Prerequisites
- [Chapter 11 — Containers & Docker](../11_containers_docker/README.md).

## ⚙️ Commented Kubernetes YAML & Modern Helm 3 Commands

> **Then (book, ~2020) vs. Now:** The book uses Helm v2 (`helm init`, `--name`, deprecated `stable/prometheus`) and `minikube` v1.15. Today, **Helm 3** has no Tiller, no `--name` flag, and uses **`prometheus-community`**. For local clusters, **`kind`** (Kubernetes in Docker) is a fast alternative to `minikube`, and `kompose` is best used only for initial bootstrapping.

### Commented Deployment + Service YAML (`deployment.yaml`)
```yaml
apiVersion: apps/v1                    # Stable Deployment API version
kind: Deployment
metadata:
  name: flask-api
  labels:
    app: flask-api
spec:
  replicas: 2                          # >= 2 replicas for high availability
  selector:
    matchLabels:
      app: flask-api                   # Must match template.metadata.labels
  template:
    metadata:
      labels:
        app: flask-api
    spec:
      containers:
        - name: flask-api
          image: myuser/flask-api:1.0.0  # Pin immutable tag (never :latest)
          ports:
            - containerPort: 5000
          resources:
            limits:                    # Prevent noisy-neighbor node OOMs
              cpu: "500m"
              memory: "256Mi"
          readinessProbe:              # Only route Service traffic when /health returns 200
            httpGet:
              path: /health
              port: 5000
```

### Modern Helm 3 Commands
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus -n monitoring --create-namespace
kubectl -n monitoring port-forward svc/prometheus-server 9090:80
```

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Using `:latest` image tags | Nodes serve stale cached images | Pin immutable SemVer/SHA tags |
| Missing `resources.limits` | One Pod OOMs entire worker node | Set `cpu` & `memory` limits |
| GKE PVC `lost+found` crash | Postgres `initdb` fails (`CrashLoopBackOff`) | Delete `lost+found/` via temp `busybox` pod |

### Notes
- **Using `:latest` image tags**: Nodes cache stale layers; always pin SemVer or Git SHA tags.
- **Missing `resources.limits`**: One leaking Pod can OOM-crash a whole worker node.
- **GKE Postgres PVC `lost+found` crash**: Mount the PVC on a temporary `busybox` pod and remove `lost+found/`.

## 🔗 Related Chapters
- **Previous:** [Chapter 11 — Docker](../11_containers_docker/README.md)
- **Next:** [Chapter 13 — Serverless Technologies](../13_serverless/README.md)

## 📝 Skipped Book Topics
- Skipped: Provisioning paid GKE clusters and Prometheus/Grafana LoadBalancers in GCP.

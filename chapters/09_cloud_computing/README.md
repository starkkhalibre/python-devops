# ☁️ Chapter 9: Cloud Computing

📓 **Interactive Lab:** [chapter_09_cloud_computing.ipynb](chapter_09_cloud_computing.ipynb)  
📚 **Book Reference:** Chapter 9, *Cloud Computing* (pp. 344–391)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
Cloud platforms turn servers, networks, and queues into API calls. To automate them reliably, you must understand IaaS/PaaS/FaaS trade-offs, Python's GIL vs. `ThreadPoolExecutor`/`multiprocessing`, `boto3` paginators/waiters/retries, and offline testing with `moto`.

> **🎯 Key idea:** Choose `ThreadPoolExecutor` for I/O-bound cloud APIs, `multiprocessing` for CPU work, and `boto3` paginators/retries/IAM roles for reliability.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_09_cloud_computing.ipynb](chapter_09_cloud_computing.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 358–386 | Chapters 3, 7 | Intermediate |

## 🎯 Learning Objectives
- Compare Public, Private, Hybrid, and Multicloud models and IaaS/PaaS/FaaS/SaaS services.
- Explain HVM vs. PV, Amdahl's Law, the CAP Theorem, and Spot/Preemptible instances.
- Use `ThreadPoolExecutor` for parallel cloud API calls and `multiprocessing.Pool` for CPU work.
- Configure `boto3` with `botocore.config.Config` retries, paginators, waiters, and IAM roles (no hardcoded keys).

## 🧱 Prerequisites
- [Chapter 3 — Command Line](../03_command_line/README.md) & [Chapter 7 — Monitoring & Logging](../07_monitoring_and_logging/README.md).

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Hardcoding AWS keys | Credential compromise in Git | Use IAM roles / OIDC / env vars |
| Omitting `get_paginator()` | Silently misses keys > 1,000 | Always paginate list APIs |
| Lambdas in `Pool.map` (3.14) | `PicklingError` under `forkserver` | Use top-level functions or built-ins |

### Notes
- **Hardcoding `aws_access_key_id` in code**: Use IAM roles (EC2/ECS/Lambda/OIDC) or `~/.aws/credentials`.
- **Unbounded `ThreadPoolExecutor` pools**: Flooding cloud APIs triggers `ThrottlingException`; cap `max_workers` and use `botocore.config.Config(retries={'mode': 'standard'})`.
- **Using `boto3.client('s3').list_objects_v2()` without a paginator**: Silently truncates at 1,000 objects.

## 🔗 Related Chapters
- **Previous:** [Chapter 8 — Pytest for DevOps](../08_pytest_for_devops/README.md)
- **Next:** [Chapter 10 — Infrastructure as Code](../10_infrastructure_as_code/README.md)

## 📝 Skipped Book Topics
- Skipped: Launching real EC2 Spot Instances / AWS Lambda deployments (simulated safely via mocks).

## 🔄 Then vs. Now

| Topic | 📜 Then (book, ~2020) | 🆕 Now (2026) | Why it changed |
| --- | --- | --- | --- |
| `boto3` calls | Raw `list_objects_v2()` + static keys | `get_paginator()`, `botocore.config.Config`, IAM roles | Avoids 1,000-item truncation & leaked keys |
| Offline AWS testing | Live AWS account only | `moto` mock library + unit tests | Zero cost & fast CI feedback |

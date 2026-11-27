# ⚡ Chapter 13: Serverless Technologies

📓 **Interactive Lab:** [chapter_13_serverless.ipynb](chapter_13_serverless.ipynb)  
📚 **Book Reference:** Chapter 13, *Serverless Technologies* (pp. 512–573)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
Serverless (FaaS & CaaS) removes VM patching and idle server costs by scaling automatically per request or event. You still own IAM least-privilege, cold-start latency, idempotency, and DynamoDB capacity planning.

> **🎯 Key idea:** FaaS (AWS Lambda, Cloud Run functions, Azure Functions v2) scales to zero per event, requiring idempotency and JSON proxy serialization.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_13_serverless.ipynb](chapter_13_serverless.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 518–569 | Chapters 9, 12 | Advanced |

## 🎯 Learning Objectives
- Choose between FaaS (AWS Lambda, Cloud Run functions, Azure Functions) and CaaS (AWS Fargate, Cloud Run).
- Write API Gateway proxy-compatible Lambda handlers and HMAC webhook validators.
- Compare the book's 2020 Serverless Framework / CDK v1 examples with **AWS SAM / CDK v2**, **Python 3.12/3.13 Lambda runtimes**, **Cloud Run functions**, and **Azure Functions v2**.

## 🧱 Prerequisites
- [Chapter 9 — Cloud Computing](../09_cloud_computing/README.md) & [Chapter 12 — Kubernetes](../12_kubernetes/README.md).

## ⚙️ Then (Book, ~2020) vs. Now
- **Then**: Lambda Python 3.7, AWS CDK v1 (`@aws-cdk/*`), Google Cloud Functions, Azure Functions v1 `function.json`.
- **Now**: Lambda **Python 3.12 / 3.13**, **AWS CDK v2** (`aws-cdk-lib`) or **AWS SAM**, **Cloud Run functions**, and **Azure Functions v2** Python decorator programming model (`@app.route`).

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Returning raw dict as `body` | `502 Bad Gateway` in API Gateway | Serialize with `json.dumps(payload)` |
| Fixed `read_capacity=10` | `ProvisionedThroughputExceededException` | Use `BillingMode.PAY_PER_REQUEST` |
| Relying on `/tmp` across calls | Missing state on cold starts | Persist state in DynamoDB or S3 |

### Notes
- **Returning a raw dict as `body`**: API Gateway proxy integration requires `body` to be a JSON string (`json.dumps(...)`), otherwise it returns `502 Bad Gateway`.
- **Fixed DynamoDB `read_capacity=10` under load**: Causes throttling; use `BillingMode.PAY_PER_REQUEST`.
- **Cost & cleanup**: Always run `cdk destroy` or `serverless remove` after testing cloud stacks.

## 🔗 Related Chapters
- **Previous:** [Chapter 12 — Kubernetes](../12_kubernetes/README.md)
- **Next:** [Chapter 14 — MLOps](../14_mlops/README.md)

## 📝 Skipped Book Topics
- Skipped: Live AWS/GCP/Azure deployments and `k3sup` EC2 OpenFaaS installation.

## 🔄 Then vs. Now

| Topic | 📜 Then (book, ~2020) | 🆕 Now (2026) | Why it changed |
| --- | --- | --- | --- |
| AWS Lambda & CDK | Python 3.7, CDK v1 (`@aws-cdk/*`) | Python 3.12/3.13, CDK v2 (`aws-cdk-lib`) / SAM | EOL runtimes & unified CDK v2 |
| GCP & Azure | Cloud Functions, Azure v1 `function.json` | Cloud Run functions, Azure v2 `@app.route` | Unified GCP runtime & Pythonic Azure |

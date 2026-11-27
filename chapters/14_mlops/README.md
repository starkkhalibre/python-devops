# 🤖 Chapter 14: MLOps and Machine Learning Engineering

📓 **Interactive Lab:** [chapter_14_mlops.ipynb](chapter_14_mlops.ipynb)  
📚 **Book Reference:** Chapter 14, *MLOps and Machine Learning Engineering* (pp. 574–619)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
An ML model inside a notebook delivers no value until it is reproducible, tracked, containerized, and monitored in production. This chapter applies CI/CD, Docker, and Kubernetes to `scikit-learn` / `PyTorch` workflows, and adds modern **MLflow** experiment tracking + **pickle/joblib security** warnings.

> **🎯 Key idea:** Treat ML models as versioned microservices: prevent train/serve skew, track runs with MLflow, and never deserialize untrusted `joblib`/`pickle` files.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_14_mlops.ipynb](chapter_14_mlops.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 578–614 | Chapters 11–12 | Advanced |

## 🎯 Learning Objectives
- Follow the 5-step ML workflow: **Ingest -> EDA -> Modeling -> Evaluation (RMSE) -> Serve**.
- Apply the 6-level ML Maturity Model (ROI framing -> Data Lake -> Clean Data -> EDA -> AutoML -> Feedback Loop).
- Track experiments with **MLflow** and avoid untrusted `pickle`/`joblib` deserialization vulnerabilities.

## 🧱 Prerequisites
- [Chapter 11 — Docker](../11_containers_docker/README.md) & [Chapter 12 — Kubernetes](../12_kubernetes/README.md).

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Fitting scaler before split | Inflated test accuracy (leakage) | Split first, then fit on `X_train` |
| Loading untrusted `.joblib` | Remote code execution risk | Only load signed/trusted artifacts |
| No `/predict` input validation | `500` crash on bad JSON | Validate types & return `400` |

### Notes
- **Data leakage**: Fitting `StandardScaler` on the full dataset before `train_test_split` leaks test statistics.
- **Security (`pickle` / `joblib`)**: Loading untrusted `.joblib` or `.pkl` files executes arbitrary Python code (`__reduce__`); only deserialize artifacts from trusted CI/registry pipelines (or use `safetensors`/`ONNX`).
- **Missing `/predict` schema validation**: Passing malformed JSON causes `500` crashes instead of `400`.

## 🔗 Related Chapters
- **Previous:** [Chapter 13 — Serverless](../13_serverless/README.md)
- **Next:** [Chapter 15 — Data Engineering](../15_data_engineering/README.md)

## 📝 Skipped Book Topics
- Skipped: Google Colab GPU training on 25k-row CSV and live EKS cluster deployment.

## 🔄 Then vs. Now

| Topic | 📜 Then (book, ~2020) | 🆕 Now (2026) | Why it changed |
| --- | --- | --- | --- |
| Tracking & registry | Ad-hoc `.joblib` files on disk | MLflow tracking + versioned model registry | Reproducible metrics, params & rollbacks |
| Serialization security | Unchecked `joblib.load()` | Trusted registries only or `ONNX`/`safetensors` | `pickle`/`joblib` execute arbitrary code |

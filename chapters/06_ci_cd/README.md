# 🔄 Chapter 6: Continuous Integration and Continuous Deployment

📓 **Interactive Lab:** [chapter_06_ci_cd.ipynb](chapter_06_ci_cd.ipynb)  
📚 **Book Reference:** Chapter 6, *Continuous Integration and Continuous Deployment* (pp. 236–262)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
Manual deployments don't scale and inevitably cause human errors. CI/CD automates linting, testing, artifact building, and deployment so every commit is verified consistently before reaching users.

> **🎯 Key idea:** Fail-fast CI gates verify syntax, tests, and artifacts on every commit so only immutable, validated builds reach production.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_06_ci_cd.ipynb](chapter_06_ci_cd.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 236–262 | Chapters 3, 5 | Intermediate |

## 🎯 Learning Objectives
- Distinguish Continuous Integration, Continuous Delivery (manual prod gate), and Continuous Deployment (fully automated).
- Compare modern **GitHub Actions** workflows with the book's Jenkinsfile, AWS CodePipeline (`buildspec.yml`), GCP `cloudbuild.yaml`, and NFSOPS (`rsync` + EFS).
- Write Python CI scripts for content conversion, syntax/test gates, artifact bundling, and canary rollback decisions.

## 🧱 Prerequisites
- [Chapter 3 — Command Line](../03_command_line/README.md) & [Chapter 5 — Package Management](../05_package_management/README.md).

## ⚙️ Modern GitHub Actions vs. Legacy Book Pipelines

### Now: GitHub Actions (`.github/workflows/ci.yml`)
```yaml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.11", "3.12", "3.13"]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
          cache: pip
      - run: pip install -r requirements.txt
      - run: pytest -v
```

### Then (Book, ~2020): AWS CodePipeline `buildspec.yml`, GCP `cloudbuild.yaml`, Jenkins + EFS
- **AWS CodePipeline**: `hugo` build -> `aws s3 sync public/ s3://bucket --delete` -> CloudFront invalidation.
- **GCP Cloud Build**: `pip install` -> `pylint` -> `gcloud app deploy`.
- **NFSOPS**: Jenkins `rsync -az --delete` to Amazon EFS mounted by Spot Instances.

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Swallowing non-zero exit codes | Broken builds deploy as green | Propagate `returncode != 0` |
| Rebuilding per environment | Env-specific dependency drift | Promote the exact CI artifact |
| Hardcoding cloud keys in CI | Credential leak in logs/forks | Use OIDC roles or repo secrets |

### Notes
- **Ignoring non-zero exit codes**: CI runners treat exit code `0` as success; always propagate failures.
- **Rebuilding per environment**: Build once in CI and promote the exact same artifact to staging/prod.
- **Hardcoding cloud keys in CI YAML**: Use OIDC roles or encrypted repository secrets.

## 🔗 Related Chapters
- **Previous:** [Chapter 5 — Package Management](../05_package_management/README.md)
- **Next:** [Chapter 7 — Monitoring and Logging](../07_monitoring_and_logging/README.md)

## 📝 Skipped Book Topics
- Skipped: Live AWS CodePipeline/CloudFront/Algolia/GCP App Engine deployments requiring paid cloud credentials.

## 🔄 Then vs. Now

| Topic | 📜 Then (book, ~2020) | 🆕 Now (2026) | Why it changed |
| --- | --- | --- | --- |
| CI platform | Jenkins + `rsync` (NFSOPS) / CodePipeline | GitHub Actions (`actions/setup-python`, OIDC) | Zero-server CI with built-in caching & matrix |
| Python CI images | `python:3.7` / `python:3.11` | `python:3.12-slim` / `3.13-slim` | Active security patches & fast wheel installs |

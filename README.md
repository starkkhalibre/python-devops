# 🚀 Python for DevOps — Comprehensive Self-Study Course

A hands-on, self-paced DevOps engineering curriculum based on *Python for DevOps: Learn Ruthlessly Effective Automation* ([PDF](docs/python-for-devops-learn-ruthlessly-effective-automation.pdf)), upgraded with modern Python 3.11+ practices, deep conceptual & syntax breakdowns, troubleshooting guides, real-world DevOps challenges, and a Personal DevOps Learning Track.

---

## 📚 Course Structure & What Was Upgraded

Every chapter under `chapters/` is organized into two complementary files:
- **`README.md` (Concept & Ops Guide)**: Learning objectives, prerequisites, estimated study time, Linux/CLI workflows, YAML/HCL/Dockerfile/`systemd` configurations, and conceptual exercise answers.
- **`chapter_NN_*.ipynb` (14-Section Interactive Lab)**:
  1. Chapter Overview, Learning Objectives & Prerequisites
  2. Conceptual Explanations (*what*, *why*, *how*, *when to use*) & Syntax Breakdowns
  3. Beginner, Intermediate & Real-World DevOps Examples (with expected outputs)
  4. Common Mistakes & Troubleshooting
  5. **3 Beginner + 2 Intermediate Exercises**, **1 Practical DevOps Challenge**, and **5 Inline Q&A Flashcards**
  6. **Separated Hints & Complete Solutions** + Chapter Summary & Quick Reference

Across all 16 notebooks, **all code cells execute cleanly** (`jupyter nbconvert --execute`) with stored outputs: standard-library cells run out of the box, and optional `external` cells include `pip install` notes, offline mock fallbacks, and cloud cost/cleanup warnings.

---

## 🧱 Learning Prerequisites
- **Operating System**: Linux, macOS, or Windows (WSL2 recommended for Linux/Docker/Bash chapters).
- **Python**: Python **3.11+** (notebooks verified via `uv` execution on Python 3.13/3.14).
- **Basic Skills**: Comfort navigating a terminal (`cd`, `ls`, `cat`) and editing text files. No prior Python mastery is required—Chapter 1 starts from the fundamentals.

---

## ⚙️ Environment Setup & Jupyter Notebook Guide

### Option 1: Docker Compose (Run Anywhere — Recommended)
Run JupyterLab with all core DevOps libraries pre-installed in an isolated `python:3.12-slim` container:
```bash
# Build and start JupyterLab on http://127.0.0.1:8888
docker compose up --build -d

# View logs (or stop when done)
docker compose logs -f
docker compose down
```
> **⚠️ Remote Host Security & Port Override:** On a remote server, set a token: `JUPYTER_TOKEN=your-secret docker compose up -d`. If port `8888` is busy, override it: `JUPYTER_PORT=8889 docker compose up -d`.

### Option 2: Using `uv` (Fast Local Virtualenv)
```bash
# 1. From the repo root, create and activate a virtual environment
uv venv --python 3.11
source .venv/bin/activate          # Windows PowerShell: .venv\Scripts\Activate.ps1

# 2. Install JupyterLab + ipykernel into the venv and register the kernel
uv pip install jupyterlab ipykernel
python -m ipykernel install --user --name python-devops --display-name "Python (DevOps)"

# 3. Launch JupyterLab
jupyter lab
```
*(Quick one-liner without installing Jupyter into `.venv`: `uv run --with jupyter jupyter lab`)*

### Option 2: Standard `python3 -m venv` + `pip`
```bash
# 1. Create and activate virtual environment
python3 -m venv .venv
source .venv/bin/activate          # Windows PowerShell: .venv\Scripts\Activate.ps1

# 2. Upgrade pip and install JupyterLab + ipykernel
pip install --upgrade pip jupyterlab ipykernel

# 3. Register the kernel so notebooks see your .venv
python -m ipykernel install --user --name python-devops --display-name "Python (DevOps)"

# 4. Launch JupyterLab
jupyter lab
```

### Option 3: VS Code (No Browser Needed)
1. Install the **Python** and **Jupyter** extensions in VS Code.
2. Open the project folder and open any `.ipynb` file under `chapters/`.
3. Click **Select Kernel** (top-right) -> **Python Environments** -> choose `.venv/bin/python`.

---

## 🧭 How to Run & Study the Notebooks

1. **Read the chapter `README.md` first** for conceptual background, CLI commands, and non-code workflows.
2. **Open the chapter `.ipynb`**, select the **Python (DevOps)** / `.venv` kernel, and run cells top-to-bottom (`Shift + Enter`) so variables and imports carry forward.
3. **Attempt the Exercises & DevOps Challenge yourself** before scrolling down to **Section 13 (Hints & Complete Solutions)**.
4. **Resetting a notebook**: Use **Kernel -> Restart Kernel and Clear Outputs of All Cells** (or **Restart & Run All**) if state gets out of order.

### 📦 Optional: Installing Dependencies for `external` Cells
All standard-library cells work immediately. If you want to run the `external`-tagged cells in later chapters:
```bash
# Core DevOps & testing libraries (Ch 02, 03, 04, 06, 07, 08, 11)
uv pip install pyyaml cryptography click fire molotov flask prometheus-client pytest testinfra nbval docker

# Optional Cloud, IaC, K8s & ML libraries (Ch 09, 10, 12, 13, 14, 15)
uv pip install boto3 pulumi pulumi-aws pulumi-gcp kubernetes scikit-learn pandas joblib torch
```

### 🔧 Troubleshooting Notebook Setup
- **`jupyter: command not found`**: Activate `.venv` first (`source .venv/bin/activate`) or use `uv run --with jupyter jupyter lab`.
- **`ModuleNotFoundError` after `pip install`**: Your notebook kernel is pointing to system Python instead of `.venv`. Re-run `python -m ipykernel install --user --name python-devops` and switch kernels in the top-right menu.
- **IPython magic cells (`!df`, `%who`) fail in plain `python3`**: Those cells require a Jupyter/IPython kernel (tagged `ipython-only`).

---

## 🗺️ Recommended Learning Sequence

1. **Phase 1 — Python & Filesystem Foundations (Ch 01–02)**: Core syntax, regex, generators, file formats, hashing/encryption, `pathlib`.
2. **Phase 2 — CLI, Linux & Reliability Engineering (Ch 03–08)**: `subprocess`, `argparse`/`click`, Linux utilities, packaging/`systemd`, CI/CD, structured logging/Prometheus, `pytest`/`testinfra`.
3. **Phase 3 — Cloud, IaC & Containers (Ch 09–12)**: Concurrency/`boto3`, Terraform/Pulumi, Docker/Compose, Kubernetes/Helm.
4. **Phase 4 — Serverless, ML, Data & Production Mindset (Ch 13–16)**: Lambda/CDK, MLOps, Data pipelines, War Stories & postmortems.

---

## 📋 Chapter-by-Chapter Roadmap & Progress Tracker

| Done | # | Chapter | Est. Time | Guide (`README.md`) | Interactive Lab (`*.ipynb`) |
|------|---|---------|-----------|---------------------|-----------------------------|
| [ ] | 01 | Python Essentials for DevOps | 2–3 hrs | [Notes](chapters/01_python_essentials/README.md) | [Notebook](chapters/01_python_essentials/chapter_01_python_essentials.ipynb) |
| [ ] | 02 | Automating Files and the Filesystem | 2–3 hrs | [Notes](chapters/02_automating_files/README.md) | [Notebook](chapters/02_automating_files/chapter_02_automating_files.ipynb) |
| [ ] | 03 | Working with the Command Line | 2–3 hrs | [Notes](chapters/03_command_line/README.md) | [Notebook](chapters/03_command_line/chapter_03_command_line.ipynb) |
| [ ] | 04 | Useful Linux Utilities | 2 hrs | [Notes](chapters/04_linux_utilities/README.md) | [Notebook](chapters/04_linux_utilities/chapter_04_linux_utilities.ipynb) |
| [ ] | 05 | Package Management | 2 hrs | [Notes](chapters/05_package_management/README.md) | [Notebook](chapters/05_package_management/chapter_05_package_management.ipynb) |
| [ ] | 06 | Continuous Integration and Continuous Deployment | 2 hrs | [Notes](chapters/06_ci_cd/README.md) | [Notebook](chapters/06_ci_cd/chapter_06_ci_cd.ipynb) |
| [ ] | 07 | Monitoring and Logging | 2–3 hrs | [Notes](chapters/07_monitoring_and_logging/README.md) | [Notebook](chapters/07_monitoring_and_logging/chapter_07_monitoring_and_logging.ipynb) |
| [ ] | 08 | Pytest for DevOps | 2–3 hrs | [Notes](chapters/08_pytest_for_devops/README.md) | [Notebook](chapters/08_pytest_for_devops/chapter_08_pytest_for_devops.ipynb) |
| [ ] | 09 | Cloud Computing | 2–3 hrs | [Notes](chapters/09_cloud_computing/README.md) | [Notebook](chapters/09_cloud_computing/chapter_09_cloud_computing.ipynb) |
| [ ] | 10 | Infrastructure as Code | 2–3 hrs | [Notes](chapters/10_infrastructure_as_code/README.md) | [Notebook](chapters/10_infrastructure_as_code/chapter_10_infrastructure_as_code.ipynb) |
| [ ] | 11 | Container Technologies: Docker and Docker Compose | 2–3 hrs | [Notes](chapters/11_containers_docker/README.md) | [Notebook](chapters/11_containers_docker/chapter_11_containers_docker.ipynb) |
| [ ] | 12 | Container Orchestration: Kubernetes | 3 hrs | [Notes](chapters/12_kubernetes/README.md) | [Notebook](chapters/12_kubernetes/chapter_12_kubernetes.ipynb) |
| [ ] | 13 | Serverless Technologies | 2–3 hrs | [Notes](chapters/13_serverless/README.md) | [Notebook](chapters/13_serverless/chapter_13_serverless.ipynb) |
| [ ] | 14 | MLOps and Machine Learning Engineering | 2–3 hrs | [Notes](chapters/14_mlops/README.md) | [Notebook](chapters/14_mlops/chapter_14_mlops.ipynb) |
| [ ] | 15 | Data Engineering | 2–3 hrs | [Notes](chapters/15_data_engineering/README.md) | [Notebook](chapters/15_data_engineering/chapter_15_data_engineering.ipynb) |
| [ ] | 16 | DevOps War Stories and Interviews | 1.5–2 hrs | [Notes](chapters/16_war_stories_and_interviews/README.md) | [Notebook](chapters/16_war_stories_and_interviews/chapter_16_war_stories_and_interviews.ipynb) |

---

## 🏆 Final Capstone Project: Production DevOps Health & Deployment Toolkit
After completing Chapters 1–16, combine your skills into a single portfolio project:
1. **CLI Tool (Ch 01, 03, 05)**: Build a packaged Python CLI (`argparse` or `click`) that reads a YAML/JSON inventory of services (`Ch 02`).
2. **Health & Log Inspector (Ch 04, 07)**: Poll HTTP `/health` endpoints with timeouts, parse error logs with regex, emit structured JSON logs, and expose a `/metrics` endpoint.
3. **Automated Tests (Ch 08)**: Write `pytest` unit tests (with `monkeypatch` & `parametrize`) and `testinfra` host checks.
4. **Container & CI/CD (Ch 06, 11, 12)**: Package the service in a multi-stage `Dockerfile`, define a `docker-compose.yaml` + Kubernetes manifest, and add a CI workflow running lint + `pytest`.

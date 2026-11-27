# Changelog — Python for DevOps Self-Study Course

All notable improvements and 2026 modernizations applied to the 16-chapter curriculum based on *Python for DevOps: Learn Ruthlessly Effective Automation* (`docs/python-for-devops-learn-ruthlessly-effective-automation.pdf`).

## Cross-Cutting Changes (Chapters 01–16)
- **Educational Structure**: Standardized every chapter into sequential runnable notebooks with metadata headers, `Key idea` / `Tip` / `Warning` / `Try it` callouts, `Then (book, ~2020) vs. Now` notes, `What/Why/How/When` concept cards with named book listings and walkthroughs, mistake bullets, friendly `TODO` starter exercise cells, collapsible `<details>` hints/solutions/flashcard answers, and quick-reference lists.
- **Python 3.11+ Idioms**: Replaced legacy `typing.List`/`Dict`, `%`-formatting, `datetime.utcnow()`, and `os.popen()` with built-in generics (`list[str]`), f-strings, `datetime.now(timezone.utc)`, `pathlib.Path`, and `subprocess.run(..., text=True, check=True)`.
- **Real Tool Coverage**: Added `shutil.which()`-guarded real CLI demonstrations across all 16 chapters and executed all notebooks via `jupyter nbconvert --execute --inplace` to store real outputs.
- **Notebook Display (Round 5)**: Removed all Markdown tables from `.ipynb` files in favor of clean single-line metadata, 3-line `Then vs. Now` callouts, bulleted concept cards, and bulleted mistakes/quick-reference lists, while keeping structured tables in `chapters/*/README.md`.

## Per-Chapter Modernization Summary
- **Ch 01 (`01_python_essentials`)**: Added Python 3.11+ type hints, walrus operator `:=` in regex parsing, and Apache log named-group walkthrough.
- **Ch 02 (`02_automating_files`)**: Standardized on `pathlib.Path`, `encoding='utf-8'`, `yaml.safe_load()`, and added `sha256sum` real-tool check.
- **Ch 03 (`03_command_line`)**: Replaced `universal_newlines=True` / `os.popen()` with `subprocess.run(..., text=True, check=True)` and added `git --version` real-tool check.
- **Ch 04 (`04_linux_utilities`)**: Updated password/timestamp helpers to `secrets.token_urlsafe()` + `datetime.now(timezone.utc)`; added `locust`/`hey` alongside `molotov`/`ab`; added `lsblk` real-tool check.
- **Ch 05 (`05_package_management`)**: Modernized `setup.py sdist`/`bdist_rpm` and `virtualenv` to `pyproject.toml` (PEP 621), `tomllib`, `python -m build`, `uv`, and `pipx`; added `systemctl --version` check.
- **Ch 06 (`06_ci_cd`)**: Added GitHub Actions matrix/OIDC workflow alongside the book's WordPress-to-Hugo CodePipeline, Cloud Build, and NFSOPS Jenkins case studies.
- **Ch 07 (`07_monitoring_and_logging`)**: Kept Flask + `prometheus_client`, added structured `JsonFormatter`, OpenTelemetry context, and `curl --version` check.
- **Ch 08 (`08_pytest_for_devops`)**: Replaced `tmpdir`/`nose` references with `tmp_path` (`pathlib.Path`), `pytest.raises()`, `monkeypatch`, and live `pytest.main()` execution on temp test modules.
- **Ch 09 (`09_cloud_computing`)**: Added `boto3` `get_paginator()`, `botocore.config.Config` adaptive retries, IAM roles, `moto` offline mocks, and `aws --version` check.
- **Ch 10 (`10_infrastructure_as_code`)**: Updated Terraform 0.11 HCL (`"${var.x}"`) to HCL2 (`var.x`) + `aws_s3_bucket_public_access_block` + OpenTofu/Pulumi v3+ context, with real `tofu`/`terraform validate`.
- **Ch 11 (`11_containers_docker`)**: Updated `docker-compose` (v1, `version: '3'`) and `python:3.7.3-alpine` to `docker compose` (v2, no `version:`), `python:3.12-slim` multi-stage builds, non-root `USER`, `HEALTHCHECK`, `.dockerignore`, and real `docker --version` / `docker compose version`.
- **Ch 12 (`12_kubernetes`)**: Updated Helm v2 (`--name`, deprecated `stable/*`) to Helm 3 (`prometheus-community`), added `kind` alongside `minikube`, noted `kompose` caveats, and added real `kubectl apply --dry-run=client` + `helm version`.
- **Ch 13 (`13_serverless`)**: Updated Lambda Python 3.7, CDK v1, Cloud Functions, and Azure v1 to Lambda Python 3.12/3.13, AWS CDK v2 (`aws-cdk-lib`) / SAM, Cloud Run functions, and Azure Functions v2 Python model.
- **Ch 14 (`14_mlops`)**: Added MLflow experiment tracking/model registry context and `pickle`/`joblib` untrusted-deserialization security warning.
- **Ch 15 (`15_data_engineering`)**: Standardized on `boto3` (removing legacy `boto`), added Parquet/Arrow (`pyarrow`) + Airflow/Dagster/Prefect context, and real `shuf` sampling demo.
- **Ch 16 (`16_war_stories_and_interviews`)**: Rebuilt around 4 structured incident postmortems (Timeline, Root Cause, Fix, Prevention), added `py-spy`/`scalene`/OpenTelemetry alongside `cProfile`/`strace`, and real `strace` syscall profiling.

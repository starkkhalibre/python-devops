# 📦 Chapter 5: Package Management

📓 **Interactive Lab:** [chapter_05_package_management.ipynb](chapter_05_package_management.ipynb)  
📚 **Book Reference:** Chapter 5, *Package Management* (pp. 189–235)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
Ad-hoc scripts break when copied across servers without pinned dependencies or clean entry points. Packaging turns your automation into versioned, installable distributions (`pyproject.toml` + wheels), while `systemd` supervises long-running Python services with automatic restarts and `journalctl` logging.

> **🎯 Key idea:** Declarative `pyproject.toml` packaging and `systemd` service units turn ad-hoc scripts into reproducible, self-healing production tools.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_05_package_management.ipynb](chapter_05_package_management.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 200–231 | Chapters 3–4 | Intermediate |

## 🎯 Learning Objectives
- Version packages using Semantic Versioning (`MAJOR.MINOR.PATCH`) and maintain clear changelogs.
- Author modern `pyproject.toml` (PEP 621) manifests, build wheels with `python -m build`, and install CLI tools cleanly with `pipx` / `uv tool`.
- Understand how the book's legacy `setup.py` / `.deb` / `.rpm` workflows map to modern Python packaging.
- Write, validate, and manage `systemd` unit files (`systemctl`, `journalctl`).

## 🧱 Prerequisites
- [Chapter 3 — Command Line](../03_command_line/README.md) & [Chapter 4 — Linux Utilities](../04_linux_utilities/README.md).

## ⚙️ Modern vs. Legacy Packaging & `systemd` Reference

### Then (Book, ~2020) vs. Now
- **Then**: `python3 setup.py sdist`, `python3 setup.py bdist_rpm --spec-only`, `virtualenv`.
- **Now**: `pyproject.toml` (PEP 621) + `python -m build` + `uv venv` / `python -m venv`, and `pipx` (or `uv tool install`) for isolated CLI tools. Direct `setup.py` CLI invocations are deprecated.

### Commented `systemd` Unit File (`/etc/systemd/system/devops-api.service`)
```ini
[Unit]
Description=DevOps Health API Service
After=network.target               # Start only after networking is up

[Service]
Type=simple                        # Foreground process (no daemonize fork)
User=appuser                       # Least-privilege non-root user
WorkingDirectory=/opt/devops-api   # Base dir for relative file lookups
ExecStart=/opt/devops-api/.venv/bin/python -m devops_api
Restart=on-failure                 # Auto-restart on non-zero exit
RestartSec=5                       # Wait 5s between restarts
StandardOutput=journal             # Route stdout -> journalctl
StandardError=journal              # Route stderr -> journalctl

[Install]
WantedBy=multi-user.target         # Enable on standard multi-user boot
```

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Relative `ExecStart` in `systemd` | `Executable path is not absolute` | Use full `.venv/bin/python` path |
| Forgetting `systemctl daemon-reload` | Unit edits ignored | Run `sudo systemctl daemon-reload` |
| Running `setup.py install` directly | Bypasses `pip` resolver | Use `pip install .` or `python -m build` |

### Notes
- **Relative `ExecStart` in `systemd`**: `systemd` does not search `$PATH`; always specify the full path to the `.venv` Python binary.
- **Forgetting `sudo systemctl daemon-reload`**: Changes to `.service` files are ignored until `daemon-reload` runs.
- **Running `setup.py install` directly**: Deprecated and bypasses `pip`'s dependency resolver; use `pip install .` or `python -m build`.

## 🔗 Related Chapters
- **Previous:** [Chapter 4 — Linux Utilities](../04_linux_utilities/README.md)
- **Next:** [Chapter 6 — CI/CD](../06_ci_cd/README.md)

## 📝 Skipped Book Topics
- Skipped: Hosting live `devpi`/`reprepro`/`createrepo` HTTP package servers and `sudo systemctl start` on host.

## 🔄 Then vs. Now

| Topic | 📜 Then (book, ~2020) | 🆕 Now (2026) | Why it changed |
| --- | --- | --- | --- |
| Python packaging | `setup.py sdist`, `setup.py bdist_rpm` | `pyproject.toml` (PEP 621) + `python -m build` | `setup.py` CLI commands are deprecated |
| Venvs & CLI installs | `virtualenv` + global `pip` | `uv venv` / `python -m venv`, `pipx` / `uv tool` | Faster, isolated CLI environments |

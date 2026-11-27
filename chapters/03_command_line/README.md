# ⌨️ Chapter 3: Working with the Command Line

📓 **Interactive Lab:** [chapter_03_command_line.ipynb](chapter_03_command_line.ipynb)  
📚 **Book Reference:** Chapter 3, *Working with the Command Line* (pp. 112–149)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
Automation tools need clean CLI interfaces (`--help`, subcommands, exit codes) and safe ways to invoke external binaries (`git`, `docker`, `kubectl`) without opening command-injection vulnerabilities.

> **🎯 Key idea:** `subprocess.run()` with `shell=False` and `argparse`/`click` lets Python wrap system binaries safely without command-injection risks.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_03_command_line.ipynb](chapter_03_command_line.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 122–139 | Chapters 1–2 | Intermediate |

## 🎯 Learning Objectives
- Spawn external processes safely with `subprocess.run()` (`shell=False`, `timeout=`, `check=True`).
- Build zero-dependency CLIs with `argparse` and understand `click` / `fire`.
- Load extensible plugins dynamically via `pkgutil.iter_modules()` and `importlib`.

## 🧱 Prerequisites
- [Chapter 1](../01_python_essentials/README.md) & [Chapter 2](../02_automating_files/README.md).

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| `shell=True` with user input | Command injection (`; rm -rf /`) | Pass a list of strings with `shell=False` |
| Passing `'ls -l'` as one string | `FileNotFoundError` when `shell=False` | Split into `['ls', '-l']` |
| Missing `timeout=` | Hung child process freezes CI | Always set `timeout=10` and `check=True` |

### Notes
- **Passing `shell=True` with user input**: Enables shell command injection; always pass a list of strings (`['ls', '-l']`).
- **Ignoring return codes**: Always pass `check=True` or inspect `cp.returncode`.
- **Missing `timeout=`**: A hung child process can stall a CI pipeline indefinitely.

## 🔗 Related Chapters
- **Previous:** [Chapter 2 — Automating Files](../02_automating_files/README.md)
- **Next:** [Chapter 4 — Useful Linux Utilities](../04_linux_utilities/README.md)

## 📝 Skipped Book Topics
- Skipped: NVIDIA CUDA GPU hardware execution (`numba.cuda`) which requires an NVIDIA GPU.

## 🔄 Then vs. Now

| Topic | 📜 Then (book, ~2020) | 🆕 Now (2026) | Why it changed |
| --- | --- | --- | --- |
| Shell calls | `os.popen()`, `universal_newlines=True` | `subprocess.run(..., text=True, check=True)` | Safer, captures `stdout`/`stderr` & exit codes |
| CLI frameworks | `sys.argv` / `optparse` | `argparse` (stdlib) / `click` / `fire` | Built-in `--help`, validation, subcommands |

# 📁 Chapter 2: Automating Files and the Filesystem

📓 **Interactive Lab:** [chapter_02_automating_files.ipynb](chapter_02_automating_files.ipynb)  
📚 **Book Reference:** Chapter 2, *Automating Files and the Filesystem* (pp. 82–111)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
DevOps engineers spend half their day reading configs (JSON, YAML, XML, CSV), rotating/scanning multi-gigabyte logs, verifying checksums, and walking directory trees. Using `pathlib.Path`, `with open(..., encoding="utf-8")`, and streaming generators eliminates resource leaks and cross-OS path bugs.

> **🎯 Key idea:** Using `with open(..., encoding='utf-8')`, `pathlib.Path`, and streaming generators eliminates file-descriptor leaks and cross-OS path bugs.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_02_automating_files.ipynb](chapter_02_automating_files.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 85–107 | Chapter 1 | Beginner |

## 🎯 Learning Objectives
- Read/write text and binary files safely using `with open()` and `pathlib.Path`.
- Parse JSON, CSV, XML, and YAML (`yaml.safe_load()`).
- Stream huge text and binary files with constant memory.
- Compute SHA-256 digests (`hashlib`) and understand symmetric (`Fernet`) vs. asymmetric (`RSA`) encryption.
- Walk directory trees with `os.walk()` and `Path.rglob()`.

## 🧱 Prerequisites
- [Chapter 1 — Python Essentials](../01_python_essentials/README.md) (generators, regex, exceptions).

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| `yaml.load()` without `SafeLoader` | Arbitrary code execution risk | Always use `yaml.safe_load()` |
| Omitting `encoding='utf-8'` | `UnicodeDecodeError` on Windows/containers | Pass `encoding='utf-8'` explicitly |
| Calling `.read()` on multi-GB logs | Container OOM crash | Iterate `for line in f:` or read 4096-byte chunks |

### Notes
- **Using `yaml.load()` without `SafeLoader`**: Allows arbitrary code execution from untrusted YAML; always use `yaml.safe_load()`.
- **Omitting `encoding='utf-8'`**: Causes `UnicodeDecodeError` on Windows or mixed-locale containers.
- **Loading large files with `.read()`**: Exhausts RAM; iterate line-by-line or read binary chunks (`f.read(4096)`).

## 🔗 Related Chapters
- **Previous:** [Chapter 1 — Python Essentials](../01_python_essentials/README.md)
- **Next:** [Chapter 3 — Working with the Command Line](../03_command_line/README.md)

## 📝 Skipped Book Topics
- Skipped: Live RSA private-key file generation on disk (covered conceptually in README).

## 🔄 Then vs. Now

| Topic | 📜 Then (book, ~2020) | 🆕 Now (2026) | Why it changed |
| --- | --- | --- | --- |
| Path manipulation | `os.path.join(a, b)` | `pathlib.Path(a) / b` | Object-oriented, cross-OS `/` operator |
| YAML loading | `yaml.load(f)` | `yaml.safe_load(f)` | Prevents arbitrary code execution |

# 🧪 Chapter 8: Pytest for DevOps

📓 **Interactive Lab:** [chapter_08_pytest_for_devops.ipynb](chapter_08_pytest_for_devops.ipynb)  
📚 **Book Reference:** Chapter 8, *Pytest for DevOps* (pp. 307–343)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
Untested automation breaks production silently. `pytest` lets you write concise `assert`-based unit tests, parametrize edge cases, isolate side effects (`tmp_path`, `monkeypatch`), and validate live infrastructure (`testinfra`).

> **🎯 Key idea:** `pytest` replaces `unittest` boilerplate with bare `assert`s, `tmp_path`, `parametrize`, and `testinfra` live host validation.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_08_pytest_for_devops.ipynb](chapter_08_pytest_for_devops.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 314–337 | Chapters 3, 7 | Intermediate |

## 🎯 Learning Objectives
- Structure tests using `pytest` discovery (`tests/test_*.py`, `test_*`, `Test*`).
- Execute real `pytest` suites using `tmp_path`, `@pytest.mark.parametrize`, `pytest.raises`, and `monkeypatch`.
- Share fixtures via `conftest.py` and validate hosts with `testinfra` and notebooks with `pytest --nbval`.

## 🧱 Prerequisites
- [Chapter 3 — Command Line](../03_command_line/README.md) & [Chapter 7 — Monitoring & Logging](../07_monitoring_and_logging/README.md).

## ⚙️ Then (Book, ~2020) vs. Now
- **Then**: Built-in `tmpdir` (legacy `py.path.local`), `nose` comparisons.
- **Now**: Use **`tmp_path`** (`pathlib.Path`), `pytest.raises()`, `monkeypatch`, and `pytest.main()`. `nose` is dead and removed from modern projects.

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Patching wrong module path | Mock never intercepts call | Patch where symbol is looked up |
| Mutating `os.environ` directly | Leaks state to later tests | Use `monkeypatch.setenv()` |
| Missing `test_` prefix | `pytest` skips the test silently | Name files `test_*.py` & funcs `test_*` |

### Notes
- **Patching the wrong module path**: Always patch where the function is *imported/looked up*.
- **Mutating `os.environ` without `monkeypatch`**: Pollutes subsequent tests.
- **Forgetting `test_` prefix**: `pytest` silently skips functions not starting with `test_`.

## 🔗 Related Chapters
- **Previous:** [Chapter 7 — Monitoring and Logging](../07_monitoring_and_logging/README.md)
- **Next:** [Chapter 9 — Cloud Computing](../09_cloud_computing/README.md)

## 📝 Skipped Book Topics
- Skipped: Live Vagrant SSH VM provisioning (`vagrant ssh-config`).

## 🔄 Then vs. Now

| Topic | 📜 Then (book, ~2020) | 🆕 Now (2026) | Why it changed |
| --- | --- | --- | --- |
| Temp dir fixture | `tmpdir` (`py.path.local`) | `tmp_path` (`pathlib.Path`) | Modern stdlib `Path` API |
| Legacy runners | `nose` comparisons in book | `pytest` exclusively (`testinfra` & `nbval` maintained) | `nose` is unmaintained/dead |

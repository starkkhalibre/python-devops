# 🐧 Chapter 4: Useful Linux Utilities

📓 **Interactive Lab:** [chapter_04_linux_utilities.ipynb](chapter_04_linux_utilities.ipynb)  
📚 **Book Reference:** Chapter 4, *Useful Linux Utilities* (pp. 150–188)  
⏱️ **Estimated Study Time:** 2 hours

## 📖 Why This Chapter Matters
When debugging slow servers, saturated disks, or blocked network ports, Linux utilities (`lsblk`, `iostat`, `fio`, `htop`, `ssh -L`, `strace`) give instant visibility—while short Python helpers cleanly handle JSON/CSV transforms, cryptographic tokens, TCP port checks, and HTTP load testing.

> **🎯 Key idea:** Combine Linux diagnostics (`lsblk`, `parted`, `htop`, `strace`) with short Python helpers for JSON/CSV, TCP port checks, and load testing.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_04_linux_utilities.ipynb](chapter_04_linux_utilities.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 172–184 | Chapter 3 | Intermediate |

## 🎯 Learning Objectives
- Measure throughput (`dd`) vs. IOPS (`iostat`, `fio`) and inspect disks (`lsblk`, `blkid`, `parted`).
- Forward private ports over SSH tunnels and load-test HTTP endpoints (`ab`, `hey`/`locust`, `molotov`).
- Profile and debug Python scripts with `timeit`, `pdb`/`breakpoint()`, and `strace`.

## 🧱 Prerequisites
- [Chapter 3 — Working with the Command Line](../03_command_line/README.md).

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Using `fdisk` on >= 2 TB disks | Truncates or fails partition | Use `parted` with GPT |
| Leaving `breakpoint()` in prod | Hangs headless cron/CI jobs | Remove breakpoints before commit |
| Single `time.time()` benchmark | Noisy OS scheduling skew | Use `min(timeit.repeat(...))` |

### Notes
- **Using `fdisk` on >= 2 TB disks**: Fails silently or truncates; use `parted` with GPT.
- **Leaving `breakpoint()` in production**: Freezes headless cron/CI scripts waiting on stdin.
- **Single-run `time.time()` benchmarks**: Skewed by OS scheduling noise; use `timeit.repeat()` and take `min()`.

## 🔗 Related Chapters
- **Previous:** [Chapter 3 — Working with the Command Line](../03_command_line/README.md)
- **Next:** [Chapter 5 — Package Management](../05_package_management/README.md)

## 📝 Skipped Book Topics
- Skipped: Destructive disk formatting (`fdisk`/`parted` on `/dev/sdX`) and `dd` raw device writes for host safety.

## 🔄 Then vs. Now

| Topic | 📜 Then (book, ~2020) | 🆕 Now (2026) | Why it changed |
| --- | --- | --- | --- |
| Load testing | `molotov` (minimally maintained) | `locust` / `hey` / `k6` (keep `ab` for quick checks) | Active ecosystems & richer reporting |
| Passwords & timestamps | `os.urandom` + `base64`, `time.time()` | `secrets.token_urlsafe()`, `datetime.now(timezone.utc)` | URL-safe tokens & timezone-aware UTC |

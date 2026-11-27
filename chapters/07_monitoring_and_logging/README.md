# 📊 Chapter 7: Monitoring and Logging

📓 **Interactive Lab:** [chapter_07_monitoring_and_logging.ipynb](chapter_07_monitoring_and_logging.ipynb)  
📚 **Book Reference:** Chapter 7, *Monitoring and Logging* (pp. 263–306)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
`print()` statements vanish or flood local disks in production. Reliable systems centralize structured logs, rotate local files safely, emit non-blocking metrics (StatsD/Prometheus), and trace distributed requests (OpenTelemetry).

> **🎯 Key idea:** Structured JSON `logging`, `RotatingFileHandler`, Prometheus `/metrics/`, and OpenTelemetry give you visibility before users report outages.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_07_monitoring_and_logging.ipynb](chapter_07_monitoring_and_logging.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 278–296 | Chapters 1–2, 6 | Intermediate |

## 🎯 Learning Objectives
- Configure Python `logging` with `dictConfig`, `RotatingFileHandler`, custom `logging.Filter`s, and JSON formatters.
- Compare Push (StatsD UDP -> Graphite) vs. Pull (Prometheus `/metrics/`) monitoring.
- Understand OpenTelemetry distributed tracing basics alongside the ELK stack (Filebeat, Logstash `grok`, Elasticsearch, Kibana).

## 🧱 Prerequisites
- [Chapter 1](../01_python_essentials/README.md) & [Chapter 6 — CI/CD](../06_ci_cd/README.md).

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Duplicate log lines | `addHandler()` + `propagate=True` | Clear handlers or set `propagate = False` |
| Eager f-strings in `debug()` | Formats strings even when suppressed | Use lazy `logger.debug('x=%s', x)` |
| Unbounded `FileHandler` | Fills root disk | Use `RotatingFileHandler` or `stdout` |

### Notes
- **Duplicate log lines**: Adding handlers repeatedly without clearing or setting `logger.propagate = False`.
- **Eager f-strings in `logger.debug(f'...')`**: Evaluates expensive formatting even when `DEBUG` is off; use lazy `%s` args (`logger.debug('Val: %s', x)`).
- **Unbounded `FileHandler`**: Fills root disks; use `RotatingFileHandler` or log to `stdout` for container/systemd capture.

## 🔗 Related Chapters
- **Previous:** [Chapter 6 — CI/CD](../06_ci_cd/README.md)
- **Next:** [Chapter 8 — Pytest for DevOps](../08_pytest_for_devops/README.md)

## 📝 Skipped Book Topics
- Skipped: Multi-node StatsD/Graphite/ELK Docker cluster setup (covered in architecture notes).

## 🔄 Then vs. Now

| Topic | 📜 Then (book, ~2020) | 🆕 Now (2026) | Why it changed |
| --- | --- | --- | --- |
| Tracing & correlation | Manual log correlation / Graphite | OpenTelemetry (OTel) + Prometheus + Grafana | Vendor-neutral logs/metrics/traces |
| Log formatting | `%` formatting & plain text | Structured JSON + lazy `%s` logger args | Machine-queryable in ELK/Loki |

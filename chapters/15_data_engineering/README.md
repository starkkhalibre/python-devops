# 🗄️ Chapter 15: Data Engineering

📓 **Interactive Lab:** [chapter_15_data_engineering.ipynb](chapter_15_data_engineering.ipynb)  
📚 **Book Reference:** Chapter 15, *Data Engineering* (pp. 620–660)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
Data engineering delivers the automated batch and streaming pipelines that feed analytics and ML. You need to know when single-node Python/Pandas breaks ("Laptop Test"), how to stream files lazily with generators, and how modern formats (**Parquet/Arrow**) and orchestrators (**Airflow, Dagster, Prefect**) fit in.

> **🎯 Key idea:** Pass the Laptop Test: chain `yield` generators for `O(1)` memory ETL, isolate bad rows to dead-letter queues, and use `boto3` + Parquet/Arrow.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_15_data_engineering.ipynb](chapter_15_data_engineering.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 624–657 | Chapters 1, 13 | Advanced |

## 🎯 Learning Objectives
- Apply the "Laptop Test" (Pandas 5–10x RAM rule) and sample large files with `shuf`.
- Build `O(1)` memory generator ETL pipelines with dead-letter error isolation.
- Understand `boto3` serverless ETL (DynamoDB -> SQS -> Comprehend -> S3 `io.StringIO`), **Parquet/Arrow**, and modern orchestrators (**Airflow/Dagster/Prefect**).

## 🧱 Prerequisites
- [Chapter 1](../01_python_essentials/README.md) & [Chapter 13 — Serverless](../13_serverless/README.md).

## ⚙️ Then (Book, ~2020) vs. Now
- **Then**: CSV on S3/HDFS, cron/Jenkins scheduled scripts (`boto`/`boto3`).
- **Now**: **`boto3` only** (legacy `boto` is dead), columnar **Apache Parquet / Arrow (`pyarrow`)** instead of raw CSV for data lakes, and **Airflow / Dagster / Prefect** for observable pipeline orchestration.

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Calling `.readlines()` on GB files | Exhausts RAM immediately | Iterate `for line in f:` |
| `asyncio.run()` inside Jupyter | `RuntimeError: loop already running` | Use `await` or worker thread |
| Crashing batch on 1 bad row | Zero rows processed | Route bad rows to dead-letter |

### Notes
- **Using `.readlines()` on multi-GB files**: Loads everything into RAM; iterate line-by-line.
- **Crashing an entire batch on 1 malformed row**: Route bad rows to a dead-letter queue.

## 🔗 Related Chapters
- **Previous:** [Chapter 14 — MLOps](../14_mlops/README.md)
- **Next:** [Chapter 16 — War Stories & Interviews](../16_war_stories_and_interviews/README.md)

## 📝 Skipped Book Topics
- Skipped: Live AWS Kinesis Firehose, DynamoDB->SQS->Comprehend->S3 Lambdas, and Kafka cluster.

## 🔄 Then vs. Now

| Topic | 📜 Then (book, ~2020) | 🆕 Now (2026) | Why it changed |
| --- | --- | --- | --- |
| AWS SDK & formats | `boto`/`boto3` + CSV | `boto3` only + **Parquet/Arrow** (`pyarrow`) | Legacy `boto` is dead; Parquet is columnar |
| Orchestration | Cron / Jenkins scripts | **Airflow / Dagster / Prefect** | Retries, lineage & backfills built in |

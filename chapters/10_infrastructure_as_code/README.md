# 🏗️ Chapter 10: Infrastructure as Code

📓 **Interactive Lab:** [chapter_10_infrastructure_as_code.ipynb](chapter_10_infrastructure_as_code.ipynb)  
📚 **Book Reference:** Chapter 10, *Infrastructure as Code* (pp. 392–429)  
⏱️ **Estimated Study Time:** 2–3 hours

## 📖 Why This Chapter Matters
Clicking through cloud consoles creates undocumented configuration drift. Declarative IaC (**Terraform / OpenTofu** in HCL, or **Pulumi** in Python) versions infrastructure in Git, previews diffs before applying, and tears down cleanly.

> **🎯 Key idea:** Declarative IaC (Terraform/OpenTofu HCL or Pulumi Python) computes state diffs before applying, eliminating manual console drift.


## 🧭 How to Use This Chapter
1. Read this `README.md` for concepts, CLI workflows, and pitfalls.
2. Open [chapter_10_infrastructure_as_code.ipynb](chapter_10_infrastructure_as_code.ipynb) and run cells top-to-bottom.
3. Implement the starter exercises before expanding `<details>` hints and solutions.

| Book Reference | Prerequisites | Difficulty |
| --- | --- | --- |
| pp. 401–426 | Chapters 2, 9 | Intermediate |

## 🎯 Learning Objectives
- Compare declarative IaC (Terraform, OpenTofu, Pulumi, CloudFormation) vs. imperative scripts (Boto3).
- Read/author Terraform/OpenTofu HCL alongside Pulumi Python SDK stacks.
- Detect infrastructure state drift and enforce pre-apply compliance policies in Python.

## 🧱 Prerequisites
- [Chapter 9 — Cloud Computing](../09_cloud_computing/README.md).

## ⚙️ Commented IaC Artifacts (Terraform/OpenTofu HCL & Pulumi)

### Terraform / OpenTofu HCL (`main.tf`) — *Book Scenario: Static Website Bucket*
```hcl
terraform {
  required_version = ">= 1.6"                # Modern Terraform / OpenTofu version constraint
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = var.aws_region                    # Parameterized region
}

resource "aws_s3_bucket" "site" {
  bucket = var.domain_name                   # Globally unique S3 bucket name
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket                  = aws_s3_bucket.site.id
  block_public_acls       = true             # Security best practice: block public ACLs
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
```
> **Then (book, ~2020) vs. Now:** The book uses Terraform 0.11 interpolation (`"${var.aws_region}"`) and inline `s3_bucket` `acl = "public-read"`. Modern Terraform/OpenTofu uses bare `var.aws_region` and separate `aws_s3_bucket_public_access_block` resources.

## ⚠️ Common Pitfalls

| Mistake | Symptom | Fix |
| --- | --- | --- |
| Manual console edits | State drift on next `apply` | Make all changes in IaC code |
| Destroying non-empty S3 | `BucketNotEmpty` error | Empty bucket or set `force_destroy` |
| ACM cert outside `us-east-1` | CloudFront rejects certificate | Provision CloudFront ACM in `us-east-1` |

### Notes
- **Manual console edits**: Causes state drift between live cloud and IaC state.
- **Destroying non-empty S3 buckets**: Empty the bucket or set `force_destroy = true` before `terraform destroy`.
- **Cost & cleanup**: Always run `terraform destroy` or `pulumi destroy` after lab experiments!

## 🔗 Related Chapters
- **Previous:** [Chapter 9 — Cloud Computing](../09_cloud_computing/README.md)
- **Next:** [Chapter 11 — Containers & Docker](../11_containers_docker/README.md)

## 📝 Skipped Book Topics
- Skipped: Provisioning live Route53/CloudFront/ACM stacks in AWS (covered via `terraform validate` + drift detector).

# Terraform Infrastructure Automation (AWS & GCP)

Automated cloud infrastructure provisioning using modular Terraform scripts across AWS and GCP platforms. Reduced deployment time by 60% compared to manual console setup.

![AWS](https://img.shields.io/badge/AWS-Cloud-orange) ![GCP](https://img.shields.io/badge/GCP-Cloud-blue) ![Terraform](https://img.shields.io/badge/Terraform-IaC-purple) ![Status](https://img.shields.io/badge/Status-Live-green)

---

## 🌐 Live Deployment Proof

### ✅ AWS EC2 — Apache Web Server (Mumbai Region)
![AWS Live](screenshots/aws-live.png)

### ✅ GCP VM — Nginx Web Server (Asia South)
![GCP Live](screenshots/gcp-live.png)

---

## 🏗️ Architecture Overview

    ┌─────────────────────────────────┐
                │           AWS (ap-south-1)       │
                │                                  │
                │  ┌─────────────────────────┐    │
                │  │        VPC               │    │
                │  │  ┌──────────────────┐   │    │
                │  │  │  Public Subnet   │   │    │
                │  │  │  ┌────────────┐  │   │    │
                │  │  │  │  EC2 + SG  │  │   │    │
                │  │  │  └────────────┘  │   │    │
                │  │  └──────────────────┘   │    │
                │  │  Internet Gateway        │    │
                │  └─────────────────────────┘    │
                │  IAM Role + S3 Bucket            │
                │  DynamoDB (State Lock)           │
                └─────────────────────────────────┘

                ┌─────────────────────────────────┐
                │           GCP (asia-south1)      │
                │  Compute Engine VM               │
                │  Firewall Rule (HTTP/HTTPS)      │
                └─────────────────────────────────┘


---

## 📦 Resources Provisioned

### AWS (16 Resources)
| Resource | Name | Purpose |
|---|---|---|
| VPC | deepika-tf-vpc | Isolated network |
| Public Subnet | deepika-tf-public-subnet | EC2 lives here |
| Private Subnet | deepika-tf-private-subnet | Future DB use |
| Internet Gateway | deepika-tf-igw | Internet access |
| Route Table | deepika-tf-public-rt | Routes traffic |
| Security Group | deepika-tf-web-sg | Firewall for EC2 |
| EC2 Instance | deepika-tf-web-server | Ubuntu + Apache2 |
| IAM Role | deepika-tf-ec2-role | EC2 permissions |
| IAM Policy Attachment | S3ReadOnlyAccess | S3 access |
| IAM Instance Profile | deepika-tf-ec2-profile | Attaches role to EC2 |
| S3 Bucket | deepika-tf-app-bucket-dev | App storage |
| S3 Public Access Block | — | Blocks public access |
| S3 Versioning | — | File version history |
| S3 Encryption | AES256 | Data at rest security |
| S3 State Bucket | deepika-tf-state-2025 | Remote state storage |
| DynamoDB Table | terraform-lock-table | State locking |

### GCP (2 Resources)
| Resource | Name | Purpose |
|---|---|---|
| Compute Engine VM | deepika-tf-gcp-vm | Debian + Nginx |
| Firewall Rule | deepika-tf-allow-http | HTTP/HTTPS access |

---

## 🔧 Tech Stack

- **Terraform** v1.13+
- **AWS Provider** v5.x
- **GCP Provider** v5.x
- **Remote Backend** — S3 + DynamoDB state locking
- **OS** — Ubuntu 22.04 (EC2), Debian 11 (GCP VM)
- **Web Servers** — Apache2 (AWS), Nginx (GCP)

---

## 📁 Project Structure

terraform-aws-gcp-automation/
├── main.tf                  # Root module — providers + module calls
├── variables.tf             # Input variable declarations
├── outputs.tf               # Output values (IPs, bucket names)
├── backend.tf               # S3 remote state + DynamoDB lock
└── modules/
├── vpc/
│   ├── main.tf          # VPC, subnets, IGW, route tables
│   ├── variables.tf
│   └── outputs.tf
├── ec2/
│   ├── main.tf          # EC2 instance + security group
│   ├── variables.tf
│   └── outputs.tf
├── s3/
│   ├── main.tf          # S3 bucket + encryption + versioning
│   ├── variables.tf
│   └── outputs.tf
├── iam/
│   ├── main.tf          # IAM role + policy + instance profile
│   ├── variables.tf
│   └── outputs.tf
└── gcp_vm/
├── main.tf          # GCP VM + firewall rule
├── variables.tf
└── outputs.tf

---

## 🚀 How to Deploy

### Prerequisites
- Terraform >= 1.5.0
- AWS CLI configured (`aws configure`)
- GCP CLI configured (`gcloud auth application-default login`)
- GCP service account key (`gcp-key.json`)

### One Time Backend Setup
1. Create S3 bucket named `deepika-tf-state-2025` with versioning enabled
2. Create DynamoDB table named `terraform-lock-table` with partition key `LockID`

### Deploy Infrastructure
```bash
# Initialize — downloads providers, connects backend
terraform init

# Validate — checks for syntax errors
terraform validate

# Plan — preview what will be created
terraform plan

# Apply — actually create everything
terraform apply
```

### Destroy Infrastructure
```bash
terraform destroy
```

---

## 📊 Key Highlights

- **Modular design** — each resource is an independent reusable module
- **Remote state** — S3 backend with DynamoDB locking prevents conflicts
- **60% faster** — full infra in under 5 minutes vs manual console setup
- **Security first** — private S3, encrypted at rest, IAM least-privilege
- **Multi-cloud** — single codebase provisions both AWS and GCP
- **Version controlled** — full commit history, peer review ready

---

## 👩‍💻 Author

**Deepika G** — Cloud & DevOps Engineer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://www.linkedin.com/in/deepika-g4008/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black)](https://github.com/deepikag123)
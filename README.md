# Terraform Infrastructure Automation (AWS & GCP)

Automated cloud infrastructure provisioning using modular Terraform scripts across AWS and GCP platforms.

## 🏗️ Architecture

![AWS + GCP](https://img.shields.io/badge/AWS-Cloud-orange) ![GCP](https://img.shields.io/badge/GCP-Cloud-blue) ![Terraform](https://img.shields.io/badge/Terraform-IaC-purple)

## 📦 Resources Provisioned

### AWS
- **VPC** — Custom Virtual Private Cloud with public and private subnets
- **EC2** — Web server (Ubuntu) with Apache2 serving live webpage
- **S3** — Private bucket with versioning and AES256 encryption
- **IAM** — EC2 role with S3 read access and instance profile
- **Internet Gateway + Route Table** — Public internet access for EC2

### GCP
- **Compute Engine VM** — Debian VM with Nginx web server
- **Firewall Rule** — HTTP/HTTPS traffic allowed to VM

## 🔧 Tech Stack
- Terraform v1.13+
- AWS Provider v5.x
- GCP Provider v5.x
- S3 Remote Backend with DynamoDB state locking

## 📁 Project Structure
terraform-aws-gcp-automation/
├── main.tf              # Root module — providers + module calls
├── variables.tf         # Input variable declarations
├── outputs.tf           # Output values (IPs, bucket names)
├── backend.tf           # S3 remote state + DynamoDB lock
└── modules/
├── vpc/             # AWS VPC, subnets, IGW, route tables
├── ec2/             # AWS EC2 instance + security groups
├── s3/              # AWS S3 bucket with encryption
├── iam/             # AWS IAM role + instance profile
└── gcp_vm/          # GCP Compute VM + firewall rules

## 🚀 How to Use

### Prerequisites
- Terraform >= 1.5.0
- AWS CLI configured (`aws configure`)
- GCP CLI configured (`gcloud auth application-default login`)
- GCP service account key (gcp-key.json)

### Setup Backend (One Time)
1. Create S3 bucket for state storage
2. Create DynamoDB table named `terraform-lock-table` with `LockID` partition key

### Deploy
```bash
terraform init
terraform validate
terraform plan
terraform apply
```

### Destroy
```bash
terraform destroy
```

## 📊 Key Highlights
- **Modular design** — each resource type is an independent reusable module
- **Remote state** — S3 backend with DynamoDB locking prevents state conflicts
- **60% faster deployments** — full infrastructure provisioned in under 5 minutes vs manual console setup
- **Security** — S3 bucket fully private, encrypted at rest, IAM least-privilege access
- **Multi-cloud** — single codebase provisions resources on both AWS and GCP

## 👩‍💻 Author
**Deepika G** — Cloud & DevOps Engineer  
[LinkedIn](https://linkedin.com/in/yourprofile) | [GitHub](https://github.com/deepikag123)
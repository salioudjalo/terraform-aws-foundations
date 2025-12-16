# Day 01 — Terraform Core Modules (Security Group & EC2)

## 🎯 Objective

Build production-grade Terraform modules from scratch to understand
AWS infrastructure fundamentals and Terraform module design.

---

## 🧱 What Was Built

### 1️⃣ Security Group Module
A reusable security group module supporting:
- Inbound and outbound rules
- IPv4 and IPv6 traffic
- Dynamic rules using `for_each`
- Clean separation of rule types
- Fully variable-driven configuration

### 2️⃣ EC2 Module
A reusable EC2 module featuring:
- Amazon Linux 2023 AMI selected dynamically
- Configurable instance type and subnet
- Optional SSH key pair
- Optional public IP association
- Flexible tagging with enforced `Name` tag
- Clean outputs for integration

---

## 🧠 Skills Demonstrated

- Terraform module design
- AWS Security Group internals
- Dynamic resources with `for_each`
- `map(object)` variable patterns
- Data sources (`aws_ami`)
- Tag merging with `merge()`
- Clean input/output contracts
- Infrastructure reusability

---

## 🏗️ Architecture (High-Level)

```text
EC2 Instance
   │
   ├── Attached Security Groups
   │
   └── Subnet (provided externally)

# AWS ECS Fargate Infrastructure with Terraform (IaC)

This repository contains Terraform (Infrastructure as Code) configurations for building a web application runtime environment centered around AWS ECS Fargate.

- Modular Design: By organizing components into modules (modules/), the code structure is highly reusable and maintainable.

- Purpose: This is my standard environment setup code used for learning and experimentation. It provisions an architecture designed to host frontend and backend APIs.

- Cost Optimization: To minimize costs, NAT Gateways are intentionally omitted. Instead, the architecture relies on IP address restrictions for access control.

---

## Architecture

![Architecture Diagram](./asetts/architectureDiagram.svg)

### Key Components
- VPC / Subnets: High availability with a Multi-AZ architecture (2 Public Subnets).

- ALB (Application Load Balancer): Load balancing for incoming HTTP/HTTPS traffic from the internet.

- ECS (Fargate): Serverless container execution environment.

- ECR (Elastic Container Registry): Storage for container images.

- CloudWatch Logs: Centralized logging for containers and the ALB.

---

## Directory Structure

```text
.
├── main.tf
├── modules
│   ├── acm
│   ├── alb
│   ├── ecr
│   ├── ecs
│   ├── iam
│   ├── logs
│   ├── routes
│   ├── securityGroup
│   ├── subnet
│   └── vpc
└── variables.tf
```


## Usage

### 1. Clone the repository
```
git clone https://github.com/hogehoge/my-ecs.git
cd my-ecs

```

### 2. Prepare configuration files

Copy `terraform.tfvars.example` to create `terraform.tfvars`, and modify the settings as needed.

Copy terraform.tfvars.example to create terraform.tfvars, and modify the values according to your environment requirements.

```
cp terraform.tfvars.example terraform.tfvars
```

### 3. Initialize and review the execution plan
```
terraform init

terraform validate

terraform plan

```

### 4. Deploy resources
```
terraform apply
```

### 5. Push a container image to ECR

Build your frontend and backend Docker images, and push them to the newly provisioned ECR repositories.

### 6. Update the ECS task count

The default desired task count is set to 0. Once your images are pushed to ECR, you need to update the task count to start your containers.



## Note

- DNS record configurations are not included in this Terraform code. Please configure your DNS settings manually.
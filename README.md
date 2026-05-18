# Patient Data Server on AWS with Terraform

A simple, robust project demonstrating how to build a Go web server and deploy it to an AWS EC2 instance (Ubuntu 22.04) using Terraform for Infrastructure as Code (IaC).

## 🚀 Overview

This project consists of:
1.  **Go Server:** A lightweight HTTP server that listens on port 8080 and serves a "Hello, World!" message.
2.  **Infrastructure:** Modular Terraform configurations to provision an AWS EC2 instance (tagged as `PatientDataServer`) and set up security groups.

## 📁 Project Structure

```text
.
├── main.go            # Go web server source code
├── go.mod             # Go module definition
├── server             # Compiled Go binary (ignored by git)
├── main.tf            # Main EC2 instance and Security Group resources
├── variables.tf       # Input variable definitions
├── outputs.tf         # Terraform output definitions
├── providers.tf       # Terraform provider configuration
├── data.tf            # Data sources (e.g., AMI lookups)
└── README.md          # Project documentation
```

## 🏗 Setup & Deployment

### 1. Prerequisites
*   [Go](https://golang.org/doc/install) installed.
*   [Terraform](https://developer.hashicorp.com/terraform/downloads) installed.
*   AWS CLI configured with appropriate credentials.
*   An AWS Key Pair (.pem file) available in your AWS region.

### 2. Configure Variables
Review `variables.tf` to customize your deployment. Key variables include:
- `region`: AWS region (default: `us-east-2`).
- `instance_type`: EC2 instance size (default: `t3.micro`).
- `key_name`: The name of your SSH key pair.
- `cidr_blocks`: Allowed IP ranges for ingress (default: `["0.0.0.0/0"]`).

### 3. Build the Server
Compile the Go application for Linux:

```bash
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server main.go
```

### 4. Provision Infrastructure
Initialize and apply the Terraform configuration:

```bash
terraform init
terraform apply
```
*Note: You will be prompted to confirm the plan. Ensure your `key_name` matches an existing key in your AWS account.*

### 5. Transfer & Run the Server
Use `scp` to copy the binary and `ssh` to run it:

```bash
# Transfer
scp -i /path/to/your-key.pem server ubuntu@<instance_public_ip>:~/

# SSH and Run
ssh -i /path/to/your-key.pem ubuntu@<instance_public_ip>
chmod +x ./server
./server
```

The server will be accessible at `http://<instance_public_ip>:8080`.

## 🔒 Security Notes
*   The security group `patient_data_instance_sg` allows inbound traffic on port 22 (SSH) and 8080 (App) from the CIDR blocks defined in `variables.tf`.
*   For production, restrict `cidr_blocks` to your specific IP address.

## 📜 License
This project is open-source and available under the MIT License.

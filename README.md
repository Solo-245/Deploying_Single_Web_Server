# Go Web Server on AWS with Terraform

A simple, robust project demonstrating how to build a Go web server and deploy it to an AWS EC2 instance using Terraform for Infrastructure as Code (IaC).

## 🚀 Overview

This project consists of two main parts:
1.  **Go Server:** A lightweight HTTP server that listens on port 8080.
2.  **Infrastructure:** Terraform configurations to provision an AWS EC2 instance and set up the necessary networking/security rules.

## 🛠 Features

*   **Go 1.x Server:** Simple "Hello World" endpoint for health checks and verification.
*   **Terraform IaC:** Defines provider, instance types, and security groups.
*   **Automated Security:** Configures security groups to allow traffic on port 8080 (App) and 22 (SSH/SCP).
*   **Deployment Workflow:** Clear instructions for compiling and transferring the binary.

## 📁 Project Structure

```text
.
├── main.go            # Go web server source code
├── server             # Compiled Go binary (ignored by git usually)
├── main.tf            # Terraform infrastructure configuration
└── README.md          # Project documentation
```

## 🏗 Setup & Deployment

### 1. Prerequisites
*   [Go](https://golang.org/doc/install) installed.
*   [Terraform](https://developer.hashicorp.com/terraform/downloads) installed.
*   AWS CLI configured with appropriate credentials.
*   An AWS Key Pair (.pem file) downloaded to your machine.

### 2. Build the Server
Since the server will run on a Linux EC2 instance, you need to compile it for the target architecture (if you are on Windows or Mac):

```bash
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server main.go
```

### 3. Provision Infrastructure
Initialize and apply the Terraform configuration:

```bash
terraform init
terraform apply
```
*Note: Ensure your `main.tf` includes your `key_name` and an output for the `public_ip`.*

### 4. Transfer the Binary
Use `scp` to copy the compiled binary to your EC2 instance:

```bash
scp -i /path/to/your-key.pem server ec2-user@<INSTANCE_PUBLIC_IP>:~/
```

### 5. Run the Server
SSH into your instance and start the server:

```bash
ssh -i /path/to/your-key.pem ec2-user@<INSTANCE_PUBLIC_IP>
chmod +x ./server
./server
```

The server will now be accessible at `http://<INSTANCE_PUBLIC_IP>:8080`.

## 🔒 Security Notes
*   **Port 22:** Currently open to `0.0.0.0/0` in `main.tf`. For production, restrict this to your specific IP address.
*   **Port 8080:** Open to allow web traffic to the Go application.

## 📜 License
This project is open-source and available under the MIT License.

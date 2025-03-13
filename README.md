# 🚀 PyLambda-EC2 Scheduler

## Overview

This project automates the **starting** of EC2 instances at regular intervals using **AWS Lambda** and **EventBridge**. It leverages **Terraform** for infrastructure provisioning and IAM role assignments, ensuring a fully automated deployment. The Lambda function is written in **Python**, utilising **Boto3** to interact with AWS services.

## 🔧 Features

- **Automated EC2 Start**: Lambda function starts EC2 instances every 60 minutes.
- **Event-Driven Execution**: Triggered by AWS EventBridge.
- **Logging & Monitoring**: Logs are stored in AWS CloudWatch for easy debugging.
- **Infrastructure as Code**: Managed using Terraform for easy deployment and reproducibility.
- **Full Automation**: Terraform automates provisioning, IAM role setup, and Lambda deployment.
- **Python-Based Execution**: Lambda function is implemented in Python and leverages the **Boto3 SDK** for AWS API calls.

## 🏗 Architecture

![Pylambda-project-architecture](/images/Pylambda-project-architecture.png)

## 🛠 Prerequisites

Ensure you have the following installed:

- **Terraform** (>=1.0.0)
- **AWS CLI** (configured with credentials)
- **Python 3.13**
- **Boto3 (AWS SDK for Python)** (Ensure it's included in the Lambda deployment package if needed)

## 📂 Project Structure

```
📁 project-root/
├── 📁 terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
├── 📁 python/
│   ├── start-EC2-instance.py
├── README.md
```

## 🚀 Deployment

### 1️⃣ Clone the Repository

```sh
git clone https://github.com/your-username/PyLambda-EC2-Scheduler.git
cd PyLambda-EC2-Scheduler
```

### 2️⃣ Initialise Terraform

```sh
terraform init
```

### 3️⃣ Apply Terraform Configuration

```sh
terraform apply -auto-approve
```

This will:

- Create the **IAM Role & Policy** for the Lambda function.
- Deploy the **AWS Lambda Function** with the required permissions.
- Set up an **EventBridge Rule** to trigger the Lambda function every 60 minutes.
- Automatically package and deploy the **Python Lambda function code**.

### 4️⃣ Verify the Deployment

- Go to **AWS Console → Lambda** and check if the function is created.
- Navigate to **CloudWatch Logs** to see execution logs.
- Check if your EC2 instances are starting as expected.

## 🛑 Destroying the Infrastructure

To remove all resources:

```sh
terraform destroy -auto-approve
```

## 📌 Configuration

Modify the `main.tf` file to:

- Adjust the **schedule** timing (`rate(60 minutes)`).
- Change the **EC2 actions** (e.g., stop instances instead of starting them).
- Modify the **Python Lambda function code** if additional logic is needed.

## 📝 Notes

- Ensure the IAM role attached to Lambda has the necessary **EC2 permissions**.
- CloudWatch **logs** can be checked for debugging in case of errors.
- The Lambda function's timeout is **10 seconds**, adjust it if needed.
- Terraform automates **everything**, so there's no need for manual AWS Console configuration.
- The Python script uses **Boto3** to start EC2 instances dynamically.
- If the Lambda function needs dependencies, they must be packaged manually before deployment.

## 📜 Licence

This project is licensed under the **MIT Licence**.

## 🤝 Contributing

Feel free to open an **issue** or submit a **pull request** if you have improvements!

---


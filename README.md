Hospital Management System Application Deployment in Azure Cloud, Docker & Kubernetes
Project Overview

The Hospital Management System (HMS) is a full-stack web application designed to manage hospital operations such as patient registration, doctor management, appointment scheduling, and medical records management.

This project demonstrates deployment of a Python Flask-based application on Microsoft Azure using Docker containers, Kubernetes orchestration, Gunicorn application server, and MySQL database.

The project also includes Infrastructure as Code (IaC) concepts, reverse proxy configuration using Nginx, containerization, CI/CD readiness, and scalable cloud deployment architecture.

Technologies Used
Category	Technologies
Frontend	HTML, CSS, JavaScript
Backend	Python Flask
Application Server	Gunicorn
Database	MySQL
Reverse Proxy	Nginx
Containerization	Docker
Container Orchestration	Kubernetes (K8s)
Cloud Platform	Microsoft Azure
IaC	Terraform
Version Control	Git & GitHub
CI/CD	GitHub Actions / Azure DevOps
Project Features
Patient Management
Doctor Management
Appointment Scheduling
REST API Integration
CRUD Operations
Responsive Frontend
Backend API using Flask
MySQL Database Connectivity
Dockerized Application
Kubernetes Deployment
Azure Cloud Hosting
Reverse Proxy using Nginx
Scalable Architecture
Architecture Diagram
                    +-------------------+
                    |     End Users     |
                    +---------+---------+
                              |
                              v
                    +-------------------+
                    |      Nginx        |
                    |   Reverse Proxy   |
                    +---------+---------+
                              |
              +---------------+---------------+
              |                               |
              v                               v
      +---------------+              +----------------+
      | Frontend Pod  |              | Backend Pod    |
      | HTML/CSS/JS   |              | Flask+Gunicorn |
      +-------+-------+              +--------+-------+
                                              |
                                              v
                                   +-------------------+
                                   |   MySQL Database  |
                                   +-------------------+


                Hosted on Azure Cloud using Docker & Kubernetes
Project Workflow
User accesses the Hospital Management System through a browser.
Nginx acts as a reverse proxy and routes requests.
Frontend communicates with backend REST APIs.
Flask backend processes requests.
Gunicorn serves Flask application efficiently.
Backend interacts with MySQL database.
Docker containers package the application.
Kubernetes manages deployment, scaling, and networking.
Azure Cloud hosts the infrastructure.
Azure Services Used
Azure Service	Purpose
Azure Virtual Machine	Hosting application and Kubernetes nodes
Azure Virtual Network	Network communication
Azure Kubernetes Service (AKS)	Kubernetes orchestration
Azure Container Registry (ACR)	Docker image storage
Azure Load Balancer	Traffic distribution
Azure Storage	Persistent storage
Azure Monitor	Monitoring and logging
Folder Structure
hospital-management-system/
│
├── frontend/
│   ├── index.html
│   ├── style.css
│   └── app.js
│
├── backend/
│   ├── app.py
│   ├── requirements.txt
│   ├── routes/
│   └── config.py
│
├── nginx/
│   └── nginx.conf
│
├── docker/
│   ├── Dockerfile.frontend
│   └── Dockerfile.backend
│
├── kubernetes/
│   ├── frontend-deployment.yaml
│   ├── backend-deployment.yaml
│   ├── mysql-deployment.yaml
│   ├── services.yaml
│   └── ingress.yaml
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
└── README.md
Backend Setup (Flask + Gunicorn)
Install Dependencies
sudo apt update
sudo apt install python3-pip -y


pip install -r requirements.txt
Run Flask Application
python3 app.py
Run with Gunicorn
gunicorn --bind 0.0.0.0:5000 app:app
MySQL Database Setup
Install MySQL
sudo apt update
sudo apt install mysql-server -y
Login to MySQL
sudo mysql
Create Database
CREATE DATABASE hospital_db;
Docker Setup
Docker Installation
sudo apt update
sudo apt install docker.io -y
Build Docker Images
Backend Image
docker build -t hms-backend -f Dockerfile.backend .
Frontend Image
docker build -t hms-frontend -f Dockerfile.frontend .
Run Containers
docker run -d -p 5000:5000 hms-backend


docker run -d -p 80:80 hms-frontend
Kubernetes Deployment
Apply Kubernetes Manifests
kubectl apply -f kubernetes/
Verify Resources
kubectl get pods
kubectl get svc
kubectl get deployments
Azure AKS Setup
Login to Azure
az login
Create Resource Group
az group create --name hms-rg --location centralindia
Create AKS Cluster
az aks create \
  --resource-group hms-rg \
  --name hms-aks \
  --node-count 2 \
  --enable-addons monitoring \
  --generate-ssh-keys
Connect to AKS Cluster
az aks get-credentials \
  --resource-group hms-rg \
  --name hms-aks
Terraform Deployment
Initialize Terraform
terraform init
Validate Configuration
terraform validate
Plan Infrastructure
terraform plan
Apply Infrastructure
terraform apply -auto-approve
Nginx Reverse Proxy Configuration
server {
    listen 80;


    location / {
        root /usr/share/nginx/html;
        index index.html;
    }


    location /api {
        proxy_pass http://backend:5000;
    }
}
CI/CD Workflow

The project can be integrated with GitHub Actions or Azure DevOps for automated:

Build Process
Docker Image Creation
Container Registry Push
Kubernetes Deployment
Infrastructure Provisioning
Security Best Practices
Use Kubernetes Secrets for credentials
Enable HTTPS using TLS certificates
Restrict inbound ports using NSG rules
Store sensitive data in Azure Key Vault
Use Docker image scanning
Configure RBAC in Kubernetes
Monitoring & Logging
Azure Monitor
Kubernetes Metrics Server
Container Logs
Pod Monitoring
Application Health Checks
Gunicorn Logs
Sample REST APIs
Method	Endpoint	Description
GET	/api/patients	Get all patients
POST	/api/patients	Add patient
GET	/api/doctors	Get all doctors
POST	/api/doctors	Add doctor
GET	/api/appointments	Get appointments
POST	/api/appointments	Create appointment
Deployment Commands Summary
Docker
docker build -t hms-backend .
docker run -d -p 5000:5000 hms-backend
Kubernetes
kubectl apply -f kubernetes/
kubectl get pods
Azure AKS
az aks create --resource-group hms-rg --name hms-aks --node-count 2
Future Enhancements
Role-Based Authentication
JWT Security
Patient Reports
Email Notifications
SMS Alerts
Helm Charts
Horizontal Pod Autoscaling
Monitoring Dashboard
AI-based Appointment Prediction
Learning Outcomes

This project demonstrates practical implementation of:

Cloud Deployment
DevOps Practices
Infrastructure as Code
Containerization
Kubernetes Orchestration
Backend API Development
Database Management
Reverse Proxy Configuration
CI/CD Automation

Author
Saibaba Kola
DevOps Engineer | Cloud Engineer | Azure | Docker | Kubernetes | Terraform | Python Flask

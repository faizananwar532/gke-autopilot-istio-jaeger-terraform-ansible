# GKE Autopilot Cluster with Istio and Jaeger Installation

GKE Autopilot Cluster with Istio and Jaeger Installation using Terraform and Ansible
This repository automates the creation of a GKE Autopilot cluster using Terraform and Ansible, and then installs Istio and Jaeger on the cluster using Ansible.

## Overview

This project is split into two main phases:
1. **Infrastructure Setup**: Creates a GKE Autopilot cluster using Terraform, initiated through Ansible.
2. **Service Deployment**: Installs Istio and Jaeger on the created cluster using Ansible.

## Prerequisites

- **Google Cloud SDK**: Ensure you have access to a GCP project and have authenticated via `gcloud`.
- **Terraform**: Installed and configured.
- **Ansible**: Installed and configured.
- **kubectl**: Installed for managing the Kubernetes cluster.
- **Istioctl**: Installed for Istio installation and management.

## Repository Structure

```bash
gke-autopilot-istio-jaeger-terraform-ansible/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── secret_variable.tfvars
├── ansible/
│   ├── ansible.vars.yml
│   ├── jaeger.values.yml
│   ├── playbooks/
│   │   ├── create_cluster.yml
│   │   ├── delete_cluster.yml
│   │   ├── install_istio.yml
│   │   └── install_jaeger.yml
│   └── inventory/
│       └── hosts.ini
├── README.md
└── .gitignore
└── .LICENSE
```

## Configuration
Before running the playbooks, you need to configure the necessary files with your own values.
#### `ansible/ansible.vars.yml`
Edit the ansible.vars.yml file located in the ansible/ directory to include your GCP and cluster details:
```bash
project_id: <GCP project id>
credential: <json filename path here>
region_name: <GCP region>
cluster_name: <GKE Cluster name>
autopilot: "true"
```
- project_id: Your GCP project ID.
- credential: Path to the JSON file containing the GCP service account credentials.
- region_name: The GCP region where the GKE cluster will be deployed.
- cluster_name: The name of the GKE cluster.
- autopilot: Set to "true" to enable Autopilot mode for the GKE cluster.

#### `terraform/variables.tf`
Update terraform/variables.tf and terraform/secret_variables.tf with your Terraform variables. Key variables include:
- project_id: GCP project ID.
- region_name: GCP region for the cluster.
- cluster_name: Name of the GKE cluster.
- credential: Path to the JSON file for GCP service account credentials.
- enable_autopilot: Boolean flag to enable Autopilot mode (default is true).
- backend_bucket_name: Name of the GCS bucket for Terraform state storage.
- backend_prefix: Prefix for the Terraform state file in the GCS bucket.
- environment: Environment label (e.g., dev, staging, prod).
- team_name: Team responsible for the cluster (default is "Cloud and DevOps").

## Running the Project
### Setup
1. Configure Files Edit `ansible/ansible.vars.yml` and `terraform/variables.tf` to include your specific values for GCP project details, credentials, and Terraform state management.
2. Install Dependencies Ensure you have the following dependencies installed:
> - Terraform
> - Ansible
> - gcloud CLI
> - kubectl
> - Istioctl

#### Running Playbooks

1. Provision the GKE Cluster Use Ansible to create the GKE cluster with Terraform:
```bash
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbooks/create_cluster.yml
```
2. Install Istio Deploy Istio on the GKE cluster:
```bash
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbooks/install_istio.yml
```
3. Install Jaeger Deploy Jaeger on the GKE cluster:
```bash
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbooks/install_jaeger.yml
```
4. Delete the GKE Cluster and Services To remove the GKE cluster and associated services, run:
```bash
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbooks/delete_cluster.yml
```

#### Additional Configuration
After Terraform has created the GKE cluster, you need to authenticate kubectl with the cluster. Use the following command to set up kubectl:
```bash
terraform output -json kubeconfig | jq -r '"gcloud container clusters get-credentials \(.cluster_name) --region \(.location) --project \(.project_id)"' | bash
```
This command will configure your local kubectl context to interact with the new GKE cluster.

### Notes

- Ensure you have the hosts.ini file set up for local execution of playbooks.
- The playbooks assume that the gcloud CLI is installed and configured on the local machine.
- Make sure the GCS bucket for Terraform state management exists and is accessible.

By following these instructions, you can configure, deploy, and manage your GKE cluster along with Istio and Jaeger.
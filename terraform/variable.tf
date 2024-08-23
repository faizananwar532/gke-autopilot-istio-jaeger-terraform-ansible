variable "project_id" {
  description = "The GCP unique project ID where the cluster will be deployed."
  type        = string
  sensitive   = true
}

variable "region_name" {
  description = "The GCP region where the cluster will be deployed."
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  description = "Name of GKE Cluster"
  sensitive   = true
}

variable "credential" {
  description = "JSON file used to authenticate to GCP"
  sensitive = true
}

variable "enable_autopilot" {
  description = "Enable Autopilot mode for GKE cluster"
  type        = bool
  default     = true
}

variable "backend_bucket_name" {
  description = "The name of the GCS bucket to store Terraform state."
  sensitive   = true  
  type        = string
}

variable "backend_prefix" {
    description = "The prefix for the Terraform state in the GCS bucket."
    type        = string
}

variable "environment" {
    description = "Environment label for resources (e.g., dev, staging, prod)."
    type        = string
}

variable "team_name" {
    description = "The team responsible for the cluster."
    default = "Cloud and DevOps"
    type        = string
}

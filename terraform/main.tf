terraform {
    required_providers {
        google = {
            source  = "hashicorp/google"
            version = "~> 4.3"
        }
    }

    backend "gcs" {
        bucket      = var.backend_bucket_name
        prefix      = var.backend_prefix
        credentials = var.credential
    }
}

provider "google" {
    credentials = file(var.credential)
    project     = var.project_id 
    region      = var.region_name
}

resource "google_container_cluster" "primary" {
    name               = var.cluster_name
    location           = var.region_name
    enable_autopilot   = var.enable_autopilot
    initial_node_count = 1

    resource_labels = {
        environment = var.environment
        team        = var.team_name
    }

    networking_mode = "VPC_NATIVE"

    logging_service    = "logging.googleapis.com/kubernetes"
    monitoring_service = "monitoring.googleapis.com/kubernetes"

    lifecycle {
        ignore_changes = [
            node_config,
            ip_allocation_policy,
        ]
    }
}
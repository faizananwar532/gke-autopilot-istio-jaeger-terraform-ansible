output "cluster_name" {
  description = "The name of the cluster"
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "The IP address of the cluster master"
  value       = google_container_cluster.primary.endpoint
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "The public certificate that is the root of trust for the cluster"
  value       = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  sensitive   = true
}

output "cluster_location" {
  description = "The location of the cluster"
  value       = google_container_cluster.primary.location
}

output "kubeconfig" {
  description = "Kubeconfig command to authenticate kubectl"
  value = {
    cluster_name = google_container_cluster.primary.name
    location     = google_container_cluster.primary.location
    project_id   = var.project_id
  }
}

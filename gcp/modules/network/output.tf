output "primary_vpc_name" {
  value       = google_compute_network.primary.name
  description = "Primary VPC Name"
}

output "primary_vpc_link" {
  value       = google_compute_network.primary.self_link
  description = "Primary VPC Link"
}

output "primary_subnet_name" {
  value       = google_compute_subnetwork.primary.name
  description = "Primary Subnet Name"
}

output "primary_ip_name" {
  value       = google_compute_global_address.primary.name
  description = "Primary IP Name"
}

output "primary_ip_address" {
  value       = google_compute_global_address.primary.address
  description = "Primary IP Address"
}

output "primary_svc_net" {
  value       = google_service_networking_connection.primary
  description = "Primary Service Networking Connection"
}

# Common
variable "region" {
  type        = string
  default     = "us-south1"
  description = "https://cloud.google.com/compute/docs/regions-zones"
}

variable "primary_cluster_location" {
  type        = string
  default     = "us-south1-a"
  description = "https://cloud.google.com/compute/docs/regions-zones"
}

variable "node_pool_location" {
  type        = string
  default     = "us-south1-a"
  description = "https://cloud.google.com/compute/docs/regions-zones"
}

variable "project_id" {
  type        = string
  description = "Id for the Google Cloud project."
}

# google_compute_subnetwork
variable "subnetwork_name" {
  type        = string
  default     = "gke-subnetwork"
  description = "Subnet name for your GKE cluster."
}

variable "subnetwork_cidr_range" {
  type        = string
  default     = "10.2.0.0/20"
  description = "https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr"
}

variable "stack_type" {
  type        = string
  default     = "IPV4_IPV6"
  description = "Can be either IPV4_IPV6 for dual stack subnet (for IPV6), or IPV4_ONLY (for IPV4)."
}

variable "ipv6_access_type" {
  type        = string
  default     = "EXTERNAL"
  description = "Can be either INTERNAL or EXTERNAL."
}

variable "enable_dataplane_v2" {
  type        = bool
  default     = true
  description = "Boolean to enable GKE Dataplane V2 https://cloud.google.com/kubernetes-engine/docs/how-to/dataplane-v2"
}

variable "services_ip_cidr_range" {
  type        = string
  default     = "172.15.0.0/20"
  description = "https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr"
}

variable "pods_ip_cidr_range" {
  type        = string
  default     = "172.16.0.0/14"
  description = "https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr"
}

# google_commpute_network
variable "compute_network_name" {
  type        = string
  default     = "gke-network"
  description = "Network name for your GKE cluster."
}

# google_container_cluster
variable "container_cluster_name" {
  type        = string
  default     = "gke-primary-cluster"
  description = "GKE primary cluster name (without nodes)."
}

# google_container_node_pool
variable "container_node_pool_name" {
  type        = string
  default     = "gke-node-pool"
  description = "GKE node pool name (where workloads will run)."
}

variable "container_node_pool_autoscale_min_node_count" {
  type        = number
  default     = 1
  description = "Minimum number of nodes for the GKE node pool to scale to."
}

# TODO: Evaluate future default of max nodes for Bifrost specific GKE cluster.
variable "container_node_pool_autoscale_max_node_count" {
  type        = number
  default     = 1
  description = "Maximum number of nodes for the GKE node pool to scale to."
}

# https://cloud.google.com/kubernetes-engine/docs/how-to/preemptible-vms
variable "container_node_pool_preemptible" {
  type        = bool
  default     = false
  description = "Change node pool to use preemtible nodes for a cost saving measure (use if you do not need consistent running workloads)."
}

variable "container_node_pool_machine_type" {
  type        = string
  default     = "e2-medium"
  description = "https://cloud.google.com/compute/docs/machine-types"
}
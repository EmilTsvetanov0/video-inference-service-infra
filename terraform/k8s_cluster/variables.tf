# --------------------- main ---------------------
variable "service_account_key_file" {
  description = "Absolute path to key.json file"
  type        = string
}

variable "cloud_id" {
  description = "The cloud ID"
  type        = string
}

variable "folder_id" {
  description = "The folder ID"
  type        = string
}

variable "default_zone" {
  description = "The default zone"
  type        = string
  default     = "ru-central1-a"
}

# -------------------- Cluster -----------------------
variable "subnets" {
  description = "Subnets for worker and master nodes"
  type = map(list(object({
    name = string,
    zone = string,
    cidr = list(string)
  })))
}

variable "subnets_default" {
  description = "Default subnets"
  type = map(object({
    name = string,
    zone = string,
    cidr = list(string)
  }))
}

variable "node_groups" {
  description = "Fields for node groups"
  default = {}
}

variable "master_version" {
  description = "Master version"
  type        = string
}

variable "white_ips_for_master" {
  type = list(string)
}

variable "master_public_ip" {
  description = "Boolean flag. When true, Kubernetes master will have a visible ipv4 address."
  type        = bool
  default     = true
}

variable "master_region" {
  description = "Name of region where cluster will be created. Required for regional cluster, not used for zonal cluster."
  type        = string
  default     = null
}

#=========== network ==============
variable "network_name" {
  description = "The name of main network"
  type        = string
}

# ------------ Kafka ---------------
variable "kafka_zones" {
  description = "List of zones in which kafka brokers will be deployed"
  type        = list(string)
}


# ECS

variable "cluster_name" {
  description = "ECS name"
  type        = string
}

# PacketAI

variable "INFRA_ID" {
  description = "INFRA_ID for PacketAI"
  type        = string
}

variable "INGEST_URL" {
  description = "INGEST_URL for PacketAI"
  type        = string
}

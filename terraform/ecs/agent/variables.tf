# ECS

variable "cluster_name" {
  description = "ECS name"
  type        = string
}

# PacketAI

variable "X_PAI_TOKEN" {
  description = "X_PAI_TOKEN for PacketAI"
  type        = string
}

variable "PAI_API_KEY" {
  description = "PAI_API_KEY for PacketAI"
  type        = string
}

variable "APIDEVURL" {
  description = "APIDEVURL for PacketAI"
  type        = string
}

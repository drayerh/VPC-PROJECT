#region name variable
variable "region-name" {
  description = "making region name a variable"
  default     = "eu-west-2"
  type        = string

}

#cidr block variable
variable "cidr_block" {
  description = "making cidr a variable"
  default     = "10.0.0.0/16"
  type        = string

}
# Public subnet1 variable
variable "cidr-for-pubsub1" {
  description = "pub subnet1 cidr"
  default     = "10.0.10.0/24"
  type        = string

}

# Public subnet2 variable
variable "cidr-for-pubsub2" {
  description = "pub subnet2 cidr"
  default     = "10.0.20.0/24"
  type        = string

}

# Private subnet1 variable
variable "cidr-for-privsub1" {
  description = "priv subnet1 cidr"
  default     = "10.0.30.0/24"
  type        = string

}

# Private subnet2 variable
variable "cidr-for-privsub2" {
  description = "priv subnet2 cidr"
  default     = "10.0.40.0/24"
  type        = string

}

# Availability Zone Variable 1
variable "AZ-1" {
  description = "availability zone"
  default     = "eu-west-2a"
}

# Availability Zone Variable 2
variable "AZ-2" {
  description = "availability zone"
  default     = "eu-west-2b"
}

# Availability Zone Variable 3
variable "AZ-3" {
  description = "availability zone"
  default     = "eu-west-2c"
}


variable "region" {
  description = "Région AWS"
  type        = string
  default     = "eu-west-3"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"

}

variable "vm_image" {
  type        = string
  description = "AMI for VMs"

}

variable "vm_instance_type" {
  type = string

}


variable "instance_name" {
  type    = string
  default = "claireid_instance"

}

variable "aws_key_name" {
  type    = string
  default = "KEY"

}

variable "key_name" {
  description = "Nom de la clé SSH"
  type        = string
  default     = "dadavid-key"
}


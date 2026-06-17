output "vm_ip_public" {
  value = aws_instance.dadavid_serverweb.public_ip
}

output "subnet_id" {
  description = "ID du subnet créé"
  value       = aws_subnet.dadavid_server.id
}

output "security_group_id" {
  description = "ID du security group créé"
  value       = aws_security_group.bars_sg.id
}

output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.dadavid_serverweb.id
}

output "instance_public_ip" {
  description = "IP publique de l'instance EC2"
  value       = aws_instance.dadavid_serverweb.public_ip
}
output "private_key_path" {
  description = "Chemin du fichier .pem de la clé privée"
  value       = local_sensitive_file.private_key.filename
}

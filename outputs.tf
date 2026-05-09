output "aws_ec2_public_ip" {
  description = "Public IP of EC2 web server"
  value       = module.ec2.public_ip
}

output "aws_s3_bucket_name" {
  description = "S3 bucket name"
  value       = module.s3.bucket_name
}

output "gcp_vm_ip" {
  description = "Public IP of GCP VM"
  value       = module.gcp_vm.gcp_vm_ip
}

output "s3_bucket_id" {
    description = "The website endpoint of s3 bucket"
    value = aws_s3_bucket_website_configuration.static.website_endpoint  
}
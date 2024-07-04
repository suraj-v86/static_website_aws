provider "aws" {
    region = "us-east-1"
      
}
module "Static_website_s3" {
    source = "https://github.com/suraj-v86/static_website_aws.git"
    bucket_name = surajproject2024
    html_source_path = "html"
    aws_account_id = "905418244935"  
}
output "s3_bucket_website_endpoint" {
  value = module.Static_website_s3.website_endpoint
  
}

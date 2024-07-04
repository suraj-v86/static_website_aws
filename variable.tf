variable "bucket_name" {
    description = "Value for the s3 bucket"  
}
variable "index_document" {
    description = "Index document for the s3 bucket website"  
}
variable "html_source_path" {
    description = "Local path to html file" 
    type = string 
}
variable "aws_account_id" {
    description = "value for AWS account id"  
    type = string
}

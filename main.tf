resource "aws_s3_bucket" "suraj_bucket" {
    bucket = var.bucket_name
    force_destroy = true

}
resource "aws_s3_bucket_website_configuration" "static" {
    bucket = aws_s3_bucket.suraj_bucket.id
    index_document {
      suffix = var.index_document
    }
     
}


resource "aws_s3_bucket_public_access_block" "Public_access" {
    bucket = aws_s3_bucket.suraj_bucket.id
    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false  
}
output "debug_fileset" {
  value = fileset("html/", "*")
  
}
resource "aws_s3_object" "Html_file" {
    for_each = fileset("html/","*")
    bucket = aws_s3_bucket.suraj_bucket.id
    key = each.value
    source = "${var.html_source_path}/${each.value}"
    etag = filemd5("${var.html_source_path}/${each.value}")
    content_type = "text/html" 
  
}
data "aws_iam_policy_document" "iam_policy" {
    statement {
      principals {
        type = "AWS"
        identifiers = ["arn:aws:iam::$(var.aws_account_id):root"]
      }

      actions = ["s3:GetObject"]
      resources = ["arn:aws:s3:::var.bucket_name/*"]
    }
  
}

resource "aws_s3_bucket_policy" "Policy" {
    bucket = aws_s3_bucket.suraj_bucket.id
    policy = jsonencode({
        "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:*",
        "Resource": [
          "arn:aws:s3:::surajproject2024",
          "arn:aws:s3:::surajproject2024/*"
        ]
      }
    ]
    })
}

output "website_endpoint" {
    value = aws_s3_bucket_website_configuration.static.website_endpoint
  
}

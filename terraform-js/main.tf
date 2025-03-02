provider "aws" {
  region = "eu-central-1"
}

# S3 bucket
resource "aws_s3_bucket" "nextjs_bucket" {
    bucket = "nextjs-portfolio-bucket-ab1"
}

# Ownership control
resource "aws_s3_bucket_ownership_controls" "nextjs_bucket_ownership_controls" {
    bucket = aws_s3_bucket.nextjs_bucket.id
    rule {
      object_ownership = "BucketOwnerPrefferd"
    }
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "nextjs_bucket_public_access_block" {
    bucket = aws_s3_bucket.nextjs_bucket.id
  
# Open to public access
    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false

}

# Bucket ACL(Access Control Layer)

resource "aws_s3_bucket_acl" "nextjs_bucket_acl" {

    depends_on = [
        aws_s3_bucket_ownership_controls.nextjs,
        aws_s3_bucket_public_access_block.nextjs_bucket_public_access_block
      ]

      bucket = aws_s3_bucket.nextjs_bucket.id
      acl    = "public-read"
}

# Bucket policy

resource "aws_s3_bucket_policy" "nextjs_bucket_policy" {
    bucket = aws_s3_bucket.nextjs_bucket.id

    policy = jsonencode(({
        Version = "2012-10-17"
        Statement = [
            {
            Sid       = "PublicReadGetObject"
            Effect    = "Allow"
            Principal = "*"
            Action    = "s3:GetObject"
            Resource = "${aws_s3_bucket.nextjs_bucket.arn}/*"
            }
        ]
    }))
}
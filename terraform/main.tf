resource "aws_s3_bucket" "my-reason-for-depression" {
  bucket = var.bucketName
}

resource "aws_s3_bucket_acl" "my-reason-for-depression" {
  bucket = aws_s3_bucket.my-reason-for-depression.id
  acl    = var.aclType
}

resource "aws_s3_object" "my-reason-for-depression" {
  bucket = aws_s3_bucket.my-reason-for-depression.id
  key    = var.objectKey
  # source = "./www/"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  # etag = filemd5(aws_s3_object.my-reason-for-depression.source)
}

#resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
#  bucket = aws_s3_bucket.my-reason-for-depression.id
#  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
#}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.my-reason-for-depression.id

  policy = <<POLICY
{
"Version": "2012-10-17",
"Statement": [
{
"Sid": "PublicReadGetObject",
"Effect": "Allow",
"Principal": "*",
"Action": "s3:GetObject",
"Resource": "arn:aws:s3:::my-reason-for-depression/*"
}
]
}
POLICY
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = var.policyDocumentPrincipalsType
      identifiers = var.policyDocumentPrincipalsIdentifiers
    }

    actions = var.policyDocumentPrincipalsActions

    resources = [
      aws_s3_bucket.my-reason-for-depression.arn,
      "${aws_s3_bucket.my-reason-for-depression.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "my-reason-for-depression" {
  bucket = aws_s3_bucket.my-reason-for-depression.bucket

  index_document {
    suffix = var.indexWebsiteFile
  }

  error_document {
    key = var.errorWebsiteFile
  }

  routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": ""
    }
}]
EOF
}
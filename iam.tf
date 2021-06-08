module "iam_user2" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = "svc-${var.application}-${var.environment}"

  create_iam_user_login_profile = false
  create_iam_access_key         = true
}

module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  name        = "${var.application}-${var.environment}-buckets"
  path        = "/"
  description = "xxxxxxx"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::xxxxxxxx"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::xxxxxxxx/*"
        }
}
EOF
}

module "iam_policy_ses" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  name        = "${var.application}-ses"
  path        = "/"
  description = "Policy to allow send simple email service"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ses:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


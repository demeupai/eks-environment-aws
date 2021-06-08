terraform {
    backend "s3" {
        bucket = "xxxx-tfstate"
        region = "us-east-1"
        encrypt = "true"
        dynamodb_table = "dynamodb-backend"
        key = "xxxx/terraform.tfstate"
    }
}
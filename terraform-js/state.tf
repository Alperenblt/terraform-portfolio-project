terraform {
  backend "s3" {
    bucket = "ab1-my-terrafrom-state"
    key = "global/s3/terrafrom.tfstate"
    region = "eu-central-1"
    dynamodb_table = "terrafrom-lock-file"
  }
}


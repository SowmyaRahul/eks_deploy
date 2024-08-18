terraform {
  backend "s3" {
    bucket         = "tfstateforproject1"
    key            = "tf.state"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-table" # Optional but recommended
    encrypt        = true
  }
}

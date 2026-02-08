resource "aws_s3_bucket" "raw_bucket" {
  bucket = "${var.project_name}-raw-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket" "processed_bucket" {
  bucket = "${var.project_name}-processed-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket" "report_bucket" {
  bucket = "${var.project_name}-reports-${random_id.bucket_suffix.hex}"
}
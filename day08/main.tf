
resource "aws_s3_bucket" "bucket1" {
  count  = length(var.bucket_names)
  bucket = var.bucket_names[count.index]
}

resource "aws_s3_bucket" "bucket2" {
  for_each = toset(var.bucket_names2)
  bucket   = each.value

  depends_on = [aws_s3_bucket.bucket1]
}
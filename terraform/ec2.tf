resource "aws_instance" "anu_dev" {
  ami           = "ami-05fbd65e334e88c16"
  instance_type = "m7i-flex.large"

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

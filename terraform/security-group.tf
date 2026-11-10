resource "aws_security_group" "anu_dev_sg" {
  name   = "launch-wizard-3"
  vpc_id = "vpc-0c24d9f109178adc1"

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

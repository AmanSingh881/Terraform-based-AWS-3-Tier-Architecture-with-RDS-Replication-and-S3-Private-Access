# data "aws_acm_certificate" "example_cert" {
#   domain   = "example.com"  ########
#   statuses = ["ISSUED"]
#   most_recent = true

#   tags = {
#     "terraform" = true
#   }
# }

# output "certificate_arn" {
#   value = data.aws_acm_certificate.example_cert.arn
# }
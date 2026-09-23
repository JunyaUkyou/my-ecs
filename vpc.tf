# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16" # デフォルトVPCのCIDR(172.31..)は使わず新規作成
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-vpc"
  }
}

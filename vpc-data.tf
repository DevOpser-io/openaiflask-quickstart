data "aws_vpc" "selected" {
  # If deploying to an existing VPC and subnet, use the VPC ID
  id = var.vpc_id
}


data "aws_subnets" "amazon_linux" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

# Update to the tags of your private subnet
  tags = {
    OS = "Amazon Linux"
  }
}


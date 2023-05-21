provider "aws" {}

#create vpc 
resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.tag_name}-vpc"
  }
}
#import modules

module "subnet_mod" {
  source = "./modules/subnet"
  cidr_subnet = var.cidr_subnet
  tag_name = var.tag_name
  vpc_id = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}

module "mongo-server_mod" {
  source = "./modules/mongo-server"
  vpc_id = aws_vpc.myapp-vpc.id
  subnet_id = module.subnet_mod.subnet_blk.id
  key_path = var.key_path
  image_name = var.image_name
  tag_name = var.tag_name
}

# output "pub_ip" {
#   value = module.webserver_mod.pub_ip
  
# }
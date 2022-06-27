module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jenkins_instance"

  ami                    = "ami-0cff7528ff583bf9a"
  instance_type          = "t2.micro"
  key_name               = "Jenkins_key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.jenkins_sec_group.id]
  subnet_id              = module.vpc.public_subnets[1]
#   network_interface = module.vpc
  
}

////////////////////////////////////////////
////////elastic ip address/////////////////
//////////////////////////////////////////// 

resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2_instance.id
  allocation_id = aws_eip.jenkins_eip.allocation_id
}

resource "aws_eip" "jenkins_eip" {
  vpc = true
}
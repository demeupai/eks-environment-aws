module "ec2" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "~> 2.17.0"
  name                        = "${var.application}-${var.environment}-bastion"
  ami                         = var.bastion-ami
  instance_type               = var.bastion-type
  subnet_ids                  = module.vpc.public_subnets
  vpc_security_group_ids      = [module.sg-bastion.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.bastion-keys
  tags = {
    "Environment" = var.environment
    "App"         = var.application
  }
}

resource "aws_volume_attachment" "this" {
  count       = var.bastion-instance-number
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this[count.index].id
  instance_id = module.ec2.id[count.index]
}

resource "aws_ebs_volume" "this" {
  count             = var.bastion-instance-number
  availability_zone = module.ec2.availability_zone[count.index]
  size              = var.bastion-ebs-size
}
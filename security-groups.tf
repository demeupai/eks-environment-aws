
resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = var.ssh-port
    to_port   = var.ssh-port
    protocol  = "tcp"

    cidr_blocks = [
      "${var.cidr_block_vpc}",
    ]
  }
  tags = {
    Name        = "${var.application}-${var.environment}-one-worker-group"
    Environment = var.environment
    App         = var.application
  }
}

resource "aws_security_group" "worker_group_mgmt_two" {
  name_prefix = "worker_group_mgmt_two"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = var.ssh-port
    to_port   = var.ssh-port
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
    ]
  }
  tags = {
    Name        = "${var.application}-${var.environment}-two-worker-group"
    Environment = var.environment
    App         = var.application
  }
}

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_workers_mgnt"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = var.ssh-port
    to_port   = var.ssh-port
    protocol  = "tcp"

    cidr_blocks = ["${var.cidr_block_vpc}"]
  }
  tags = {
    Name        = "${var.application}-${var.environment}-all-worker-mgmt"
    Environment = var.environment
    App         = var.application
  }
}

module "sg-bastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.application}-bastion"
  description = "Bastion SG  to allow ssh connection from internet"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["${var.cidr_bastion}"]
  ingress_rules       = ["${var.bastion-ingress}"]
  egress_rules        = var.bastion-egress
  tags = {
    Name        = "${var.application}-${var.environment}-bastion"
    Environment = var.environment
    App         = var.application
  }
}

module "sg-db" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"

  name        = "${var.application}-database"
  description = "Postgre SG from VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = var.pg_port
      to_port     = var.pg_port
      protocol    = "tcp"
      description = "PostgreSQL allow access from VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]
  tags = {
    Name        = "${var.application}-${var.environment}-db"
    Environment = var.environment
    App         = var.application
  }
}

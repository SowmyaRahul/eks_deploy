module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.8.4"
  cluster_name    = "sowmiya-cluster"
  cluster_version = var.kubernetes_version
  subnet_ids      = [aws_subnet.subnet_az1_secure.id, aws_subnet.subnet_az2_secure.id]

  enable_irsa = true

  tags = {
    cluster = "project1"
  }

  vpc_id = aws_vpc.main.id

  eks_managed_node_group_defaults = {
    instance_types         = ["t2.micro"]
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  eks_managed_node_groups = {

    node_group = {
      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
    update_config = {
         max_unavailable            = 1
          max_unavailable_percentage = 0
        }
  }
}


resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group_rule" "all_worker_mgmt_ingress" {
  description       = "allow inbound traffic from eks"
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
  security_group_id = aws_security_group.all_worker_mgmt.id
  type              = "ingress"
  cidr_blocks = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "0.0.0.0/0"
  ]
}

resource "aws_security_group_rule" "all_worker_mgmt_egress" {
  description       = "allow outbound traffic to anywhere"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.all_worker_mgmt.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

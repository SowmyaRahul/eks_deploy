

# #
# # Create a security group for EKS
# resource "aws_security_group" "eks" {
#   vpc_id = aws_vpc.main.id
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "eks-security-group"
#   }
# }


# # Create the EKS cluster
# resource "aws_eks_cluster" "project1cluster" {
#   name     = "project1-cluster"
#   role_arn = aws_iam_role.eks.arn
#   vpc_config {
#     subnet_ids         = [aws_subnet.subnet_az1_secure.id, aws_subnet.subnet_az2_secure.id]
#     security_group_ids = [aws_security_group.eks.id]
#   }
#   # Define the Kubernetes version you want to use
#   version = "1.25"
# }

# # Create IAM role for EKS
# resource "aws_iam_role" "eks" {
#   name = "eks-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#       }
#     ]
#   })
#   tags = {
#     Name = "eks-role"
#   }
# }

# # Attach policies to the IAM role
# resource "aws_iam_role_policy_attachment" "eks_cluster" {
#   role       = aws_iam_role.eks.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# }

# resource "aws_iam_role_policy_attachment" "eks_service" {
#   role       = aws_iam_role.eks.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
# }

# # # Create a node group
# resource "aws_eks_node_group" "project1nodegroup" {
#   cluster_name  = aws_eks_cluster.project1cluster.name
#   node_role_arn = aws_iam_role.node.arn
#   subnet_ids    = [aws_subnet.subnet_az1_secure.id, aws_subnet.subnet_az2_secure.id]
#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#   }
#   instance_types = ["t2.micro"]
#   tags = {
#     Name = "eks-node-group"
#   }
# }

# # Create IAM role for worker nodes
# resource "aws_iam_role" "node" {
#   name = "eks-node-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       }
#     ]
#   })
#   tags = {
#     Name = "eks-node-role"
#   }
# }

# # Attach policies to the IAM role for nodes
# resource "aws_iam_role_policy_attachment" "node" {
#   role       = aws_iam_role.node.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
# }

# resource "aws_iam_role_policy_attachment" "node_cni" {
#   role       = aws_iam_role.node.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
# }

# # resource "aws_iam_role_policy_attachment" "node_autoscaler" {
# #   role       = aws_iam_role.node.name
# #   policy_arn = "arn:aws:iam::aws:policy/service-role/AutoScalingRole"
# # }























# #
# # # Create Launch Configuration
# # resource "aws_launch_configuration" "app_launch_configuration" {
# #   name          = "app-launch-configuration"
# #   image_id      = "ami-0c55b159cbfafe1f0"  # Replace with your AMI
# #   instance_type = "t2.micro"
# #   security_groups = [aws_security_group.app_sg.id]
# #
# #   lifecycle {
# #     create_before_destroy = true
# #   }
# #
# #   user_data = <<-EOF
# #               #!/bin/bash
# #               echo "Hello, World!" > /var/www/html/index.html
# #               EOF
# # }
# #
# # # Create Auto Scaling Group
# # resource "aws_autoscaling_group" "app_asg" {
# #   launch_configuration = aws_launch_configuration.app_launch_configuration.id
# #   vpc_zone_identifier  = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
# #   min_size              = 1
# #   max_size              = 3
# #   desired_capacity      = 2
# #
# #   tag {
# #     key                 = "Name"
# #     value               = "app-instance"
# #     propagate_at_launch = true
# #   }
# # }
# #
# # # Create Security Group for Instances
# # resource "aws_security_group" "app_sg" {
# #   name        = "app-sg"
# #   description = "Allow HTTP traffic from ALB"
# #   vpc_id      = aws_vpc.main.id
# #
# #   ingress {
# #     from_port   = 80
# #     to_port     = 80
# #     protocol    = "tcp"
# #     security_groups = [aws_security_group.alb_sg.id]
# #   }
# #
# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
# # }
# #
# # # Register Auto Scaling Group Instances with Target Group
# # resource "aws_autoscaling_attachment" "app_asg_attachment" {
# #   autoscaling_group_name = aws_autoscaling_group.app_asg.name
# #   target_group_arn       = aws_lb_target_group.my_target_group.arn
# # }
# #


# #
# # # create security group for the database
# # resource "aws_security_group" "database_security_group" {
# #   name        = "database security group"
# #   description = "enable mysql/aurora access on port 3306"
# #   vpc_id      = aws_vpc.main.id
# #
# #   ingress {
# #     description      = "mysql/aurora access"
# #     from_port        = 3306
# #     to_port          = 3306
# #     protocol         = "tcp"
# #     security_groups  = [var.alb_security_group_id]
# #   }
# #
# #   egress {
# #     from_port        = 0
# #     to_port          = 0
# #     protocol         = -1
# #     cidr_blocks      = ["0.0.0.0/0"]
# #   }
# #
# #   tags   = {
# #     Name = "database security group"
# #   }
# # }


# # # create the subnet group for the rds instance
# # resource "aws_db_subnet_group" "database_subnet_group" {
# #   name         = "db-secure-subnets"
# #   subnet_ids   = [var.subnet_az1_
# #   secure.id, var.subnet_az1_secure.id]
# #   description  = "rds in secure subnet"
# #
# #   tags   = {
# #     Name = "db-secure-subnets"
# #   }
# # }

# #mysql -h project1.cb6oyio086hd.us-west-2.rds.amazonaws.com -P 3306 -u project1uname -p


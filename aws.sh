#!/bin/bash


AWS_REGION="us-west-2"
VPC_NAME="My VPC"
VPC_CIDR="10.0.0.0/16"
SUBNET_PUBLIC_CIDR="10.0.1.0/24"
SUBNET_PUBLIC_AZ="us-west-1a"
SUBNET_PUBLIC_NAME="10.0.1.0 - us-west-1a"
SUBNET_PRIVATE_CIDR="10.0.2.0/24"
SUBNET_PRIVATE_AZ="us-west-1b"
SUBNET_PRIVATE_NAME="10.0.2.0 - us-west-1b"
CHECK_FREQUENCY=5



# Create VPC
echo "Creating VPC in preferred region..."
VPC_ID=$(aws ec2 create-vpc \
	  --cidr-block $VPC_CIDR \
	    --query 'Vpc.{VpcId:VpcId}' \
	      --output text \
	        --region $AWS_REGION)
echo "  VPC ID '$VPC_ID' CREATED in '$AWS_REGION' region.":

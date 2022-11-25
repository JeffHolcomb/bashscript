#!/bin/bash

AWS_REGION="us-west-2"
VPC_NAME="My VPC"
VPC_CIDR="10.0.0.0/16"
SUBNET_PUBLIC_CIDR="10.0.1.0/24"
SUBNET_PUBLIC_AZ="us-west-2a"
SUBNET_PUBLIC_NAME="10.0.1.0 - us-west-2a"
SUBNET_PRIVATE_CIDR="10.0.2.0/24"
SUBNET_PRIVATE_AZ="us-west-2b"
SUBNET_PRIVATE_NAME="10.0.2.0 - us-west-2b"
CHECK_FREQUENCY=5

#create VPC
echo "Creating VPC in preferred region..."

sleep 3


# Create VPC

VPC_ID=$(aws ec2 create-vpc \
	  --cidr-block $VPC_CIDR \
	    --query 'Vpc.{VpcId:VpcId}' \
	      --output text \
	        --region $AWS_REGION)

sleep 2

echo "VPC has been created."

sleep 2

echo "VPC ID is '$VPC_ID' and it has been created in the '$AWS_REGION' region."

sleep 2

# Create Public Subnet

echo "Creating Public Subnet..."

SUBNET_PUBLIC_ID=$(aws ec2 create-subnet \
	           --vpc-id $VPC_ID \
		     --cidr-block $SUBNET_PUBLIC_CIDR \
		       --availability-zone $SUBNET_PUBLIC_AZ \
		         --query 'Subnet.{SubnetId:SubnetId}' \
		           --output text \
		             --region $AWS_REGION)

echo "Public subnet '$SUBNET_PUBLIC_ID' has been created in '$SUBNET_PUBLIC_AZ'"

sleep 2

# Create Private Subnet

echo "Creating Private Subnet..."

SUBNET_PRIVATE_ID=$(aws ec2 create-subnet \
                    --vpc-id $VPC_ID \
	              --cidr-block $SUBNET_PRIVATE_CIDR \
	                --availability-zone $SUBNET_PRIVATE_AZ \
	                  --query 'Subnet.{SubnetId:SubnetId}' \
	                    --output text \
	                      --region $AWS_REGION)

echo "Private subnet '$SUBNET_PRIVATE_ID' has been created '$SUBNET_PRIVATE_AZ'"

sleep 2

# Create Internet gateway

echo "Creating Internet Gateway..."

IGW_ID=$(aws ec2 create-internet-gateway \
         --query 'InternetGateway.{InternetGatewayId:InternetGatewayId}' \
           --output text \
             --region $AWS_REGION)

sleep 2

echo "Internet Gateway ID '$IGW_ID' has been created"




#Future deletion instructions:

#aws ec2 delete-internet-gateway --internet-gateway-id igw-073df7c587deef72b





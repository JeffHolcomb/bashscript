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
echo "Creating VPC in preferred region $AWS_REGION..."
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
echo "VPC ID is '$VPC_ID' and has been created in the '$AWS_REGION' region."
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
sleep 2
echo "Attaching Internet Gateway to VPC"
# Attach Internet gateway to your VPC
aws ec2 attach-internet-gateway \
  --vpc-id $VPC_ID \
  --internet-gateway-id $IGW_ID \
  --region $AWS_REGION
echo "Internet Gateway ID '$IGW_ID' attached to VPC ID '$VPC_ID'."
sleep 2
echo "Creating Route Table..."
ROUTE_TABLE_ID=$(aws ec2 create-route-table \
  --vpc-id $VPC_ID \
  --query 'RouteTable.{RouteTableId:RouteTableId}' \
  --output text \
  --region $AWS_REGION)
echo "Route Table complete."
sleep 2
echo "Adding new Route Table to the Internet Gateway"
sleep 2
# Create route to Internet Gateway
RESULT=$(aws ec2 create-route \
  --route-table-id $ROUTE_TABLE_ID \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id $IGW_ID \
  --region $AWS_REGION)
echo "Route table added to Internet Gateway"
sleep 2
echo "Associating Route Table with Public Subnet"
# Associate Public Subnet with Route Table
RESULT=$(aws ec2 associate-route-table  \
  --subnet-id $SUBNET_PUBLIC_ID \
  --route-table-id $ROUTE_TABLE_ID \
  --region $AWS_REGION)
echo "Association Complete"







#Future deletion instructions:

# #aws ec2 delete-internet-gateway --internet-gateway-id $IGW_ID
# aws ec2  delete-route-table --route-table-id "$ROUTE_TABLE_ID"

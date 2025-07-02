#!/bin/bash
# Script to set up DigitalOcean Spaces as a Terraform backend

# Check for required tools
command -v doctl >/dev/null 2>&1 || { echo "doctl is required but not installed. Aborting."; exit 1; }

# Configuration
SPACES_NAME="terraform-states"
SPACES_REGION="nyc3"  # Change to your preferred region

# Ensure doctl is authenticated
echo "Checking DigitalOcean authentication..."
doctl account get >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Please authenticate with DigitalOcean first:"
  echo "doctl auth init"
  exit 1
fi

# Create Spaces bucket using doctl
echo "Creating Spaces bucket for Terraform state..."
doctl spaces create $SPACES_NAME --region $SPACES_REGION

# Create backend.tf file
echo "Creating backend.tf file..."
cat > backend.tf << EOF
terraform {
  backend "s3" {
    endpoint                    = "$SPACES_REGION.digitaloceanspaces.com"
    region                      = "us-east-1"  # Required but not used
    bucket                      = "$SPACES_NAME"
    key                         = "$(basename $(pwd))/terraform.tfstate"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}
EOF

echo "Setup complete! Your backend.tf file has been created."
echo "Make sure to set these environment variables before running terraform init:"
echo "export SPACES_ACCESS_KEY_ID=your_spaces_access_key"
echo "export SPACES_SECRET_ACCESS_KEY=your_spaces_secret_key"
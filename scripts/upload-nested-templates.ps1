# ---------------------------------------------------------
# Upload nested CloudFormation templates to S3 (PowerShell)
# ---------------------------------------------------------

# Get AWS account ID
$AccountId = (aws sts get-caller-identity --query Account --output text)
$Region = "eu-west-2"
$BucketName = "$AccountId-$Region-cf-templates"

Write-Host "Uploading nested CloudFormation templates to s3://$BucketName/"
Write-Host ""

# Check if bucket exists
$bucketExists = aws s3 ls "s3://$BucketName" 2>$null

if (-not $bucketExists) {
    Write-Host "Bucket does not exist. Creating..."
    aws s3 mb "s3://$BucketName" --region $Region
}

# Upload templates
aws s3 cp "cloudformation/vpc-stack.yaml" "s3://$BucketName/vpc-stack.yaml"
aws s3 cp "cloudformation/rds-stack.yaml" "s3://$BucketName/rds-stack.yaml"
aws s3 cp "cloudformation/root-stack.yaml" "s3://$BucketName/root-stack.yaml"
aws s3 cp "cloudformation/ec2-stack.yaml" "s3://$BucketName/ec2-stack.yaml"

Write-Host ""
Write-Host "Upload complete."
Write-Host "Templates available at:"
Write-Host "  https://s3.amazonaws.com/$BucketName/vpc-stack.yaml"
Write-Host "  https://s3.amazonaws.com/$BucketName/rds-stack.yaml"
Write-Host "  https://s3.amazonaws.com/$BucketName/root-stack.yaml"
Write-Host "  https://s3.amazonaws.com/$BucketName/ec2-stack.yaml"
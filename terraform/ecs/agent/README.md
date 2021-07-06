# PacketAI Agent installation on AWS ECS cluster

## Instructions to install AWS ECS PacketAI Agent

- make sure your AWS credentials are configured, if not please export them
  - `export AWS_ACCESS_KEY_ID=`
  - `export AWS_SECRET_ACCESS_KEY=`
  - `export AWS_REGION=$ECS_CLUSTER_REGION`
- `terraform init -backend-config="bucket=$S3_BUCKET_BACKEND" -backend-config="key=$S3_KEY_BACKEND"`
  - We are setting S3 backend to maintain the terraform state. you could use existing s3 bucket (make sure it's private)
    - ex: `terraform-state-prod`
  - provide unique key for storing terraform state.
    - ex: `ecs/packetai-agent/$CLUSTER_NAME.tfstate`
- Run: `terraform apply -var="cluster_name=$CLUSTER_NAME" -var="X_PAI_TOKEN=$X_PAI_TOKEN" -var="PAI_API_KEY=$PAI_API_KEY" -var="APIDEVURL=$APIDEVURL"`
- To destroy, because of [#4852](https://github.com/hashicorp/terraform-provider-aws/issues/4852), we must run `aws autoscaling update-auto-scaling-group --auto-scaling-group-name "$(terraform output -raw asg_name)" --min-size 0 --desired-capacity 0` before running `terraform apply -var="cluster_name=$CLUSTER_NAME" -var="X_PAI_TOKEN=$X_PAI_TOKEN" -var="PAI_API_KEY=$PAI_API_KEY" -var="APIDEVURL=$APIDEVURL"`

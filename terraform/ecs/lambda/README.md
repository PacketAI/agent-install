# PacketAI Lambda function installation for AWS ECS container insights

## PacketAI Lambda function for AWS ECS metrics
* make sure your AWS credentials are configured, if not please export them
    * export AWS_ACCESS_KEY_ID=
    * export AWS_SECRET_ACCESS_KEY=
    * export AWS_REGION=$ECS_CLUSTER_REGION
* `terraform init -backend-config="bucket=$S3_BUCKET_BACKEND" -backend-config="key=$S3_KEY_BACKEND"`
    * We are setting S3 backend to maintain the terraform state. you could use existing s3 bucket (make sure it's private)
        * ex: terraform-state-prod
    * provide unique key for storing terraform state.
        * ex: ecs/packetai-lambda/$CLUSTER_NAME.tfstate
* Run: `terraform apply -var="cluster_name=$CLUSTER_NAME" -var="INFRA_ID=$INFRA_ID" -var="INGEST_URL=$INGEST_URL"`

#!/bin/bash

# Remove if previously deployed function exists
aws lambda delete-function --region ap-southeast-2 --function-name TestDotNetCore 2>/dev/null

# Create lambda function
aws lambda create-function --function-name TestDotNetCore \
    --runtime "dotnetcore1.0"  \
    --role $LAMBDA_ROLE_ARN \
    --handler lambda-hello-world::example.lambda_hello_world.LambdaHandler::HelloWorld \
    --zip-file fileb://./lambda-hello-world/bin/Debug/netcoreapp1.0/publish/package.zip

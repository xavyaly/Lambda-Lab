#!/bin/bash

aws lambda create-function \
    --function-name "MyLambdaFunction" \
    --runtime "nodejs18.x" \
    --role "arn:aws:iam::ACCOUNT_ID:role/lambda-basic-execution-role" \
    --handler "app/index.handler" \
    --timeout 5 \
    --zip-file "fileb://./app.zip" \
    --region "us-east-2"
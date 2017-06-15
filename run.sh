#!/bin/bash

 aws lambda invoke --function-name TestDotNetCore \
    --invocation-type RequestResponse \
    --region ap-southeast-2 \
     --log-type Tail \
     out.txt | jq -r '.LogResult' | base64 -D

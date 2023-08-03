#!/bin/bash

aws apigateway create-resource \
  --rest-api-id "vkmkcxoyj1" \
  --parent-id "/" \
  --path-part "myresource"

# FAILED
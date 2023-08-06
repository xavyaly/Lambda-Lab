#!/bin/bash

aws apigateway create-resource \
  --rest-api-id "vkmkcxoyj1" \
  --parent-id "a122" \
  --path-part "myresource"

# FAILED
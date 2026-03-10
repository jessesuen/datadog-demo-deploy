# Lambda App

This directory contains the python implementation for the demo lambda app
as well as the Dockerfile to package the app as a container.

# Releasing an image

```
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 541216676946.dkr.ecr.us-west-2.amazonaws.com
make push-image VERSION=7.0.0
```
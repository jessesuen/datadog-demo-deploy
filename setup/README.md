## Prerequisites


## Applying Kargo Resources

```
kargo apply -f kargo/

# Enter PAT credentials
kargo create credentials github \
  --project datadog-demo \
  --git \
  --username akuitybot \
  --repo-url https://github.com/jessesuen/datadog-demo-deploy

# Use credentials from AWS user
kargo apply -f - << EOF
apiVersion: v1
kind: Secret
metadata:
  name: lambda-ecr
  namespace: datadog-demo
  labels:
    kargo.akuity.io/cred-type: image
stringData:
  repoURL: 541216676946.dkr.ecr.us-west-2.amazonaws.com/datadog-demo/lambda-app
  awsRegion: us-west-2
  awsAccessKeyID: ${AWS_ACCESS_KEY_ID}
  awsSecretAccessKey: ${AWS_SECRET_ACCESS_KEY}
EOF
```

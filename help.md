### Configure kubectl to work with EKS
1. aws eks update-kubeconfig --name eks-test --region eu-central-1

### Working with contexts
1. kubectl config get-contexts
2. kubectl config use-context eks-test


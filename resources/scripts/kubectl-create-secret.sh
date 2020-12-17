#! /bin/bash
#delete secrets and recreate it
kubectl delete secret docker-credentials

#secrets for docker hub
#for ECR and others see https://github.com/GoogleContainerTools/kaniko#pushing-to-amazon-ecr
#f.e kubectl create secret generic aws-secret --from-file=<path to .aws/credentials>
kubectl create secret docker-registry docker-credentials \
    --docker-username=${USER}  \
    --docker-password=${PASSWORD}



#unused
#kubectl create secret docker-registry index.docker.io-v1 --docker-server=https://index.docker.io/v1/ --docker-username=hello --docker-password=password\$withspecialcharacter --namespace=test --docker-email=text@example.com
#kubectl create secret docker-registry k8smpf-docker --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>


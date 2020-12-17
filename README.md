
A K8s team-self-service aproach encapsulated in a Jenkin Pipeline job.
The assumption that this job runs in dedicated team namespace with  a dedicated service account for this team.


.see resources/scripts/expandRBACforJenkins.sh 
```
TEAM_NAMESPACE=cloudbees-team-namespace
TEAM_NAMESPACE_SERVICEACCOUNT=jenkins
cat << EOF > /tmp/clusterRole.yml
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: jenkins-robot
rules:
  - apiGroups: [""]
    resources: ["*", "*"]
    verbs: ["get", "watch", "list","delete","create"]
EOF
kubectl apply -f /tmp/clusterRole.yml
...
kubectl create rolebinding jenkins-robot \
    --clusterrole jenkins-robot \
    --serviceaccount ${TEAM_NAMESPACE}:${TEAM_NAMESPACE_SERVICEACCOUNT}

```


- NOTE: Tis example is using very wide permissions. apiGroups, permissions and verbs need to be adjusted/restricted for your need.
- [prepare a namesxpace](https://docs.cloudbees.com/docs/cloudbees-ci/latest/cloud-admin-guide/managing) 
- create a Master/Controler in that namespace by using CJOC
- add a role with the required K8s API permissions for the new namespace to the servoice account. Verify th serviceaccount for your namespace:
 `kctl get sa -n <TEAM_NAMESPACE>` #a SA `jenkins` should be created by deafult for each team namespace as son as the master is created in that namespace
- create a custom build agent with kubectl installed
see [Custom-Agent-Kubectl-Dockerfile](https://github.com/pipeline-demo-caternberg/pipeline-examples/blob/master/resources/dockerfiles/Dockerfile-custom-jnlp-agent)
- [create a GH token](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token)


| File | Description |
| --- | --- |
| Jenkinsfile | Jenkins Pipeline to run a kubectl agent|
| resources/scripts/expandRBACforJenkins.sh | |
def apiScript='resources/scripts/serviceAccountAPItest.sh'
def createDockerCredenetials='resources/scripts/kubectl-create-secret.sh'
def credentialID="a5e189cf-d372-4b05-9f39-8c24952850e2"
pipeline {
    agent {
        kubernetes {
            yamlFile 'resources/yaml/podTemplate-customagent.yml'
        }
    }
    parameters {
        string(name: 'kubectl_command', defaultValue: 'cluster-info',   description: 'kubectl command')
        //F.e AWS key can be taken here as well from Credstore
        string(name: 'k8sendpoint', defaultValue: 'https://35.196.164.234/',   description: 'user')
        string(name: 'user', defaultValue: 'caternberg',   description: 'user')
        password(name: 'passwd', defaultValue: 'secret', description: 'password')
    }
    environment {
        USER="${user}"
        PASSWORD="${password}"
    }
    stages {

        stage('SAJenkinsK8sAccount') {
            steps {
                container('custom-agent') {
                    echo 'Hello World!'
                    withKubeConfig(credentialsId: "${credentialID}" ,namespace: 'cloudbees-core', serverUrl: "${params.k8sendpoint}") {
                        // sh "kubectl version"
                        sh "kubectl ${params.kubectl_command}"
                        sh "${createDockerCredenetials}"
                       // sh "kubectl delete secret docker-credentials"
                       // sh "kubectl create secret docker-registry docker-credentials --docker-username=${params.user}  --docker-password=${params.passwd}  2>&1 > /dev/null"
                    }
                }
            }
        }
        stage('SAJenkins') {
            steps {
                container('custom-agent') {
                    echo 'Hello World!'
                    withKubeConfig(credentialsId:  "${credentialID}" , namespace: 'cloudbees-masters', serverUrl: "${params.k8sendpoint}") {
                        sh "kubectl version"
                        sh "kubectl ${params.kubectl_command}"
                    }
                }
            }
        }
        /* stage('ClusterAdmin') {
             steps {
                 container('custom-agent') {
                     echo 'Hello World!'
                     withKubeConfig(credentialsId: 'BearerClusterAdmin', namespace: 'cloudbees-core', serverUrl: "${params.k8sendpoint}") {
                         sh "kubectl version"
                         sh "kubectl ${params.kubectl_command}"
                         timeout(time: 3, unit: 'MINUTES') {
                             retry(5) {
                                 //call external shell script
                                 sh "${apiScript}"
                             }
                         }
                     }
                 }
             }
         }*/

    }
}

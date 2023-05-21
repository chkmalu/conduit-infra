pipeline {
    agent any

    stages {
        stage('TERRAFORM PLAN') {
            steps {
                echo 'PLANING INFRASTRUCTURE'
                dir('conduit-infra') {
                    sh 'terraform init'
                    sh 'terraform plan'
                }
            }
        }
        stage('TERRAFORM APPLY') {
            steps {
                echo 'DEPLOYING INFRASTRUCTURE'
                dir('conduit-infra') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('DEPLOY PROMETHEUS-MONITORING') {
            steps {
                echo 'DEPLOYING PROMETHEUS-MONITORING'
                script{
                    sh 'helm repo add prometheus-community https://prometheus-community.github.io/helm-charts'
                    sh 'helm repo update'
                    sh 'kubectl create namespace monitoring'
                    sh 'helm install monitoring prometheus-community/prometheus -n monitoring'
                    sh 'kubectl get all -n monitoring'
                }
            }
        }
    }
}
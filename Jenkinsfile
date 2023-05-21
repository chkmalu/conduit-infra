pipeline {
    agent any

    environment {
        IMAGE_REPO = "081241791096.dkr.ecr.us-east-1.amazonaws.com"
        IMAGE_NAME = "seamlesshr"
        IMAGE_TAG = '1.0'
        STATUS = false;

    }

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
                dir('tconduit-infra') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
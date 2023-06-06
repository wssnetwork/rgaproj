pipeline {
    agent any
    stages {
        stage('Tfsec scan') {
            agent {
                docker {
                    image 'aquasec/tfsec-ci:latest'
                    reuseNode true
                }
            }
            steps {
                sh 'tfsec . --no-color'
            }
        }      
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform action') {
            steps {
                sh 'terraform ${action} --auto-approve'
            }
        }
    }
}


pipeline {
    agent any
    stages {
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


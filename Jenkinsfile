pipeline {
    // agent { docker { image 'python:3.10.7-alpine' } }
    // stages {
    //     stage('build') {
    //         steps {
    //             sh 'python --version'
    //         }
    //     }
    // }
    agent any
    stages {
        stage('test terraform') {
            steps{
                sh 'terraform --version'
            }
        }
    }
}


pipeline {
    agent any

    options {
        timestamps()
    }

    stages {
        stage('Git Checkout') {
            steps {
                checkout scm
                echo 'GitHub source code checked out successfully'
            }
        }

        stage('Application Validation') {
            steps {
                sh 'ls -la application/'
                sh 'test -f application/index.html'
                sh 'test -f application/style.css'
                sh 'test -f application/script.js'
                echo 'Application files validated successfully'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully'
        }

        failure {
            echo 'Pipeline failed. Check the Jenkins console output.'
        }
    }
}

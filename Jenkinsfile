pipeline {
    agent any

    options {
        timestamps()
    }

    environment {
        IMAGE_NAME = 'anu-devsecops'
        SONAR_PROJECT_KEY = 'anu-devsecops'
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
                sh 'test -f application/index.html'
                sh 'test -f application/style.css'
                sh 'test -f application/script.js'
                echo 'Application files validated successfully'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    script {
                        def scannerHome = tool 'SonarScanner'
                        sh """
                            ${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                            -Dsonar.projectName='Anu DevSecOps Application' \
                            -Dsonar.sources=application \
                            -Dsonar.sourceEncoding=UTF-8
                        """
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:latest .'
                echo 'Docker image built successfully'
            }
        }

        stage('Trivy Security Scan') {
            steps {
                sh 'trivy image --severity HIGH,CRITICAL --exit-code 0 ${IMAGE_NAME}:latest'
            }
        }

        stage('Terraform Validation') {
            steps {
                sh 'terraform -chdir=terraform fmt -check -recursive'
                sh 'terraform -chdir=terraform init -backend=false'
                sh 'terraform -chdir=terraform validate'
            }
        }
    }

    post {
        success {
            echo 'DevSecOps pipeline completed successfully'
        }

        failure {
            echo 'Pipeline failed. Please check the Jenkins console output.'
        }
    }
}

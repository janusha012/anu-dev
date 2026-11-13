
pipeline {
    agent any

    options {
        timestamps()
    }

    environment {
        IMAGE_NAME = 'anu-devsecops'
        SONAR_PROJECT_KEY = 'anu-devsecops'
        AWS_REGION = 'ap-south-1'
        ECR_REPOSITORY = 'eks-anu'
        EKS_CLUSTER_NAME = 'anu-eks-cluster'
        ECR_URI = '179260491954.dkr.ecr.ap-south-1.amazonaws.com/eks-anu'
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
                sh '''
                    test -f application/index.html
                    test -f application/style.css
                    test -f application/script.js
                    test -f deployment.yaml
                    test -f service.yaml
                '''
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
            }
        }

        stage('Trivy Security Scan') {
            steps {
                sh 'trivy image --severity HIGH,CRITICAL --exit-code 0 ${IMAGE_NAME}:latest'
            }
        }

        stage('ECR Login and Push') {
            steps {
                sh '''
                    aws ecr get-login-password --region ${AWS_REGION} |
                    docker login --username AWS --password-stdin ${ECR_URI%/*}

                    docker tag ${IMAGE_NAME}:latest ${ECR_URI}:latest

                    docker push ${ECR_URI}:latest
                '''
            }
        }

        stage('EKS Deployment') {
            steps {
                sh '''
                    aws eks update-kubeconfig \
                      --region ${AWS_REGION} \
                      --name ${EKS_CLUSTER_NAME}

                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml

                    kubectl rollout status deployment/anu-devsecops-app \
                      --timeout=300s
                '''
            }
        }

        stage('Terraform Validation') {
            steps {
                sh '''
                    terraform -chdir=terraform fmt -check -recursive
                    terraform -chdir=terraform init -backend=false
                    terraform -chdir=terraform validate
                '''
            }
        }
    }

    post {
        success {
            echo 'DevSecOps CI/CD pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check Jenkins console output.'
        }
    }
}


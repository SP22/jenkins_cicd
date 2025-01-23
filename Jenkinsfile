pipeline {
    agent {
        docker {
            image 'node:lts-buster-slim'
            args '-p 3000:3000'
        }
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/SP22/jenkins_cicd.git'
            }
        }
        stage('Build') {
            steps {
                sh 'chmod +x scripts/build.sh'
                sh 'scripts/build.sh'
            }
        }
        stage('Test') {
            steps {
                echo "Running tests for ${env.BRANCH_NAME}"
            }
        }
        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t myapp:${env.BRANCH_NAME} .
                '''
            }
        }
        stage('Deploy') {
            steps {
                script {
                    def port = (env.BRANCH_NAME == 'main') ? 3000 : 3001
                    sh """
                    docker run -d -p ${port}:${port} --name myapp-${env.BRANCH_NAME} myapp:${env.BRANCH_NAME}
                    """
                }
            }
        }
    }
}

pipeline {
    agent any

    triggers {
        // Trigger automatically when GitHub webhook fires
        githubPush()
    }

    environment {
        IMAGE_NAME = "php-webapp"
        CONTAINER_NAME = "php-webapp-container"
        PORT = "8081"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Run Container') {
            steps {
                echo "Running container..."
                // Stop existing container (ignore errors)
                sh 'docker rm -f ${CONTAINER_NAME} || true'
                // Run new one
                sh 'docker run -d -p ${PORT}:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest'
            }
        }
    }

    post {
        success {
            echo "✅ Build successful! App running on http://localhost:${PORT}"
        }
        failure {
            echo "❌ Build failed. Check Jenkins logs."
        }
    }
}


pipeline {
    agent { label 'dev-agent' }

    environment {
        COMPOSE_PROJECT_NAME = 'ptdev'
        COMPOSE_FILE = 'docker-compose.yml'
        DOCKER_IMAGE = "myregistry.local/${COMPOSE_PROJECT_NAME}:latest"
        SECRET_KEY = 'devsecrettext'
        DJANGO_SETTINGS_MODULE = 'simpleapi.settings_local'
        PYTHON_IMAGE = 'python:3.12-slim'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning the repository...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker-compose build"
#                sh "docker build --target dockerbase --build-arg PYTHON_IMAGE=${PYTHON_IMAGE}  -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Deploy Postgresql') {
            steps {
                echo 'Deploying Postgresql...'
                sh "docker-compose --profile pg up -d pg"
            }
        }

        stage('Deploy App') {
            steps {
                echo 'Run migrations...'
                sh "docker-compose run --rm migrate"
                echo 'Deploying application...'
                sh "docker-compose up -V -d"
            }
        }

        stage('Test api response') {
            steps {
                echo 'Running application tests...'
                sleep 2 // Allow time for the container to initialize
                sh "docker-compose exec mainapp curl -f http://localhost:8000/api/current-time/ || (docker-compose logs mainapp && exit 1)"
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
        success {
            echo 'Application successfully deployed!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}

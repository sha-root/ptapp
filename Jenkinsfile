pipeline {
    agent { label 'dev4 || docker || docker-compose' }
    //agent {docker {image 'docker:cli'}}

    environment {
        VPS_IP = credentials('ptdev-vps-ip')
        SSH_PKEY = credentials('ptdev-ssh-pkey')
        DOCKER_HOST = "ssh://jenkins@${VPS_IP}"
        COMPOSE_PROJECT_NAME = "ptdev"
        COMPOSE_FILE = "docker-compose.yml"
        PYTHON_IMAGE = "python:3.12-slim"
        SECRET_KEY = "ptdevsecretkeyMayBeSetFromCredentials"
        DJANGO_SETTINGS_MODULE = "simpleapi.settings_local"
    }

    stages {
        stage('Setup'){
            steps {
                echo 'configure ssh key and host'
                sh '''
                    [ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh && 
                    echo "Host ${VPS_IP}" >> ~/.ssh/config
                    echo "    UserKnownHostsFile /dev/null"
                    echo "    StrictHostKeyChecking no"
                    echo "    User jenkins" >> ~/.ssh/config
                    echo "    IdentityFile ${SSH_PKEY}" >> ~/.ssh/config
                '''
                sh "docker-compose ps && docker-compose config"
            }
        }
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
            sh "rm -f ~/.ssh/config"
        }
        success {
            echo 'Application successfully deployed!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}

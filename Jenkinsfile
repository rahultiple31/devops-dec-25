pipeline {
    agent any

    parameters {
        string(
            name: 'PERSON',
            defaultValue: 'Mr Jenkins', 
            description: 'Who should I say hello to?')

        choice(name: 'CHOICE',
            choices: ['Dev', 'Qa', 'Prod'],
            description: 'Pick something')
    }

    environment {
        APP_NAME = "Web-applicetion"
        ENV_NAME = "Dev"
        IMAGE_NAME = "web"
        DOCKER_HUB_IMAGE_NAME = "rahultipledocker/dec-java:latest"
    }

    tools {
        jdk 'java11'
        maven 'mvn'
    }

    stages {
    
        stage('print enviroment variables') {
            steps {
                    echo "Application name : $APP_NAME"
                    echo "Dev enviroment : $ENV_NAME"

                    echo "Hello ${params.PERSON}"
                    echo "Enviroment: ${params.CHOICE}"
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Clean') {
            steps {
                sh 'mvn clean'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn -B install'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Docker image build') {
            steps {
                sh '''
                    docker --version
                    docker build -t $IMAGE_NAME .
                    docker images
                '''
            }
        }

        stage('Docker push to dockerHub repository') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DOCKERHUB_LOGIN', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                sh '''
                    echo "docker delete image if exists"
                    docker rmi $DOCKER_HUB_IMAGE_NAME || true
                    
                    echo "tag change"
                    docker tag $IMAGE_NAME $DOCKER_HUB_IMAGE_NAME

                    echo "Docker login"
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                    echo "docker push"
                    docker push $DOCKER_HUB_IMAGE_NAME

                    echo "docker logout"
                    docker logout
                '''
                }
            }
        }

        stage('Deployment') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DOCKERHUB_LOGIN', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                sh '''
                    echo "delete docker container if exists"
                    docker rm -f webapp || true

                    echo "Docker login"
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                    echo "container create"
                    docker run -itd -p 8090:8080 --name webapp $DOCKER_HUB_IMAGE_NAME

                    echo "check docker running container"
                    docker ps

                    echo "docker logout"
                    docker logout
                '''
                }
            }
        }
    }
    post {
        always {
            echo 'This will always run after the stages finish'
        }
        success {
            echo 'This will run only if the pipeline succeeds'
            mail(
                to: 'vaibhavpohankar30@gmail.com',
                subject: "Successful Pipeline: ${currentBuild.fullDisplayName}",
                body: "Pipeline completed successfully."
            )
        }
        failure {
            echo 'This will run only if the pipeline fails',
            mail(
                to: 'vaibhavpohankar30@gmail.com',
                subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
                body: "Something is wrong with ${env.BUILD_URL}, ${env.JOB_NAME} and ${env.BUILD_NUMBER}"
            )
        }
    }
}

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
                    docker build -t $IMAGE_NAME .
                    docker images
                '''
            }
        }
    }
}

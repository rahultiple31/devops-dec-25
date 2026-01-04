pipeline {
    agent any

    environment {
        APP_NAME = "Web-applicetion"
        ENV_NAME = "Dev"
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
                    apt update
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
    }
}

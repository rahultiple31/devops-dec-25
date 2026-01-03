pipeline {
    agent any

    // set up tools configured in Jenkins global config
    tools {
        jdk 'java11'
        maven 'mvn'           // name of Maven installation in Jenkins
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/rahultiple31/devops-dec-25.git'
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

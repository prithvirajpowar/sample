pipeline {
    agent any
    
    stages {
     
        stage('Build and test') {
            steps {
               
                sh 'flutter pub get'
                sh 'flutter build apk'
            }
        }
        
        stage('Build Docker image') {
            steps {
                sh 'docker build -t my-flutter-app .'
            }
        }
        
        stage('Push to Docker registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin"
                }
                sh 'docker push my-flutter-app'
            }
        }
    }
}

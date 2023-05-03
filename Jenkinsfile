pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'flutter pub get'
                sh 'flutter build apk'
            }
        }
        
        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', fingerprint: true
            }
        }
        
        stage('Build Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://hub.docker.com/']) {
                    sh 'docker build -t prithvirajpowar/myapp .'
            }
        }
        
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://hub.docker.com/']) {
                    sh 'docker push prithvirajpowar/myapp'
                }
            }
        }
    }
}
}

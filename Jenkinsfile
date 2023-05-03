peline {
    agent any
    stages {
        stage('Build') {
            steps {
                    sh 'flutter build apk --release'
                }

                // archive the APK
                archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', fingerprint: true
            }
        

        stage('Dockerize') {
            steps {
                // create the Docker image
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://hub.docker.com/']) {
                    sh 'docker build -t prithvirajpowar/myapp .'
                }

                // push the Docker image to Docker Hub
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://hub.docker.com/']) {
                    sh 'docker push prithvirajpowar/myapp'
                }
            }
        }
    }
}

pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'flutter clean'
                sh 'flutter pub get'
                sh 'flutter build apk --split-per-abi'
            }
        }
        
        stage('Archive APK') {
            steps {
                archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk', fingerprint: true
            }
        }
    }
}

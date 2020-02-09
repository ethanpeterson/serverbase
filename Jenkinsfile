
pipeline {

    agent any

    environment {
        EMAIL_TO = "ethanpeterson@gmail.com"
    }

    stages {
        stage('Test') {
            steps {
                bat 'rubocop .'
                bat 'foodcritic . --context'
                bat 'chef exec rspec spec\\unit\\recipes\\* -fd -c'
            }
        }

        stage('Clean') {
            steps {
                echo 'clean up step...'
            }
        }

        stage('Deploy') {
            when {
                branch 'master'
            } 
            steps {
                echo 'deploy step...'
            }
        }
    }

    post {
        success {
            emailext body: 'Check console output at $BUILD_URL to view the results. \n\n<br /><br /> ${CHANGES} \n\n<br /><br /> -------------------------------------------------- \n<br />${BUILD_LOG, maxLines=100, escapeHtml=false}', 
            to: "${EMAIL_TO}", 
            subject: 'Build Successful in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
        }

        failure { 
            emailext body: 'Check console output at $BUILD_URL to view the results. \n\n<br /><br /> ${CHANGES} \n\n<br /><br /> -------------------------------------------------- \n<br />${BUILD_LOG, maxLines=100, escapeHtml=false}', 
            to: "${EMAIL_TO}", 
            subject: 'Build FAILED in Jenkins: $PROJECT_NAME - #$BUILD_NUMBER'
        }
    }
}
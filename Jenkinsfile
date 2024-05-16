pipeline {
    agent any
    
    triggers {
        cron('H */12 * * *') // Run every 12 hours
    }

    stages {
        stage('Checkout') {
            steps {
                git ''
            }
        }
        
        stage('Run script file') {
            steps {
                script {
                    sh 'sh import_functions.sh'
                    
                }
            }
        }
    }
}
pipeline {
    agent any
    
    triggers {
        cron('H */12 * * *') // Run every 12 hours
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'git@github.com:asingh766/import-function.git', 
            }
        }
        
        stage('Run script file') {
            steps {
                script {
                    sh './import_functions.sh'
                    
                }
            }
        }
    }
}
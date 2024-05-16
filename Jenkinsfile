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
                credentialsId: '83fbf447-1ce8-46e0-a3f2-c85b8626f0ed'
            }
        }
        
        stage('Run script file') {
            steps {
                script {
                    sh 'chmod +x import_functions.sh'
                    sh './import_functions.sh'    
                }
            }
        }
    }
}
pipeline{
    agent {
        node {
            label 'Docker-Host'
        }
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-auth')
    }
    options{
        timeout(time: 1, unit: 'HOURS')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters {
        string(name: 'module' , defaultValue: '', description: 'which module you want to build?')
        string(name: 'version' , defaultValue: '', description: 'what is the version?')
        booleanParam(name: 'Build', defaultValue: false, description: 'Toggle this value')
    }
    stages{
        stage('build image') {
            when{
                expression{
                    params.Build
                }
            }
            steps{
                sh """
                    cd ${params.module}
                    docker build -t ${params.module}:${params.version} .
                """
            }
        }
        stage('docker login'){
            steps{
                sh """
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin 
                """
            }
        }
        stage('Push image'){
            steps{
                sh """
                    docker push ${params.module}:${params.version} rajeshchanti/${params.module}:${params.version}
                """
            }
        }
    }
    post {
        always {
            echo 'job is done'
            deleteDir()
        }
        failure {
            echo 'Build is Failed'
        }
        success {
            echo 'pipeline is successfully build'
        }
    }
}

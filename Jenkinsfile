pipeline{
    // agent {
    //     node {
    //         label 'agent-1'
    //     }
    // }
    agent any
    // environment {
    //     DOCKERHUB_CREDENTIALS = credentials('rajeshchanti')
    // }
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
        stage('build images') {
            when{
                expression{
                    params.Build
                }
            }
            steps{
                sh """
                cd /${params.module}
                docker build -t ${params.module}:${params.version} .
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

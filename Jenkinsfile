def COLOR_MAP = [
    'SUCCES': 'good',
    'FAILURE': 'danger',
]

pipeline {
    agent any

    stages {
        stage('Git checkout') {
            steps {
                echo 'Cloning project codebase...'
                git branch: 'main', url: 'https://github.com/joelwatch/devops-fully-automated-infra.git'
                sh 'ls'
            }
        }

        stage('Verify Terraform Version') {
            steps {
                echo 'verifying the terraform version...'
                sh 'terraform --version'
            }
        }

        stage('Terraform init') {
            steps {
                echo 'Code syntax checking...'
                sh 'sudo terraform init'
            }
        }

        stage('Terraform validate') {
            steps {
                echo 'Code syntax validation...'
                sh 'sudo terraform validate'
            }
        }

        stage('Terraform plan') {
            steps {
                echo 'Terraform plan for the dry run...'
                sh 'sudo terraform plan'
            }
        }

        stage('Checkov scan') {
            steps {

                sh """
                sudo pip3 install checkov
                checkov -d .
                #checkov -d . --skip-check CKV_AWS_23, CKV_AWS_24, CKV_AWS_126,CKV_AWS_135,CKV_AWS_23,CKV_AWS_24
                #checkov -d . --skip-check CKV_AWS*
                """
            }
        }

        stage('Terraform apply') {
            steps {
                echo 'Terraform apply...'
                sh 'sudo terraform apply --auto-approve'
            }
        }


    }

    post {
        always {
            echo 'I will always say Hello again!'
            slackSend channel: '#team-devops', color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} buil ${env.BUILS_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    }
    
}

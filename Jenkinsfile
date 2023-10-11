#install terraform plugin on jenkins 
#manaage jenkins- global tool configuration 
#provide terraform path where it is installed /usr/bin -and version



pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/kavitaghule/terraform2.git'
            }
        }
    stage ("mv file") {
            steps {
               sh 'mv terraform_install.sh Jenkinsfile /opt'
            }
        }
        stage ("terraform init") {
            steps {
                sh ("terraform init") 
            }
        }
        
        stage ("plan") {
            steps {
                sh ('terraform plan') 
            }
        }

        stage (" Action") {
            steps {
                sh "Terraform plan"
                sh ('terraform apply --auto-approve') 
           }
        }
    }
}
  

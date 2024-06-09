@Library('Shared') _
pipeline {
    agent any
    
    environment{
        SONAR_HOME = tool "Sonar"
    }
    stages {
        
        stage("Workspace cleanup"){
            steps{
                script{
                    cleanWs()
                }
            }
        }
        
        stage('Git: Code Checkout') {
            steps {
                script{
                    code_checkout("https://github.com/DevMadhup/wanderlust.git","devops")
                }
            }
        }
        
        stage('Exporting environment variables') {
            parallel{
                stage("Backend env setup"){
                    steps {
                        script{
                            dir("Automations"){
                                sh "bash updateBackend.sh"
                            }
                        }
                    }
                }
                
                stage("Frontend env setup"){
                    steps {
                        script{
                            dir("Automations"){
                                sh "bash updateFrontend.sh"
                            }
                        }
                    }
                }
            }
        }
        
        stage("OWASP: Dependency check"){
            steps{
                script{
                    owasp_dependency()
                }
            }
            post{
                success{
                    archiveArtifacts artifacts: '**/dependency-check-report.xml', followSymlinks: false, onlyIfSuccessful: true
                }
            }
        }
        
        stage("SonarQube: Code Analysis"){
            steps{
                script{
                    sonarqube_analysis("Sonar","wanderlust","wanderlust")
                }
            }
        }
    }
}

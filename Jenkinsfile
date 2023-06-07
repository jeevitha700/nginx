pipeline {
    agent any

    stages{
        stage( 'build'){
            steps{
                sh 'docker build -t my_nignx .'
                sh 'docker tag my_nignx $DOCKER_IMAGE'
            }
        }
        stage( 'test'){
            steps{
                sh 'docker run --name my_nignxcontainer -d -p 7000:80 my_nignx'

            }
        }
        stage('deploy'){
            steps{
                 withCredentials([usernamePassword(credentialsId: "${DOCKER_REGISTRY_CREDS}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                  sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin docker.io"
                   sh 'docker push $DOCKER_IMAGE'
              }
            }          
        }
        stage('email notification'){
            steps{
                 mail bcc: '', body: '''
$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:

Check console output at $BUILD_URL to view the results.''', cc: '', from: '', replyTo: '', subject: '\'Declarative Pipeline Build Status\'', to: 'jeevithals700@gmail.com'
            }
           
        }
    }
    post {
        always{
            sh 'docker logout'
        }
    }
  }



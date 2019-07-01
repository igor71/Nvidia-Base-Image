pipeline {
  agent {label 'yi-tensorflow'}
    stages {
        stage('Build NVIDIA Basic Docker Image') {
            steps {
	       sh 'docker build --no-cache -f Dockerfile -t nvidia/cuda:9.0-cudnn7-base-horovod .'  
            }
        }
	stage('Testing Docker Image') { 
            steps {
                sh '''#!/bin/bash -xe
		    echo 'Hello, Horovod-Basic!!'
                    image_id="$(docker images -q nvidia/cuda:9.0-cudnn7-base-horovod)"
                      if [[ "$(docker images -q nvidia/cuda:9.0-cudnn7-base-horovod 2> /dev/null)" == "$image_id" ]]; then
                          docker inspect --format='{{range $p, $conf := .RootFS.Layers}} {{$p}} {{end}}' $image_id
                      else
                          echo "It appears that current docker image corrapted!!!"
                          exit 1
                      fi 
                   ''' 
            }
        }
	stage('Save & Load Docker Image') { 
            steps {
                sh '''#!/bin/bash -xe
		     echo 'Saving Docker image into tar archive'
                     docker save nvidia/cuda:9.0-cudnn7-base-horovod | pv -f | cat > $WORKSPACE/nvidia-cuda-9.0-cudnn7-base-horovod.tar
		     echo 'Removing Original Docker Image' 
	             CURRENT_ID=$(docker images | grep -E '^nvidia/cuda:9.0-cudnn7-base-horovod' | awk -e '{print $3}')
	             docker rmi -f $CURRENT_ID
			
                     echo 'Loading Docker Image'
                     pv -f $WORKSPACE/nvidia-cuda-9.0-cudnn7-base-horovod.tar | docker load
	             docker tag $CURRENT_ID nvidia/cuda:9.0-cudnn7-base-horovod
                        
                     echo 'Removing temp archive.'  
                     rm $WORKSPACE/nvidia-cuda-9.0-cudnn7-base-horovod.tar
                   ''' 
		    }
		}
 }
	post {
            always {
               script {
                  if (currentBuild.result == null) {
                     currentBuild.result = 'SUCCESS' 
                  }
               }
               step([$class: 'Mailer',
                     notifyEveryUnstableBuild: true,
                     recipients: "igor.rabkin@xiaoyi.com",
                     sendToIndividuals: true])
            }
         } 
}

pipeline{
    agent any 
    environment{
        image_name="sahild42770/php-mysql-image"
    }
    stages{
        stage("pull code form github")
        {
            steps{
                git branch:'main',url:'https://github.com/SahilDhiman8072/php-mysql-jenkins-project.git'
            }
        }
        stage("build php image"){
            steps{
                sh 'docker build -t $image_name:$BUILD_NUMBER .'
            }
            post{
                success{
                   sh 'docker images'
                }
            }
        }
        stage("dockerhub login"){
            steps{
                withCredentials([
                    usernamePassword(
                        credentialsId:'dockerhub-up',
                        usernameVariable:'docker_user',
                        passwordVariable:'docker_pass'
                    )
                ]){
                    sh 'echo "$docker_pass" | docker login -u "$docker_user" --password-stdin'
                }
            }
        }
        stage("push to dockerhub"){
            steps{
                sh 'sudo -u jenkins docker push $image_name:$BUILD_NUMBER'
            }
        }
        stage("mysql container run"){
            steps{
                sh 'docker rm -f mysql || true'
                sh 'docker run -d --name mysql -p 3306:3306 --network mynet -e MYSQL_ROOT_PASSWORD=123 -e MYSQL_DATABASE=carrental mysql'
            }
            post{
                success{
                    sh 'docker exec -i mysql mysql -uroot -p123 carrental < carrental.sql'
                }
            }
        }
        
        stage("php container run"){
            steps{
                sh 'docker rm -f php-cont || true'
                sh 'docekr run -d --name php-cont --network mynet -p 80:80 $image_name:$BUILD_NUMBER'
            }
            post{
                success{
                    sh 'docker ps'
                }
            }
        }
    }
}
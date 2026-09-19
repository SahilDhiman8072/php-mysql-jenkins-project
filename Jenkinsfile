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
                sh 'docker compose build'
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
                sh 'docker tag $image_name:latest $image_name:$BUILD_NUMBER'
                sh 'docker push $image_name:$BUILD_NUMBER'
            }
        }
        stage("mysql and php container run"){
            steps{
                sh '''
                docker compose down || true
                docker compose up -d 
                '''
            }
            post{
                success{
                    echo "verify containers"
                    sh 'docker compose ps'
                }
            }
        }
        stage("import mysqlfile to mysql container"){
            steps{
                sh '''
                until docker exec mysql mysqladmin -uroot -p123 ping --silent
                do
                    echo "mysql not ready yet"
                    sleep(3)
                done
                echo "mysql ready"
                '''
            }
            post{
                success{
                    sh 'docker exec -i mysql mysql -uroot -p123 carrental < carrental.sql'
                }
            }
        }
    }
}
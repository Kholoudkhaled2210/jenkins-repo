pipeline {
    agent any

    environment {
        // اسم الصورة التي ستظهر في Docker Hub
        APP_NAME = 'jenkins-repo' 
        // رابط المستودع الخاص بكِ بعد تعديله لاسمك
        REPO_URL = "https://github.com/Kholoudkhaled2210/jenkins-repo.git"
        // اسم مستخدم Docker Hub الخاص بكِ
        DOCKERHUB_USER = 'Kholoudkhaled2210' 
        IMAGE_NAME = "${DOCKERHUB_USER}/${APP_NAME}"
    }

    stages {
        stage('Checkout') {
            steps {
                // سحب الملفات من فرع dev الخاص بكِ [cite: 4]
                git branch: 'dev', 
                    url: "${REPO_URL}", 
                    credentialsId: 'github'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // بناء الصورة باستخدام Dockerfile الموجود في المشروع [cite: 1, 6]
                    sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
               
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "docker login -u $USER -p $PASS"
                    sh "docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                }
            }
        }

        stage('Run Container') {
            steps {
               
                sh "docker run -d -p 5000:5000 --name ${APP_NAME}-dev-${BUILD_NUMBER} ${IMAGE_NAME}:${BUILD_NUMBER}"
            }
        }
    }

    post {
        success {
            echo ' التطبيق اشتغل تمام وتم الرفع على Docker Hub!'
        }
        failure {
            echo '❌ حصلت مشكلة، راجعي الـ Logs في جينكنز'
        }
    }
}

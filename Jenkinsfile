pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Código obtenido desde GitHub'
            }
        }

        stage('Environment') {
            steps {
                sh '''
                    python3 --version
                    python3 -m venv .venv
                    .venv/bin/python -m pip install --upgrade pip
                    .venv/bin/pip install -r requirements.txt
                '''
            }
        }

        stage('Lint') {
            steps {
                sh '''
                    .venv/bin/ruff check .
                '''
            }
        }

        stage('Tests') {
            steps {
                sh '''
                    .venv/bin/pytest
                '''
            }
        }
    }

    post {

        success {
            echo 'CI finalizado correctamente'
        }

        failure {
            echo 'CI ERROR: revisar los logs del pipeline'
        }

        always {
            echo 'Pipeline finalizado'
        }
    }
}

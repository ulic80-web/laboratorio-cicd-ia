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

        stage('Quality Gate') {
            steps {
                echo 'Quality Gate superado'
                echo 'Ruff y Pytest han finalizado correctamente'
            }
        }
    }

    post {
        success {
            echo 'CI finalizado correctamente'
        }

        failure {
            echo 'CI FALLIDO - revisar errores'
        }

        always {
            echo 'Pipeline finalizado'
        }
    }
}

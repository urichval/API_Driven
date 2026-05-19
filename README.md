# API-Driven Infrastructure

## Description
Architecture API-driven dans laquelle une requête HTTP déclenche, via API Gateway et une fonction Lambda, le lancement ou l'arrêt d'une instance EC2 dans un environnement AWS simulé avec LocalStack.

## Architecture
HTTP Request → API Gateway → Lambda → EC2 (LocalStack)

## Prérequis
- GitHub Codespaces
- Compte LocalStack (https://app.localstack.cloud)

## Installation

### 1. Installer les dépendances
pip install localstack awscli-local awscli boto3

### 2. Démarrer LocalStack
localstack start -d

### 3. Déployer l'infrastructure
Créer l'instance EC2, la fonction Lambda et l'API Gateway via awslocal

## Utilisation

### Vérifier le statut
curl -X POST "http://localhost:4566/restapis/kuygamsnbd/prod/_user_request_/ec2" -H "Content-Type: application/json" -d '{"action": "status"}'

### Stopper l'instance
curl -X POST "http://localhost:4566/restapis/kuygamsnbd/prod/_user_request_/ec2" -H "Content-Type: application/json" -d '{"action": "stop"}'

### Démarrer l'instance
curl -X POST "http://localhost:4566/restapis/kuygamsnbd/prod/_user_request_/ec2" -H "Content-Type: application/json" -d '{"action": "start"}'

## Auteur
Urich TAMO
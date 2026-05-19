.PHONY: install start deploy test-status test-stop test-start clean

install:
	pip install localstack awscli-local awscli boto3

start:
	localstack start -d
	@echo "LocalStack démarré ✅"

deploy:
	@echo "Création de l'instance EC2..."
	awslocal ec2 run-instances --image-id ami-07b643b5e45e --instance-type t2.micro --count 1
	@echo "Déploiement de la fonction Lambda..."
	zip lambda_function.zip lambda_function.py
	awslocal lambda create-function \
		--function-name ec2-controller \
		--runtime python3.12 \
		--handler lambda_function.handler \
		--role arn:aws:iam::000000000000:role/lambda-role \
		--zip-file fileb://lambda_function.zip
	@echo "Création de l'API Gateway..."
	awslocal apigateway create-rest-api --name ec2-api
	@echo "Déploiement terminé ✅"

test-status:
	curl -X POST "http://localhost:4566/restapis/kuygamsnbd/prod/_user_request_/ec2" \
		-H "Content-Type: application/json" \
		-d '{"action": "status"}'

test-stop:
	curl -X POST "http://localhost:4566/restapis/kuygamsnbd/prod/_user_request_/ec2" \
		-H "Content-Type: application/json" \
		-d '{"action": "stop"}'

test-start:
	curl -X POST "http://localhost:4566/restapis/kuygamsnbd/prod/_user_request_/ec2" \
		-H "Content-Type: application/json" \
		-d '{"action": "start"}'

clean:
	rm -f lambda_function.zip
	localstack stop
import boto3
import json

def handler(event, context):
    ec2 = boto3.client(
        'ec2',
        endpoint_url='http://localhost.localstack.cloud:4566',
        region_name='us-east-1',
        aws_access_key_id='test',
        aws_secret_access_key='test'
    )
    instance_id = 'i-d0534c3a5e8eaa802'
    body = json.loads(event.get('body', '{}'))
    action = body.get('action', 'status')
    if action == 'start':
        ec2.start_instances(InstanceIds=[instance_id])
        return {'statusCode': 200, 'body': json.dumps('Instance demarree !')}
    elif action == 'stop':
        ec2.stop_instances(InstanceIds=[instance_id])
        return {'statusCode': 200, 'body': json.dumps('Instance stoppee !')}
    else:
        response = ec2.describe_instances(InstanceIds=[instance_id])
        state = response['Reservations'][0]['Instances'][0]['State']['Name']
        return {'statusCode': 200, 'body': json.dumps(f'Etat : {state}')}

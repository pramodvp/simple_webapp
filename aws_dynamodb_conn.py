import boto3
import os

dynamo_client = boto3.client('dynamodb', region_name='us-east-1')

def get_items():
    return dynamo_client.scan(
        TableName=os.getenv("TABLE_NAME")
    )
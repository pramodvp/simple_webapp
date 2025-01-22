import boto3
import os

region = os.getenv("AWS_REGION")

def get_items():
    dynamo_client = boto3.client("dynamodb", region_name=region)
    return dynamo_client.scan(TableName=os.getenv("TABLE_NAME"))

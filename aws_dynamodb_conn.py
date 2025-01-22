import boto3
import os

region = os.getenv("AWS_REGION")

dynamo_client = boto3.client("dynamodb", region_name=region)


def get_items():
    return dynamo_client.scan(TableName=os.getenv("TABLE_NAME"))

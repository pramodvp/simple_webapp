Create table cmd output:

[root@ip-10-0-157-38 simple-web-app]# ./create_dynamo_table.sh 
{
    "TableDescription": {
        "AttributeDefinitions": [
            {
                "AttributeName": "ProjectName",
                "AttributeType": "S"
            },
            {
                "AttributeName": "URL",
                "AttributeType": "S"
            }
        ],
        "TableName": "simple-web-app",
        "KeySchema": [
            {
                "AttributeName": "ProjectName",
                "KeyType": "HASH"
            },
            {
                "AttributeName": "URL",
                "KeyType": "RANGE"
            }
        ],
        "TableStatus": "CREATING",
        "CreationDateTime": "2024-12-17T20:22:09.481000+00:00",
        "ProvisionedThroughput": {
            "NumberOfDecreasesToday": 0,
            "ReadCapacityUnits": 5,
            "WriteCapacityUnits": 5
        },
        "TableSizeBytes": 0,
        "ItemCount": 0,
        "TableArn": "arn:aws:dynamodb:us-east-1:043309347563:table/simple-web-app",
        "TableId": "d678c7e9-4a9b-4ddd-aff0-bdf1739d8e31",
        "DeletionProtectionEnabled": false
    }
}


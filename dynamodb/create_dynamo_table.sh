#  Create dynamo table using the details from the create-tab;e.json file in the cyrrenrt directory.
aws dynamodb create-table --cli-input-json file://create-table.json 

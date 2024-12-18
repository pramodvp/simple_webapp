# From the current directory, load data from the db_data.json 
aws dynamodb batch-write-item --request-items file://db_data.json

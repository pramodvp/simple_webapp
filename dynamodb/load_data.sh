# From the current directory, load data from the db_data.json 
DIR=$(dirname $0)
cd ${DIR}
aws dynamodb batch-write-item --request-items file://db_data.json

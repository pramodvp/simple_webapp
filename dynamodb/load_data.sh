# From the current directory, load data from the db_data.json 
DIR=$(dirname $0)
cd ${DIR}
DATE=$( date )
INPUT=${1:-NONE}
DATA_FILE="db_data.json"

if [ ${INPUT} = "BOOT" ] ; then 
    TEXT="Record added automatically at startup"
else 
    TEXT="Record added manually via load_data.sh"
fi 

data()
{
    echo "
    {
        \"simple-web-app\": [
        {
            \"PutRequest\": {
            \"Item\":
            {
                \"Timestamp\": {
                \"S\": \"${DATE}\"
                },
                \"Comment\": {
                \"S\": \"${TEXT}\"
                }
            }
            }
        }
        ]
    }
    " > ${DATA_FILE}
}

data 
aws dynamodb batch-write-item --request-items file://${DATA_FILE}

# From the current directory, load data from the db_data.json 
DIR=$(dirname $0)
cd ${DIR}
DATE=$( date )
INPUT=${1:-NONE}
AWS_REGION=$( aws configure list | grep region | awk '{print $2}' )
SDATE=$(date "+%Y%m%d")
DATA_FILE="${SDATE}_db_data.json"
HOSTNAME=$( hostname )

case ${INPUT} in 
    INSTALL) TEXT="Record added automatically during app install by ${HOSTNAME}"
        ;;
    BOOT) TEXT="Record added automatically at startup by ${HOSTNAME}"
        ;;
    *) TEXT="Record added manually via load_data.sh"
        ;;
esac 

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
aws dynamodb batch-write-item --request-items --region=${AWS_REGION} file://${DATA_FILE}

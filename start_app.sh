#!/bin/bash -ex
#
DIR=$( dirname $0)
source ${DIR}/config
#
source ${DIR}/${VENV_NAME}/bin/activate

${DIR}/dynamodb/load_data.sh BOOT

# Run the application 
python ${DIR}/app.py

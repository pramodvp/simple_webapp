#!/bin/bash -ex
#
DIR=$( dirname $0)
source ${DIR}/config
#
source ${DIR}/${VENV_NAME}/bin/activate

/home/${APP_USER}/simple_webapp/dynamodb/load_data.sh

# Run the application 
python ${DIR}/app.py

#!/bin/bash -ex
# Creae a python virtual environment to run the application 
DIR=$( dirname $0) 
source ${DIR}/config
python -m venv ${DIR}/${VENV_NAME}

# Activate the virtual environment 
source ${DIR}/${VENV_NAME}/bin/activate

# Install required python packages
pip install -r ${DIR}/requirements.txt

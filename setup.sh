#!/bin/bash -ex
# Creae a python virtual environment to run the application 
DIR=$( dirname $0) 
source ${DIR}/config
python3 -m venv ${DIR}/${VENV_NAME}
yum install python3-pip

# Activate the virtual environment 
source ${DIR}/${VENV_NAME}/bin/activate

# Install required python packages
pip install -r ${DIR}/requirements.txt

# Run the application 
python ${DIR}/app.py

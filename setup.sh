#!/bin/bash -e
# Creae a python virtual environment to run the application 

source config
python -m venv ${VENV_NAME}
# Activate the virtual environment 
source ./${VENV_NAME}/bin/activate
# Install required python packages
pip install -r requirements.txt



# Run the application 
flask run -h ${HOST} -p ${PORT}

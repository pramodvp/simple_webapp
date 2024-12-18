#!/bin/bash -e
#
source config
#
# Run the application 
flask run -h ${HOST} -p ${PORT}

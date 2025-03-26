#!/bin/bash
#
export PATH=$PATH:/bin:/usr/bin:/usr/local/bin:
APP_USER='webapp'
#
# Install AWS SSM
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent
#
# Install httpd
yum install httpd -y 
systemctl start httpd
#
HOSTNAME+$( hostname )
echo "<html><body><h1>Hello from Apache Web Server (HTTPD) running on ${HOSTNAME}!</h1></body></html>" > /var/www/html/index.html 
chmod 444 /var/www/html/index.html 
#
# Install git and python 
yum install git -y
yum install python -y
#
# Create Appplication user
useradd ${APP_USER} 
#
# Clone simple-webapp project
su - ${APP_USER} -c 'git clone https://github.com/pramodvp/simple_webapp.git'
#
APP_USER_HOME="/home/${APP_USER}"
chmod 755 ${APP_USER_HOME}/simple_webapp/*sh
chmod 755 ${APP_USER_HOME}/simple_webapp/dynamodb/*sh
TOKEN=$( curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
AWS_REGION=$(curl http://169.254.169.254/latest/meta-data/placement/region -H "X-aws-ec2-metadata-token: $TOKEN") 
echo "export AWS_REGION=${AWS_REGION}" >> ${APP_USER_HOME}/config

# Load data to DynamoDB table: 
#su - ${APP_USER} -c "bash ~${APP_USER}/simple_webapp/dynamodb/load_data.sh"
bash ${APP_USER_HOME}/simple_webapp/dynamodb/load_data.sh INSTALL
#
#Setup web app 
su - ${APP_USER} -c "bash ${APP_USER_HOME}/simple_webapp/setup.sh" 

# App startup
WEB_APP_START_SCRIPT="${APP_USER_HOME}/simple_webapp/start_app.sh"
WEB_APP_SERVICE_NAME="CFSBootCamp-web-app"
WEB_APP_SERVICE_PATH="/etc/systemd/system/${WEB_APP_SERVICE_NAME}.service"
WORKING_DIR="${APP_USER_HOME}/simple_webapp"

create_web_app_service() {
echo "[Unit]
Description=Web Application for BootCamp phase-2
After=network.target

[Service]
ExecStart=${WEB_APP_START_SCRIPT}
WorkingDirectory=${WORKING_DIR}
Restart=no
User=${APP_USER}
TimeoutStartSec=60
RestartSec=5

[Install]
WantedBy=multi-user.target
" > ${WEB_APP_SERVICE_PATH}
}

setup_services() {
    sudo systemctl daemon-reload
    sudo systemctl enable "${WEB_APP_SERVICE_NAME}"
    sudo systemctl start "${WEB_APP_SERVICE_NAME}"
    sudo systemctl enable httpd 
    sudo systemctl start httpd 
    
}

create_web_app_service
setup_services

#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "script stareted executing at $TIMESTAMP" &>> $LOGFILE

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILED $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

if [ $ID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $N"
    exit 1
else
    echo "You are root user"
fi

yum install -y yum-utils &>> $LOGFILE

VALIDATE $? "Installed yum utils"

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &>> $LOGFILE

VALIDATE $? "Added docker repo"

yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y &>> $LOGFILE

VALIDATE $? "Installed docker components"

systemctl start docker &>> $LOGFILE

VALIDATE $? "Started docker"

systemctl enable docker &>> $LOGFILE

VALIDATE $? "Enabled docker"

usermod -aG docker centos &>> $LOGFILE

VALIDATE $? "added centos user to docker group"

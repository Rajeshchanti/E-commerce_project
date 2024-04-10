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

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
VALIDATE $? "Dowloading jenkins repo"

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
VALIDATE $? "Importing Key"

sudo yum install fontconfig java-17-openjdk -y
VALIDATE $? "Installing Java"

sudo yum install jenkins -y
VALIDATE $? "Installing jenkins"

sudo systemctl start jenkins
VALIDATE $? "Starting Jenkins"

sudo systemctl enable jenkins
VALIDATE $? "Enable Jenkins"
Deploy your code on a Docker Container using Jenkins on AWS

# Agenda :
* Build Docker images and pushing it to Docker Hub.
  * Launch EC2 Instance (Jenkins server).
  * Launch EC2 Instance for Node (Docker-Host).
  * Install Docker in Node.
  * setup jenkins in Jenkins server and create a Node.
  * write a Jenkins file to build and pushing Images to     DockerHub.

## Lauch EC2 Instance
* Log in to Amazon management Console , open EC2 Dashboard and Launch a Instance by giving the required details as shown below:

    * Click on Launch Instance.
    * Enter the instance **Name**.
    * Choose the AMI ( Amazon Machine Image) as per your convenience.
    * Choose Instance Type.
    * Give Key Pair.
    * Select security group.
    * Click on Launch instance.

![alt text](images/image-1.png)

* Launch a EC2 Instance, let's it be a worker node.

![alt text](images/image-17.png)
* Log in to the EC2 Instance (Node) and create a directory as shown below.

![alt text](images/image-18.png)

* Install java on worker node ( otherwise jenkins doesn't run on worker node ) by using below command:
```python
 sudo yum install fontconfig java-17-openjdk -y
```
![alt text](images/image-19.png)

Finally we got an instance as shown above and now Log in to the instance.

## Setup Docker on Node

* Run the install_docker.sh script to install the docker in Node( Docker-Host).

```python
sudo sh install_docker.sh
```
![alt text](images/image-20.png)

## Setup Jenkins Server on AWS EC2 Instance

* After logging in to EC2(Jenkins) machine install jenkins through below commands or for more info you can visit the official jenkins website: https://pkg.jenkins.io/redhat-stable/

```python
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
```
![alt text](images/image-2.png)

```python
sudo yum install fontconfig java-17-openjdk -y
```

![alt text](images/image-3.png)

```python
sudo yum install jenkins -y
```
![alt text](images/image-4.png)

Jenkins installed successfully. Now we need to start and enable the jenkins using below commands.
```python
sudo systemctl start jenkins

sudo systemctl enable jenkins

sudo systemctl status jenkins
```
![alt text](images/image-5.png)

* Now let’s try to access the Jenkins server through our browser. For that take the public IP of your EC2 instance and Jenkins runs on 8080 port number, so you need to paste it into your favorite browser like Public IP:Jenkins Port number (EX: 18.209.30.255:8080) then you can see the Jenkins UI as shown below:

![alt text](images/image-6.png)

* To get the access to the Jenkins for that we need to go the path /var/lib/jenkins/secrets/initialAdminPassword and fetch the Administrator password.
* Get that admin Password and unlock jenkins.

![alt text](images/image-7.png)

* Click on Install Suggested plugins:

![alt text](images/image-8.png)

* Now we can create our first Admin user, provide all the required data and proceed to save and continue.

![alt text](images/image-9.png)

* Click on save and Finish.

![alt text](images/image-10.png)

* Now Jenkins Server is ready to use.

![alt text](images/image-11.png)

## Create a Node in Jenkins
* Go to **Dashboar**d --> **Manage jenkins** --> **Node**

![alt text](images/image-12.png)
* Click on **New Node**

![alt text](images/image-13.png)
* Enter Node name and click on **create**

![alt text](images/image-14.png)

* Fill the required as shown below:
  * Root dir: Give root dir ( which we created in worker node ).
  * Lables: you can give any name.
  * Launch method: choose launch agents via SSH.
  * Host: Private IP of EC2 Instance (worker node).
  * Credentials: add your instance credentials and click on save.
  
![alt text](images/image-15.png)
* Now you can see the Node (Docker-Host) as shown below.
* Click on created Node and check the log whether it is connected to jenkins server or not.

![alt text](images/image-16.png)

* Let's create a pipeline --> switch to the Jenkins UI and in Dashboard click on **New Item**

![alt text](images/image-21.png)

* Enter name --> click on **pipeline** --> click **OK**

![alt text](images/image-22.png)

* Enter the pipeline details such as defination, SCM and git repository URL as shown below and **Click on apply & save**.

![alt text](images/image-23.png)

* To add Docker credentials, go to **Dashborad** --> **Manage Jenkins** --> **Credentials**

![alt text](images/image24.png)

* Click on **System**

![alt text](images/image-25.png)

* Click on **Global Credentials**

![alt text](images/image-26.png)

* **Add Credentials**

![alt text](images/image-27.png)

* Enter the required details:
  * Scope: choose the scope from the dropdown as per your requirement.
  * Username: Enter the Docker Hub Username.
  * Password: Enter the Docker Hub Password.
  * ID: Give any name it's your choice (we should give this Id in Jenkinsfile)
  * Click on **Create**

![alt text](images/image-28.png)
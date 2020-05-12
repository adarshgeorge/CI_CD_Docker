# Hello Docker!

A DevOps Project to display Hello World! when browse hostname or IP. 
- a default **Hello world!** message

![alt HelloWorld](https://github.com/adarshgeorge/CI_CD_Docker/blob/master/png/Hello_World.png)


## Pre-Request
- Docker Server
- Jenkins Server

Now setup a Docker server and use the below userdata for launching the Server.

```
#!/bin/bash
sudo yum install docker -y
sudo service docker restart
sudo chkconfig docker on
sudo usermod -a -G docker ec2-user
```

Setup Jenkins Server and use below userdata while launch an EC2 instance.
```
#!/bin/bash
sudo yum update -y
sudo yum install java-1.8.0-openjdk-devel -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo usermod -a -G jenkins ec2-user
```

Login to Jenkins Server and Obtain Admin Password.

```
$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Access the Jenkins Dashboard (IP:8080) and install the suggested plugin. Also make sure the below plugins are installed on Jenkins. 

( Dashboard > Managed Plugins > Installed Plugin )


* Publish Over SSH
* Github

After that we need to configure SSH over Docker Server.  


( Dashboard > Managed Plugins > Configure System >  Publish over SSH  )


Enter the server IP, username and password and do test connections.

```
User: ec2-user
Pass: ec2-passwd
Host: Private IP.
```
![alt Test](https://github.com/adarshgeorge/CI_CD_Docker/blob/master/png/Docker.png)
Once test connection is success!

**Now create a new Job**   


( Dashboard > New Item > Mentioned the projectname > Select Freestyle project )


*Configuring...*


In Source Code Management


Select Git  and add git repository


https://github.com/adarshgeorge/CI_CD_Docker.git




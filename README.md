# Hello Docker!

A DevOps Project to display Hello World! when browse hostname or IP. 
- a default **Hello world!** message

.![alt HelloWorld](https://github.com/adarshgeorge/CI_CD_Docker/blob/master/web/Hello_World.png)



## Pre-Request
- Docker Server
- Jenkins Server

Userdata for Jenkins Server
```
#!/bin/bash
sudo yum update -y
sudo yum install java-1.8.0-openjdk-devel -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

Login to Jenkins Server and Obtain Admin Password.

```
$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Access the Jenkins Dashboard (IP:8080)

Install the suggested plugin.Also verify the below plugins are installed on Jenkins. 

( Dashboard > Managed Plugins > Installed Plugin )


* Publish Over SSH
* Github
* 

After that we need to configure SSH over Docker Server.  


( Dashboard > Managed Plugins > Configure System >  Publish over SSH  )


Enter the server IP, username and password and do test connections.

```
User: ec2-user
Pass: ec2-passwd
Host: Private IP.
```

Once test connection is success!

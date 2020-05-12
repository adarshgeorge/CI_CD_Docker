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
sudo yum update -y
sudo yum install docker -y
sudo service docker restart
sudo chkconfig docker on
sudo usermod -a -G docker ec2-user
sudo yum install git -y
```

Setup Jenkins Server and use below userdata while launch an EC2 instance.
```
#!/bin/bash
sudo yum update -y
sudo yum install git -y
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

In Build

Select **Send files or execute commands over SSH**

```
cd /home/ec2-user/DevOps/
rm -rf *
git clone https://github.com/adarshgeorge/CI_CD_Docker.git 
```

Once above build is success another build to create new container and expose the port. (Click on "Transferset") 

```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -a -q)
cd /home/ec2-user/DevOps/CI_CD_Docker/
docker build -t dockerweb .
docker run -d -p 80:80 --name webserver dockerweb
```

Deploy a the Project! 

(Dashboard > DevOps_Project_CI_CD > Build Now)

![alt Test](https://github.com/adarshgeorge/CI_CD_Docker/blob/master/png/build.png)

**Browse -->**  IP:8080 

![alt Test](https://github.com/adarshgeorge/CI_CD_Docker/blob/master/png/outtput.png)


**Now we need to make it as Continues Integration and Continous Deployment when there is change in Github repository**

(Dashboard > DevOps_Project_CI_CD > Configure)

Now enable POL SCM and add below entry. Which means Jenkins check every

```
H/2 * * * *
```

Modifying the index page

```
$ git status

On branch master
Your branch is up to date with 'orgin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   web/index.html

no changes added to commit (use "git add" and/or "git commit -a")


$ git add .

warning: LF will be replaced by CRLF in web/index.html.
The file will have its original line endings in your working directory


$ git commit -m"Added logo"

[master 621f53a] Added logo
 1 file changed, 2 insertions(+), 2 deletions(-)


$ git push
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 427 bytes | 427.00 KiB/s, done.
Total 4 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/adarshgeorge/CI_CD_Docker.git
   f35a7fc..621f53a  master -> master

$

```

Jenkins triggered the changes

![alt Test](https://github.com/adarshgeorge/CI_CD_Docker/blob/master/png/cicd.png)


**Browse -->**  IP:8080 

![alt Test](https://github.com/adarshgeorge/CI_CD_Docker/blob/master/png/finalout.png)

**That's it!**
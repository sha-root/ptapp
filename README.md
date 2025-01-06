# Deploy 1 endpoint api (ptapp)
## Run project localy 

Clone git repository

```sh
git clone https://github.com/sha-root/ptapp.git
cd ptapp
```

Copy .env file with local environment variables

```sh
cp .env.local .env
```

Build docker image, run migrations and start app:
```sh
docker-compose build
docker-compose run --rm migrate
docker-compose up -V -d
```

Check if API available locally on [http://127.0.0.1:8000/api/current-time/](http://127.0.0.1:8000/api/current-time/)

Next times you can re-build  and re-deploy locally with one next command:
```sh
docker-compose up -V --build --force-recreate -d
```

## Deploy project with Jenkins CI/CD

### Configure VPS  for deploying

Install docker

```sh
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Create jenkins user with docker group

```sh
sudo useradd -m  -s /bin/bash  jenkins
sudo usermod -G docker jenkins
```

Create ssh key for  connecting from jenkins server

```sh
sudo su - jenkins
sudo ssh-keygen  -t rsa 
#(Press “Enter” three times to generate key with empty passphrase)

cp /home/jenkins/.ssh/id_rsa.pub /home/jenkins/.ssh/authorized_keys && chmod 600 /home/jenkins/.ssh/authorized_keys
# Download ssh private key /home/jenkins/.ssh/id_rsa  (“scp” command can be used)
```

### Configure Jenkins via UI

> [!NOTE]
> Your jenkins Agent must has "docker compose" installed and it must has one of these labels: 'dev4 || docker || docker-compose'

Add new secrets in Jenkins Credentials 

1. > ptdev-ssh-pkey.
   
   > Manage Jenkins -> Credentials -> Global credentials (unrestricted) -> Add Credential
   
   > Choose Kind="Secret file" and choose the downloaded "id_rsa" ssh private key file.
   
   > Set ID="ptdev-ssh-pkey", leave Description empty and press "Create".

4. > ptdev-vps-ip.
   
   > Manage Jenkins -> Credentials -> Global credentials (unrestricted) -> Add Credential

   > Choose Kind="Secret text" and insert VPS server IP into  "Secret" field.

   > Set ID="ptdev-vps-ip", leave Description empty and press "Create".


Create New Jenkins Pipeline Job


> Dashboard -> +New Item

> Enter an item name = “ptdev-deploy”, choose “Pipeline”  and press “OK”.
 
> Go to “Pipeline” section and set Definition=”Pipeline script from SCM”  

> Next field “SCM” choose “Git” and set Repository URL=https://github.com/sha-root/ptapp.git

> “Branch Specifier” = “*/main”

> “Script Path” = “Jenkinsfile”


Press “Save”


Try to run your created “Pipeline Job”  press “Build Now” 

The END (hope, the build was success:) ).

## [DEPLOY MONITORING SERVICES](https://github.com/sha-root/ptapp/blob/main/monitoring/readme.md)


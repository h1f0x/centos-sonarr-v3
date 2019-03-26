# CentOS 7 - Sonarr v3
Docker container for Sonarr v3.

It is based on the latest CentOS docker image:
- https://hub.docker.com/_/centos

## What does this image?
The container will serve you the latest Sonarr v3 build.

![FloodUI](https://github.com/h1f0x/centos-sonarr-v3/blob/master/images/1.png?raw=true) 

## Install instructions

### Docker volumes
The following volumes will get mounted:

- /path/to/config:/config
- /path/to/media:/media

> Note: Please add all your different media pathes as u wish. Sonarr comes in plain default configuration.

### Deploy the docker container
To get the docker up and running execute fhe following command:

```
sudo docker run -it --privileged --name centos-sonarr-v3 -v /path/to/config:/config -v /path/to/media:/media -d -p 8000:8989 h1f0x/centos-sonarr-v3
```
> If not done already, deploy or modify the OpenVPN client.conf at /path/to/config/vpn

```
docker restart rtorrent-rutorrent-openvpn
```

## Configuration files

Several configuration files will be deployed to the mounted /config folder:

| Folder | Description |
| :--- | :--- |
| sonarr/* | All sonarr config files and dbs |

## Additional configuration guidelines

Please visit: https://sonarr.tv/ for more information.

## Enjoy!

Open the browser and go to:

> http://localhost:8000

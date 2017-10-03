
/!\ this repo is still in draft


We always try to ease the installation. We provide several docker images for you to run Gisgraphy easily. All this stuff is given "as is" and with any waranty of any kind. This repository doesn't images. images are availables on Dockerhub at https://hub.docker.com/r/gisgraphy/gisgraphyofficial/

* [Install Docker](#Install-Docker)
* [Images](#Images)
* [Volumes](#Volumes)
* [Premium](#premium)

# Install Docker

Even if it is out of the scope of Gisgraphy, we provide a script (install-docker.sh) that we use. It is designed to install docker on Ubuntu 16.04 (with Systemd).

# Images
## build
We provide two images :
* gisgraphyenv : which have Java and Postgres / postgis installed and the Gisgraphy Database created. This images is to be used as a "base" image if you want to install Gisgraphy by you own (in other directory, with specific options,...whatever). 
* gisgraphysql : based on gisgraphyenv, it install Gisgraphy (in /usr/local) and setup the database (create the tables in the database, insert gisgraphy users, create indexes). it also create an entrypoint that start Postgres and Gisgraphy servers.

An oficial image of gisgraphysql can be found at https://hub.docker.com/r/gisgraphy/gisgraphyofficial/

for both images, you can personalize the Postgres password by specifying an arg :
```
docker build -t gisgraphyenv --build-arg PGPASSWORD=mdppostgres .
```
A script build.sh is provided to build the images

## run
To run your image in a container
```
docker run -td   gisgraphysql bash
```
A script run.sh is provided to ease things

To run your container and open a shell in it : 
```
docker run -td   gisgraphysql bash
```

docker images=>DOCKERID
docker exec -t -i DOCKERID /bin/bash

A script connect.sh take a docker container id as parameter and open a shell in it.

for gisgraphysql you can personnalize the host at runtime :

docker run -td  -P --hostname=docker.gisgraphy.com  gisgraphysql bash

# Volumes 

IMPORTANT : When you got an images, you can start a container from a Gisgraphy image. Once started, If you do some modifications on the files system of your container (e.g : remove or add a file) and then stop the container, when you will restart the container you will got the file system as it was in the initial image (before you remove / add the files).This is also true, if you run an import of data into Gisgraphy. After you stop your container, the data will be lost and you will have the file system identical to the initial image (before import) each time you restart your container.

If you want to keep your modifications (and import), you have to use volumes ar save your container state (commit / save). This is out of the scope of this tutorial and some documentation on how to use volumes can be found on the docker documentation.

If you save your container after the import is done, you will have the data stored in an other image. If you do an image with Gisgraphy + Data. you will get the data as it was after the import each time you restart your container. 

If you want to keep the log files, statistiques,and so on you have to use volumes.

# Premium
If you buy a dump of data, we provide you some tools to inject them. Once done, don't forget to do a new image and save the state of your container. A technical documentation is provided with the dump but here is the main lines :

To use the dump :
* Use Volume :
  * build an image or use the one on dockerhub
  * copy the files in assets/dump.
  * Run the script.
  * You will get a container with the data.
  * Save the image (if you don't you will loose all the imported data each time tou stop-start the container)

* Don't use volume
  * create volumes on postgres data dir and Solr data dir
  * build an image or use the one on dockerhub
  * run the bash script to inject it.
  * You will get the data imported identical each time you stop-start the container because it is stored in the volume (outside the images / container)






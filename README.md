
/!\ this repo is still in draft


We always try to ease the installation. We provide several Docker images for you to run Gisgraphy easily. All this stuff is given "as is" and with any waranty of any kind. This repository doesn't contain Docker images. Images are availables on Dockerhub at https://hub.docker.com/r/gisgraphy/gisgraphyofficial/

* [Install Docker](#Install-Docker)
* [Directories] (#Directories)
* [Images](#Images)
* [Volumes](#Volumes)
* [Premium](#premium)

# Install Docker

Even if it is out of the scope of Gisgraphy, we provide a script (install-docker.sh) that we use. It is designed to install docker on Ubuntu 16.04 (with Systemd).

# Directories
There is Two directories : 
* The base directory contain the files to install Gisgraphy.
* The dump directory contains the necessary files to inject the dump you can order at https://premium.gisgraphy.com. note that buying Premium dump allow you to avoid runing an import and is totally optionnal.

Both directories contains script (installation, inject dump,...) that can be run in a Docker container or not (the script named *-wo-docker.sh' can be run in a classic Linux distribution (Debian / Ubuntu)

# Images
## build
We provide an image called gisgraphyofficial : which have Java and Postgres / postgis installed and the Gisgraphy Database created, it install Gisgraphy (in /usr/local) and setup the database (create the tables in the database, insert gisgraphy users, create indexes). It also create an entrypoint that start Postgres and Gisgraphy servers.

An oficial image of gisgraphyofficial can be found at https://hub.docker.com/r/gisgraphy/gisgraphyofficial/

 you can personalize the Postgres password by specifying an arg :
```
docker build -t gisgraphyenv --build-arg PGPASSWORD=mdppostgres .
```
A script build.sh is provided to build the image. It download the Gisgraphy latest version and build the image.

## run
To run your image in a container
```
docker run -td   gisgraphyofficial bash
```
The script run.sh is provided to ease things

To run your container and open a shell in it : 
```
docker run -td  gisgraphyofficial bash
```
A script connect.sh take a docker container id as parameter and open a shell in it. If no container id is given, then it try to connect to a running container; if there is multiple container running. It fails.

you can personnalize the host at runtime :

docker run -td  -P --hostname=docker.gisgraphy.com  gisgraphyofficial bash

# Volumes 

IMPORTANT : When you got an images, you can start a container from a Gisgraphy image. Once started, If you do some modifications on the files system of your container (e.g : remove or add a file) and then stop the container, when you will restart the container you will got the file system as it was in the initial image (before you remove / add the files).This is also true, if you run an import of data into Gisgraphy. After you stop your container, the data will be lost and you will have the file system identical to the initial image (before import) each time you restart your container.

If you want to keep your modifications (and import), you have to use volumes ar save your container state (commit / save). This is out of the scope of this tutorial and some documentation on how to use volumes can be found on the docker documentation.

If you save your container after the import is done, you will have the data stored in an other image. If you do an image with Gisgraphy + Data. you will get the data as it was after the import each time you restart your container. 

If you want to keep the log files, statistiques,and so on you have to use volumes.

# Premium
If you buy a dump of data, we provide some tools to inject them. A technical documentation is provided with the dump and the documentation is available at http://www.gisgraphy.com/documentation/premium.php, but here are a cook book :

## with docker

To use the dump :
First add your dump files in the directory dump/assets/dump. Then you got two choices :

* Don't use volume :
  * build an image or use the one on dockerhub
  * Copy the files in dump/assets/dump.
  * cd to the dump directory and make the script runnable
  ```
  cd dump;chmod +x *.sh;cd ..
  ```
  * build the image (BASE_IMAGE is the name of your image)
  ```
 ./build.sh
  ```
  note : that it can take a while (the first message 'Sending build context to Docker daemon..' can also take a while)
  
  * You will get an image named 'gisgraphydump' with the data in it.
  * If you want to export the container, you can optionnaly use the script named exportandcompresscontainer.sh
  ```
  ./exportandcompresscontainer.sh
  ```
  
  Then you can start a container based on your image :
   
   ```
  ./run.sh
   ```

* Use Volume 
  * create volumes on postgres data dir (/var/lib/postgresql/9.5/main) and Solr data dir (/usr/local/gisgraphy/solr/data) . see https://docs.docker.com/engine/admin/volumes/volumes/ for more infos.
  
  
  * build an image or use the one on dockerhub
  * cd to the dump directory and make the script runnable
  ```
  cd dump;chmod +x *.sh
  ```
  * build the image (BASE_IMAGE is the name of your image)
  ```
  docker build -t gisgraphydump --build-arg PGPASSWORD=mdppostgres --build-arg BASE_IMAGE=gisgraphyofficial .
  ```
  note : that it can take a while (the first message 'Sending build context to Docker daemon..' can also take a while)
  
  * You will get the data stored in the volume you will get data identical, each time you stop-start the container because data are stored in the volume (outside the images / container)

## without docker
To inject the dump on a classical install (without docker), you simply have to clone or download this repository, add your files in /usr/local/dump/.
then cd to the dump directory and run :
```
chmod +x *.sh;cd dump;chmod +x ./assets/inject-dump.sh;cd ..;./inject-wo-docker.sh
```




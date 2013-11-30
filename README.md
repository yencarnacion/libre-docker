libre-docker
=============

Demo of `LIBRE App <https://github.com/commonwealth-of-puerto-rico/libre`_using_`Docker <https://www.docker.io/>`


Dockerfile
----------
Use this to build a new image

    $ sudo docker build .

With a tag for easier reuse

    $ sudo docker build  -t <your username>/libre-docker .

Running the container

    $ sudo docker run -d -p 8000:8000 <your username>/libre-docker

Now go to `<your ip>:8000` in your browser

The default username and password for the Docker image are:
Username: **admin** | Password: **libre**

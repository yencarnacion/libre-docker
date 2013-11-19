libre-docker
=============

Demo of LIBRE App using Docker


Dockerfile
----------
Use this to build a new image

    $ sudo docker build .

With a tag for easier reuse

    $ sudo docker build  -t <your username>/libre-docker .

Running the container

    $ sudo docker run -d -p :8000 <your username>/libre-docker

Now go to `<your ip>:8000` in your browser

Admin Username: admin | Admin Password: libre

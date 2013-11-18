FROM ubuntu:12.10
MAINTAINER Yamir Encarnacion "yencarnacion@webninjapr.com"
RUN apt-get -qq update
RUN apt-get install -y python-dev python-setuptools supervisor git-core libgdal
RUN easy_install pip
RUN pip install virtualenv
RUN pip install uwsgi
RUN virtualenv --no-site-packages /opt/ve/libredocker
ADD . /opt/apps/libredocker
ADD .docker/supervisor.conf /opt/supervisor.conf
ADD .docker/run.sh /usr/local/bin/run
RUN cd /opt/apps/
RUN git clone git@github.com:yencarnacion/libre.git
RUN cd libre
RUN git checkout update_admin_user
RUN /opt/ve/libredocker/bin/pip install -r /opt/apps/libre/libre/requirements.txt
RUN (cd /opt/apps/libre && /opt/ve/libredocker/bin/python manage.py syncdb --noinput)
RUN (cd /opt/apps/libre && /opt/ve/libredocker/bin/python manage.py migrate)
RUN (cd /opt/apps/libre && /opt/ve/libredocker/bin/python manage.py update_admin_user --username=admin --password=libre)
EXPOSE 8000
CMD ["/bin/sh", "-e", "/usr/local/bin/run"]

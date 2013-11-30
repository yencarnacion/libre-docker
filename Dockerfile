FROM ubuntu:12.10
MAINTAINER Yamir Encarnacion "yencarnacion@webninjapr.com"
RUN apt-get -qq update
RUN apt-get install -y python-dev python-setuptools supervisor git-core libgdal-dev 
RUN easy_install pip
RUN pip install virtualenv
RUN pip install uwsgi
RUN virtualenv --no-site-packages /opt/ve/libredocker
ADD . /opt/apps/libredocker
ADD templates/supervisor.conf /opt/supervisor.conf
ADD templates/run.sh /usr/local/bin/run
RUN (cd /opt/apps/ && git clone https://github.com/commonwealth-of-puerto-rico/libre.git)
RUN /opt/ve/libredocker/bin/pip install -r /opt/apps/libre/libre/requirements.txt
RUN (cd /opt/apps/libre && /opt/ve/libredocker/bin/python manage.py syncdb --noinput)
RUN (cd /opt/apps/libre && /opt/ve/libredocker/bin/python manage.py migrate)
RUN (cd /opt/apps/libre && /opt/ve/libredocker/bin/python manage.py update_admin_user --username=admin --password=libre)
ADD templates/settings_local.py /opt/apps/libre/settings_local.py
#RUN (cd /opt/apps/libre/ && /opt/ve/libredocker/bin/python manage.py collectstatic --noinput)
EXPOSE 8000
CMD ["/bin/sh", "-e", "/usr/local/bin/run"]

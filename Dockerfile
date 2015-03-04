#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM ubuntu:trusty
MAINTAINER Tim Sutton<tim@kartoza.com>, Gavin Fleming<gavin@kartoza.com>

# Use local cached debs from host (saves your bandwidth!)
# Change ip below to that of your apt-cacher-ng host
# Or comment this line out if you do not with to use caching
ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng

#-------------Application Specific Stuff ----------------------------------------------------
RUN apt-get -y -f install openjdk-7-jre  
#RUN apt-get install -y -f --force-yes tzdata=2014b-1
#RUN apt-get install tzdata
#RUN apt-get -y --force-yes remove tzdata; apt-get clean #; apt-get -y --force-yes autoremove
RUN apt-get install -q -y -f python python-pip python-lxml gdal-bin python-dev

RUN pip install geonode

RUN django-admin.py startproject project_name --template=https://github.com/GeoNode/geonode-project/archive/master.zip -epy,rst

WORKDIR project_name
RUN paver setup
EXPOSE 8000
CMD paver start -b 0.0.0.0:8000


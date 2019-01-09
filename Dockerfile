FROM ubuntu
RUN apt-get update
RUN apt-get install -y python
RUN echo 1.0 >> /etc/version && apt-get install -y git \
   && apt-get install -y iputils-ping

## WORKDIR ##
RUN mkdir /datos
WORKDIR /datos
RUN touch f1.txt
RUN mkdir /datos1
WORKDIR /datos1
RUN touch f2.txt

## COPY ##
COPY index.html .
COPY app.log /datos

## ADD ##
ADD docs docs
ADD f* /datos/
ADD f.tar .

## ENV ##
ENV dir=/data dir1=/data1
RUN mkdir $dir && mkdir $dir1

## ARG ##
# ARG dir2
# RUN mkdir $dir2
# ARG user
# ENV user_docker $user
# ADD add_user.sh /datos1
# RUN /datos1/add_user.sh

## EXPOSE ##
RUN apt-get install -y apache2
EXPOSE 80
ADD entrypoint.sh /datos1

## CMD ##
CMD /datos1/entrypoint.sh


## VOLUME ##
ADD paginas /var/www/html
VOLUME ["/var/www/html"]


## ENTRYPOINT ##
#ENTRYPOINT ["/bin/bash"]

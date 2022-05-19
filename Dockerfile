
FROM node:11

MAINTAINER Dongasai 1514582970@qq.com

ENV buildversion=3

#更新apt-get源 使用163的源
#RUN echo "deb http://mirrors.163.com/debian/ buster main non-free contrib" > /etc/apt/sources.list && \
#    echo "deb http://mirrors.163.com/debian/ buster-updates main non-free contrib " >> /etc/apt/sources.list  && \
#    echo "deb http://mirrors.163.com/debian/ buster-backports main non-free contrib " >> /etc/apt/sources.list && \
#    echo "deb-src http://mirrors.163.com/debian/ buster main non-free contrib " >> /etc/apt/sources.list && \
#    echo "deb-src http://mirrors.163.com/debian/ buster-updates main non-free contrib " >> /etc/apt/sources.list && \
#    echo "deb-src http://mirrors.163.com/debian/ buster-backports main non-free contrib " >> /etc/apt/sources.list  && \
#    echo "deb http://mirrors.163.com/debian-security/ buster/updates main non-free contrib  " >> /etc/apt/sources.list  && \
#    echo "deb-src http://mirrors.163.com/debian-security/ buster/updates main non-free contrib " >> /etc/apt/sources.list

RUN apt-get update;

RUN apt-get install -y git vim wget zip zlib1g-dev;

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm install -g yarn
RUN cnpm install -g nrm
RUN nrm use taobao
WORKDIR /var/www/html
COPY package.json /var/www/html/
COPY yarn.lock /var/www/html/

RUN yarn
COPY . /var/www/html/
RUN yarn build
#重置工作目录
WORKDIR /var/www/html

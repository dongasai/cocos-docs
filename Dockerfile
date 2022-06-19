
FROM node:11


ENV buildversion=4

#更新apt-get源 使用aliyun的源
RUN echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib" > /etc/apt/sources.list && \
   echo "deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib " >> /etc/apt/sources.list  && \
   echo "deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib " >> /etc/apt/sources.list && \
   echo "deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib " >> /etc/apt/sources.list && \
   echo "deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib " >> /etc/apt/sources.list && \
   echo "deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib " >> /etc/apt/sources.list  && \
   echo "deb http://mirrors.aliyun.com/debian-security/ buster/updates main non-free contrib  " >> /etc/apt/sources.list  && \
   echo "deb-src http://mirrors.aliyun.com/debian-security/ buster/updates main non-free contrib " >> /etc/apt/sources.list

RUN apt-get update;

RUN apt-get install -y git vim wget zip zlib1g-dev;

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm install -g yarn
RUN cnpm install -g nrm
RUN nrm use taobao
WORKDIR /var/www/html
RUN npm install gitbook-cli -g
COPY . /var/www/html/
RUN npm i
RUN gitbook install
RUN npm run build
#重置工作目录
WORKDIR /var/www/html

CMD [ "node" ,"http.js" ]
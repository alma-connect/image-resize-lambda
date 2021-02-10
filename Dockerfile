FROM amazonlinux:latest

ADD nodesource.gpg.key /etc

WORKDIR /tmp


RUN yum -y install gcc-c++ zip && \
    rpm --import /etc/nodesource.gpg.key && \
    curl --location --output ns.rpm https://rpm.nodesource.com/pub_12.x/el/7/x86_64/nodejs-12.0.0-1nodesource.x86_64.rpm && \
    rpm --checksig ns.rpm && \
    rpm --install --force ns.rpm && \
    npm install -g npm@latest && \
    npm cache clean --force && \
    yum clean all && \
    rm --force ns.rpm \
    npm install

COPY app /build/app/
COPY index.js config.js package.json /build/
WORKDIR /build

RUN npm install
RUN zip -FS -q -r lambda-package.zip *

FROM amazonlinux

ADD nodesource.gpg.key /etc

WORKDIR /tmp

RUN yum -y install gcc-c++ && \
    rpm --import /etc/nodesource.gpg.key && \
    curl --location --output ns.rpm https://rpm.nodesource.com/pub_10.x/el/7/x86_64/nodejs-10.16.0-1nodesource.x86_64.rpm && \
    rpm --checksig ns.rpm && \
    rpm --install --force ns.rpm && \
    npm install -g npm@latest && \
    npm cache clean --force && \
    yum clean all && \
    rm --force ns.rpm \
    npm install

WORKDIR /build

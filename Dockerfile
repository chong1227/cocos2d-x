FROM ubuntu:18.04

RUN apt-get -yqq update
RUN apt-get -yqq upgrade
RUN apt-get -yqq install software-properties-common \
 	openssl \ 
 	git \
 	locales \
 	unzip 
# 	g++ \
# 	libgdk-pixbuf2.0-dev \
# 	python-pip \
# 	cmake \
# 	libx11-dev \
# 	libxmu-dev \
# 	libglu1-mesa-dev \
# 	libgl2ps-dev \
# 	libxi-dev \
# 	libzip-dev \
# 	libpng-dev \
# 	libcurl4-gnutls-dev \
# 	libfontconfig1-dev \
# 	libsqlite3-dev \
# 	libglew-dev \
# 	libssl-dev \
# 	libgtk-3-dev \
# 	libglfw3 \
# 	libglfw3-dev \
# 	xorg-dev

RUN apt-get -yqq install wget 

WORKDIR /opt/
#ADD sdk-tools-linux-4333796.tar.gz /opt
#RUN \
#	wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
#	unzip sdk-tools-linux-4333796.zip && \
#	rm -rf sdk-tools-linux-4333796.zip

#ADD cocos2d-x-3.17.2.tar.gz /opt
#RUN \
#	wget https://digitalocean.cocos2d-x.org/Cocos2D-X/cocos2d-x-3.17.2.zip && \
#	unzip cocos2d-x-3.17.2.zip && \
#	rm -rf cocos2d-x-3.17.2.zip
#Ant
#RUN \
#	wget http://mirrors.tuna.tsinghua.edu.cn/apache//ant/binaries/apache-ant-1.10.7-bin.zip && \
#	unzip apache-ant-1.10.7-bin.zip && \
#	rm -rf apache-ant-1.10.7-bin.zip

#JDK
RUN \
    wget https://intl.midoci.com/SNOW/jdk-11.0.5_linux-x64_bin.tar.gz && \
    mkdir /var/cache/oracle-jdk11-installer-local/ && \
    cp jdk-11.0.5_linux-x64_bin.tar.gz /var/cache/oracle-jdk11-installer-local/

#RUN cd ./tools/bin && \
#	yes | ./sdkmanager --licenses && \
#	yes | ./sdkmanager --install 'platforms;android-28' && \
#	yes | ./sdkmanager --install ndk-bundle && \
#	yes | ./sdkmanager --install 'lldb;3.1'

RUN add-apt-repository ppa:linuxuprising/java && \
    echo oracle-java11-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections && \
    apt-get -yqq install oracle-java11-installer-local


# https://stackoverflow.com/questions/54500937/cocos2d-x-android-build-failed
#RUN apt-get -y install ninja-build

ENV ANDROID_SDK_ROOT=/opt
ENV NDK_ROOT=/opt/ndk-bundle
ENV COCOS_TEMPLATES_ROOT=/opt/cocos2d-x-3.17.2/templates
ENV COCOS_CONSOLE_ROOT=/opt/cocos2d-x-3.17.2/tools/cocos2d-console/bin
ENV ANT_ROOT=/opt/apache-ant-1.10.7/bin
ENV PATH ${ANDROID_SDK_ROOT}/tools:${ANDROID_SDK_ROOT}/platform-tools:${NDK_ROOT}:${COCOS_CONSOLE_ROOT}:${PATH}

WORKDIR /workspace

CMD /bin/bash

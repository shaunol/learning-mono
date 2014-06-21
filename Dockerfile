# Base OS
FROM centos:6.4
MAINTAINER shaunol

# Env setup
ENV HOME /root
WORKDIR ~/

# Build tools
RUN yum install -y git autoconf libtool gcc-c++ which gettext

# Mono install
# monolite is coming from my dropbox right now because xamarin cdn is down
RUN git clone https://github.com/mono/mono.git ~/mono && \
	cd ~/mono && \
	git checkout f2261b6 && \
	./autogen.sh --prefix=/usr --with-mcs-docs=no && \
	wget https://www.dropbox.com/s/ai1eadh617yyhan/monolite.tar.gz?dl=1 -O monolite.tar.gz && \
	tar -zxf monolite.tar.gz && \
	make EXTERNAL_MCS="~/mono/monolite/basic.exe" && \
	make install && \
	cd .. && \
	rm -rf ./mono
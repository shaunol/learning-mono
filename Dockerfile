# Base OS
FROM centos:6.4
MAINTAINER shaunol

# Env setup
ENV HOME /root
WORKDIR ~/

# Build deps
# mono deps: git, autoconf, libtool, gcc-c++, which, gettext
# K runtime deps: unzip
RUN yum install -y git autoconf libtool gcc-c++ which gettext unzip

# Mono install
# monolite is coming from my dropbox because the xamarin cdn is unreliable
RUN git clone git://github.com/mono/mono ~/mono && \
	cd ~/mono && \
	git reset --hard afa2f52 && \
	./autogen.sh --prefix=/usr --with-mcs-docs=no && \
	make monolite_url=https://dl.dropbox.com/s/z00qa9cmbymjjlz/monolite-111-latest.tar.gz get-monolite-latest && \
	make && \
	make install && \
	cd ~/ && \
	rm -rf ~/mono
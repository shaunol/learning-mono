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
# I've split the clone & revision reset commands to make upgrading to new revisions a little quicker (possibly?)
RUN git clone git://github.com/mono/mono ~/mono
WORKDIR ~/mono
RUN	git reset --hard afa2f52 && \
	./autogen.sh --prefix=/usr --with-mcs-docs=no && \
	make monolite_url=https://dl.dropbox.com/s/z00qa9cmbymjjlz/monolite-111-latest.tar.gz get-monolite-latest && \
	make && \
	make install && \
	cd ~/ && \
	rm -rf ~/mono
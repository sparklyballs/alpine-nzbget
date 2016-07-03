FROM lsiobase/alpine
MAINTAINER sparklyballs

# install packages
RUN \
 apk add --no-cache \
	curl \
	p7zip \
	python \
	unrar \
	wget

# install nzbget
RUN \
 curl -o \
 /tmp/json -L \
	http://nzbget.net/info/nzbget-version-linux.json && \
 NZBGET_VERSION=$(grep stable-download /tmp/json  | cut -d '"' -f 4) && \
 curl -o \
 /tmp/nzbget.run -L \
	"${NZBGET_VERSION}" && \
 sh /tmp/nzbget.run --destdir /app && \

# cleanup
 rm -rfv \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads
EXPOSE 6789

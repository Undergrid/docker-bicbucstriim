FROM undergrid/alpine-apache:3.13
MAINTAINER nick+docker@undergrid.org.uk

#install packages
RUN \
  echo "**** install php packages ****" && \
  apk add --no-cache \
	php7-sqlite3 \
	php7-gd \
	php7-intl \
	php7-dom \
	php7-xml \
	php7-xmlwriter \
	php7-pdo \
	php7-pdo_sqlite \
	php7-session \
	php7-ctype \
	php7-mcrypt \
	php7-mbstring \
	php7-json \
	php7-openssl \
	git && \
  echo "**** install app *****" && \
	git clone -b v1.5.3 https://github.com/rvolz/BicBucStriim.git /app/ 

#add local files
COPY root/ /

#ports and volumes
EXPOSE 80 443
VOLUME /config /books

FROM lsiobase/alpine:3.13

ENV \
	TZ=UTC \
	MMONIT_URL=

# Add configuration files
COPY root /

# Set up
RUN \
echo "*** update packages and install monit ****" && \
	apk update && \
	apk add monit && \
echo "*** set permissions ***" && \
	chmod 600 /etc/monitrc 

EXPOSE 2812

VOLUME /config

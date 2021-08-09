#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# AUTHOR  :  Bruni Emiliano
# DATE    :  2021-07-28
# PURPOSE :
#   This Docker File is used to generate a docker image with all necessary
# components required to ebruni Mojo::Leds [https://metacpan.org/pod/Mojo::Leds]
# framework components
#
#   This image is published in docker hub with handle: ebruni/mojo-leds
#
# USAGE:
#   docker build -t mojo-leds .
#
# UPDATES:
#   AUTHOR          DATE        VERSION      COMMENTS
#   Bruni Emiliano  2021-08-09  1.1          Create default app
#   Bruni Emiliano  2021-07-29  1.0          Initial Version
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#

# Using Alphine linux as base image
FROM alpine:3.14
MAINTAINER Bruni Emiliano <info@ebruni.it>

# Expose all default Mojolicious Ports
EXPOSE 3000 9091

# Install all necessary packages required by Mojo-Leds
RUN apk update && apk add --no-cache make gcc perl-dev perl-app-cpanminus \
    perl-module-build perl-namespace-clean perl-boolean perl-json-maybexs \
    perl-test-fatal perl-path-tiny perl-moo perl-file-find-rule \
    perl-number-compare perl-text-glob

# For getting the latest wget
RUN apk update && apk add ca-certificates && update-ca-certificates && apk add wget

# Install Mojo::Leds
RUN cpanm Mojo::Leds

ENV APPCLASS=${app:-MyApp}
ENV APPDIR=my_app

RUN mkdir -p /var/www/
# Set the working directory to mojolicious directory created above
WORKDIR /var/www

# generate Mojo app directory strucecho $0ture
RUN mojo generate leds_app $APPCLASS

# calculate app directory decamelizing its class name
#RUN perl -MMojo::Util -e "print 'export APPDIR=' . Mojo::Util::decamelize $APPCLASS" >> .env
#ENV ENV=".env"

# Set the working directory to mojolicious directory created above
WORKDIR /var/www/${APPDIR}

# Start app
CMD ["hypnotoad", "-f", "script/my_app"]

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
#   Bruni Emiliano  2021-07-29  1.0          Initial Version
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#

# Using Alphine linux as base image
FROM alpine:3.14
MAINTAINER Bruni Emiliano <info@ebruni.it>

# Expose all default Mojolicious Ports
EXPOSE 8080 3000

RUN mkdir -p /var/www

# Install all necessary packages required by Mojo-Leds
RUN apk update && apk add --no-cache make gcc perl-dev perl-app-cpanminus \
    perl-module-build perl-namespace-clean perl-boolean perl-json-maybexs \
    perl-test-fatal perl-path-tiny perl-moo perl-file-find-rule \
    perl-number-compare perl-text-glob

# For getting the latest wget
RUN apk update && apk add ca-certificates && update-ca-certificates && apk add wget

# Install Mojo::Leds
RUN cpanm Mojo::Leds

# Set the working directory to mojolicious directory created above
WORKDIR /var/www

# Run a shell as the default command
CMD ["/bin/sh"]

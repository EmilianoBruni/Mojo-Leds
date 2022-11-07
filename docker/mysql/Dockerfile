# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# AUTHORS :  Emiliano Bruni (EB) <info@ebruni.it>
# DATE    :  2022-07-13
# PURPOSE :
#   Docker image with all necessary components required to Mojo::Leds [https://metacpan.org/pod/Mojo::Leds] framework components .
#
#   This image is published in docker hub with handle: ebruni/mojo-leds
#
# USAGE:
#   docker build -t mojo-leds .
#
# UPDATES:
#   AUTHOR  DATE        VER  COMMENTS
#   EB      2022-07-13  1.18  Includes mysql options
#   EB      2022-06-08  1.17  Update to Mojo::Leds v.1.15
#   EB      2022-06-07  1.16  Update to Mojolicious v.9.26
#   EB      2022-06-07  1.15  Update to Mojo::Leds v.1.14
#   EB      2022-06-01  1.14  Update to Mojo::Leds v.1.13
#   EB      2022-02-24  1.13  Update to Minion::Backend::MongoDB v.1.14 and Mojolicious v. 9.22
#   EB      2022-01-17  1.12  Update to Minion::Backend::MongoDB v.1.13
#   EB      2021-12-16  1.11  Update to M::P::AutoRoutePm v.0.23
#   EB      2021-11-22  1.10  Update to M::P::AutoRoutePm v.0.22
#   EB      2021-11-17  1.09  Update to Mojo::Leds v.1.12
#   EB      2021-11-04  1.08  Update to Minion::Backend::MongoDB v.1.12
#   EB      2021-09-24  1.07  Update to Mojo::Leds v.1.11 and backend v.1.10
#   EB      2021-09-20  1.06  Update to Mojo::Leds 1.10
#   EB      2021-09-09  1.05  Update to latest parent container
#   EB      2021-09-07  1.04  Update to latest mojolicious:minion
#   EB      2021-08-24  1.03  Reduced image size
#   EB      2021-08-23  1.02  Standard starup & mongodb/micso tags
#   EB      2021-08-09  1.01  Create default app
#   EB      2021-07-29  1.0  Initial Version
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#

#
# this file is generated via docker-builder
#
# do not edit it directly
#
FROM ebruni/mojolicious:mysql
MAINTAINER Emiliano Bruni <info@ebruni.it>

WORKDIR /var/www
EXPOSE 3000 9091

RUN apk update && apk add --no-cache \
    make \
    gcc \
    perl-dev \
  && cpanm --no-wget -n \
    Mojo::Leds \
  && rm -r /root/.cpanm \
  && apk del \
    make \
    gcc \
    perl-dev \
  && true

ARG NOW=not-set
LABEL org.opencontainers.image.authors="Emiliano Bruni <info@ebruni.it>"
LABEL org.opencontainers.image.created=$NOW
LABEL org.opencontainers.image.description="docker image with all necessary components required to Mojo::Leds [https://metacpan.org/pod/Mojo::Leds] framework components ."
LABEL org.opencontainers.image.documentation=https://github.com/EmilianoBruni/Mojo-Leds/blob/master/README.pod
LABEL org.opencontainers.image.licenses=Artistic-2.0
LABEL org.opencontainers.image.source=https://github.com/EmilianoBruni/Mojo-Leds/blob/master/mysql/Dockerfile
LABEL org.opencontainers.image.title=Mojo::Leds
LABEL org.opencontainers.image.url=https://github.com/EmilianoBruni/Mojo-Leds
LABEL org.opencontainers.image.version=1.18-mysql

CMD ["/bin/bash", "-c"]
